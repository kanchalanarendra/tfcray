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

# --------------------------
# Access Policy for SPN/User
# --------------------------
resource "azurerm_key_vault_access_policy" "fsdu_kv_policy" {
  key_vault_id = azurerm_key_vault.fsdu_keyvault.id
  tenant_id    = var.tenant_id
  object_id    = var.object_id   # User / SPN / Managed Identity object ID

  key_permissions = [
    "Get",
    "List",
    "Create",
    "Delete",
    "Update",
    "Recover",
    "Backup",
    "Restore"
  ]

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Recover",
    "Backup",
    "Restore"
  ]

  certificate_permissions = [
    "Get",
    "List",
    "Create",
    "Delete",
    "Update",
    "Import"
  ]

  storage_permissions = [
    "Get",
    "List",
    "Delete",
    "Set",
    "Update",
    "RegenerateKey"
  ]
}
