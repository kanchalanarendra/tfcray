resource "azurerm_key_vault" "fsdu_keyvault" {
  name                        = var.keyvaultname
  location                    = var.location
  resource_group_name         = var.resourcegroupname
  tenant_id                   = var.tenant_id

  sku_name                    = "standard"
  purge_protection_enabled    = false
  public_network_access_enabled = false

  network_acls {
    default_action             = "Deny"
    bypass                     = "AzureServices"
  }
}

