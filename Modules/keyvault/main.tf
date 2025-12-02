resource "azurerm_key_vault" "fsdu_keyvault" {
  name                        = var.keyvaultname
  location                    = var.location
  resource_group_name         = var.resourcegroupname
  tenant_id                   = var.tenant_id

  sku_name                    = "standard"
  purge_protection_enabled    = true
  public_network_access_enabled = false
  soft_delete_retention_days  = 90
  enable_rbac_authorization   = true

  network_acls {
    default_action             = "Deny"
    bypass                     = "AzureServices"
  }
}

