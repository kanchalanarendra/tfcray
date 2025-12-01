# ----------------------------
# Create User Assigned Managed Identity
# ----------------------------
resource "azurerm_user_assigned_identity" "fsdu_backend_MID" {
  name                = var.backend_mid_name
  resource_group_name = var.resourcegroupname
  location            = var.location
}

# ----------------------------
# Key Vault Access
# ----------------------------
resource "azurerm_key_vault_access_policy" "fsdu_kv_access" {
  key_vault_id = var.keyvault_id
  tenant_id    = var.tenant_id
  object_id    = azurerm_user_assigned_identity.fsdu_backend_MID.principal_id

  secret_permissions = ["Get", "List"]
  key_permissions    = ["Get", "List"]
}

# ----------------------------
# Storage Account Role Assignment
# ----------------------------
# SKIPPED - Requires User Access Administrator permissions
# resource "azurerm_role_assignment" "fsdu_storage_access" {
#   scope                = var.storage_account_id
#   role_definition_name = "Storage Blob Data Contributor"
#   principal_id         = azurerm_user_assigned_identity.fsdu_backend_MID.principal_id
# }

# ----------------------------
# AI Foundry / Azure ML Workspace Access
# ----------------------------
# SKIPPED - Requires User Access Administrator permissions
# resource "azurerm_role_assignment" "fsdu_ai_foundry_access" {
#   scope                = var.ai_foundry_id
#   role_definition_name = "Contributor"
#   principal_id         = azurerm_user_assigned_identity.fsdu_backend_MID.principal_id
# }

# ----------------------------
# Cosmos DB Role Assignment
# ----------------------------
# SKIPPED - Requires User Access Administrator permissions
# resource "azurerm_role_assignment" "fsdu_cosmos_access" {
#   scope                = var.cosmos_id
#   role_definition_name = "Cosmos DB Account Reader Role" # or Contributor depending on need
#   principal_id         = azurerm_user_assigned_identity.fsdu_backend_MID.principal_id
# }

# SKIPPED - Requires User Access Administrator permissions
# resource "azurerm_role_assignment" "fsdu_backend_acr_pull" {
#   scope                = var.acr_id
#   role_definition_name = "AcrPull"
#   principal_id         = azurerm_user_assigned_identity.fsdu_backend_MID.principal_id
# }


