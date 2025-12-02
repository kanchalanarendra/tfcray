data "azurerm_client_config" "current" {}


module "ResourceGroup" {
  source = "./Modules/resourcegroup"
  for_each = var.rg_prefixes
  resourcegroupname = "rg-${local.project_name}-${each.value}-${var.environment}"
  location = var.location
  tags = var.tags
}

module "VirtualNetwork" {
  source = "./Modules/virtualnetwork"
  depends_on        = [ module.ResourceGroup ]
  vnetname          = "vnet-${local.project_name}-${var.environment}"
  resourcegroupname = module.ResourceGroup["network"].rgname
  location          = module.ResourceGroup["network"].location
  address_space     = var.address_space
  subnets           = var.subnets
  environment       = var.environment
  project_name      = local.project_name
  tags              = var.tags
}

module "nsg" {
  source              = "./Modules/nsg"
  depends_on          = [ module.VirtualNetwork ]
  location            = module.ResourceGroup["network"].location
  resourcegroupname   = module.ResourceGroup["network"].rgname
  project_name        = local.project_name
  environment         = var.environment
  subnets             = module.VirtualNetwork.subnets
}


module "storageaccount" {
  source = "./Modules/storageaccount"
  storageaccountname = "storgae${local.project_name}${var.environment}"
  location = module.ResourceGroup["storage"].location
  resourcegroupname = module.ResourceGroup["storage"].rgname
  account_tier = var.storage_account_tier
  account_replication_type = var.account_replication_type
  tags = var.tags
  storagecontainername = "container-${local.project_name}-${var.environment}"
}

module "storage_blob_container" {
  source = "./Modules/storageblob"
  storagecontainername = "container-${local.project_name}-${var.environment}"
  storageaccountid = module.storageaccount.storage_account_id
  storage_account_name = module.storageaccount.storage_account_name
  create_container = false
  private_endpoint_dependency = [ module.private_endpoints.private_endpoint_ids["storage_blob_pe"] ]
  
  depends_on = [module.storageaccount]
}

# Lock down storage account after container is created
resource "azurerm_storage_account_network_rules" "storage_network_lockdown" {
  storage_account_id = module.storageaccount.storage_account_id

  default_action = "Deny"
  bypass         = ["AzureServices"]

  depends_on = [module.storage_blob_container]
}

module "keyvault" {
  source = "./Modules/keyvault"
  keyvaultname = "keyvlt-${local.project_name}-${var.environment}"
  resourcegroupname = module.ResourceGroup["storage"].rgname
  location = module.ResourceGroup["storage"].location
  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_client_config.current.object_id
}

module "cosmosdb" {
  source = "./Modules/cosmosdb"
  cosmos_db_name = "cosmosdb-${local.project_name}-${var.environment}"
  cosmosdb_account_name = "cosmos-${local.project_name}-${var.environment}"
  resourcegroupname = module.ResourceGroup["storage"].rgname
  location = module.ResourceGroup["storage"].location
  cosmos_sql_container_name = "dbcontainer-${local.project_name}-${var.environment}"
}

module "acr" {
  source = "./Modules/acr"
  acr_name = "accr${local.project_name}${var.environment}"
  resourcegroupname = module.ResourceGroup["backend"].rgname
  location = module.ResourceGroup["backend"].location
  tags = var.tags
}

module "containerapp" {
  source = "./Modules/containerapp"
  container_environment_name = "env-${local.project_name}-${var.environment}"
  container_app_name = "app-${local.project_name}-${var.environment}"
  container_name = "app-${local.project_name}-${var.environment}"
  resourcegroupname = module.ResourceGroup["backend"].rgname
  location = module.ResourceGroup["backend"].location
  subnet_id = module.VirtualNetwork.subnets["backend"].subnet_id
  managed_identity_id = module.managedidentity.backend_identity_id
  cpu = var.cpu
  memory = var.memory
}

module "staticwebapp" {
  source = "./Modules/staticwebapp"
  static_web_app_name = "staticwebapp-${local.project_name}-${var.environment}"
  resourcegroupname = module.ResourceGroup["frontend"].rgname
  location = module.ResourceGroup["frontend"].location
}

module "openai" {
  source = "./Modules/openai"
  
  openainame              = "ai-${local.project_name}-${var.environment}"
  modeldeploymentname     = "modeldeployment-${local.project_name}-${var.environment}"
  resourcegroupname       = module.ResourceGroup["ai"].rgname
  location                = module.ResourceGroup["ai"].location
  model_name              = var.openai_model_id
  model_version           = "2024-07-18"
  aifoundryname          = "aifndry-${local.project_name}-${var.environment}"
  resource_group_id       = module.ResourceGroup["ai"].id
  storage_account_id      = module.storageaccount.storage_account_id
  keyvault_id             = module.keyvault.keyvault_id
  app_insights_id         = module.app_insights.app_insights_id

}

module "app_insights" {
  source = "./Modules/appinsights"
  appinsights_name = "appi-${local.project_name}-${var.environment}"
  resourcegroupname = module.ResourceGroup["ai"].rgname
  location = module.ResourceGroup["ai"].location
}

module "private_endpoints" {
  source = "./Modules/privateendpoint"
  depends_on = [ module.VirtualNetwork, module.openai, module.storageaccount, module.cosmosdb, module.keyvault ]
  location            = module.ResourceGroup["network"].location
  resourcegroupname = module.ResourceGroup["network"].rgname
   private_endpoints = {
    keyvault_pe = {
      name              = "pe-${local.project_name}-keyvault-${var.environment}"
      subnet_id         = module.VirtualNetwork.subnet_ids["storage"]
      resource_id       = module.keyvault.keyvault_id
      subresource_names = ["vault"]
    }

    storage_blob_pe = {
      name              = "pe-${local.project_name}-storageblob-${var.environment}"
      subnet_id         = module.VirtualNetwork.subnet_ids["storage"]
      resource_id       = module.storageaccount.storage_account_id
      subresource_names = ["blob"]
    }

    cosmos_pe = {
      name              = "pe-${local.project_name}-cosmosdb-${var.environment}"
      subnet_id         = module.VirtualNetwork.subnet_ids["storage"]
      resource_id       = module.cosmosdb.cosmosdb_account_id
      subresource_names = ["Sql"]
    }

    openai_pe = {
      name              = "pe-${local.project_name}-openai-${var.environment}"
      subnet_id         = module.VirtualNetwork.subnet_ids["ai"]
      resource_id       = module.openai.openai_account_id
      subresource_names = ["account"]
    }
  }
 }

module "managedidentity" {
  source = "./Modules/managedidentity"
  
  managed_identities = {
    staticwebapp = {
      name                = "mi-staticwebapp-${local.project_name}-${var.environment}"
      has_keyvault_access = false
      has_storage_access  = false
      has_cosmos_access   = false
      has_openai_access   = false
      has_acr_access      = false
    }
    backend = {
      name                = "mi-backend-${local.project_name}-${var.environment}"
      has_keyvault_access = true
      has_storage_access  = true
      has_cosmos_access   = true
      has_openai_access   = true
      has_acr_access      = true
    }
  }
  resourcegroupname      = module.ResourceGroup["backend"].rgname
  location               = module.ResourceGroup["backend"].location
  storage_account_id     = module.storageaccount.storage_account_id
  acr_id                 = module.acr.acr_id
  openai_id              = module.openai.openai_account_id
  cosmos_id              = module.cosmosdb.cosmosdb_account_id
  ai_foundry_id          = null
  tenant_id              = data.azurerm_client_config.current.tenant_id
  keyvault_id            = module.keyvault.keyvault_id
  
}

