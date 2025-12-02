# ----------------------------
# Get Current Azure Client Config
# ----------------------------
data "azurerm_client_config" "current" {}

# ----------------------------
# Create User Assigned Managed Identities
# ----------------------------
resource "azurerm_user_assigned_identity" "fsdu_mid" {
  for_each            = var.managed_identities
  name                = each.value.name
  resource_group_name = var.resourcegroupname
  location            = var.location
}

# ----------------------------
# Key Vault Access - Bootstrap Only (commented for removal after initial setup)
# Permanent access is managed via RBAC roles instead
# ----------------------------
# Uncomment this block ONLY during initial bootstrap, then remove after deployment
resource "azurerm_key_vault_access_policy" "bootstrap_admin" {
  key_vault_id = var.keyvault_id
  tenant_id    = var.tenant_id
  object_id    = data.azurerm_client_config.current.object_id  # Replace with your admin/service principal OID

  secret_permissions = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"]
  key_permissions    = ["Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey"]
}

# ----------------------------
# Key Vault RBAC Role Assignments - For Ongoing Access
# ----------------------------
# Only identities with has_keyvault_access = true get Key Vault Secrets User role
resource "azurerm_role_assignment" "fsdu_kv_secrets_user" {
  for_each = {
    for key, identity in azurerm_user_assigned_identity.fsdu_mid :
    key => identity if var.managed_identities[key].has_keyvault_access
  }
  
  scope              = var.keyvault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id       = each.value.principal_id
}

# ----------------------------
# Storage Account Role Assignment
# ----------------------------
resource "azurerm_role_assignment" "fsdu_storage_access" {
  for_each = {
    for key, identity in azurerm_user_assigned_identity.fsdu_mid :
    key => identity if var.managed_identities[key].has_storage_access
  }
  
  scope                = var.storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = each.value.principal_id
}

# ----------------------------
# Cosmos DB Role Assignment
# ----------------------------
resource "azurerm_role_assignment" "fsdu_cosmos_access" {
  for_each = {
    for key, identity in azurerm_user_assigned_identity.fsdu_mid :
    key => identity if var.managed_identities[key].has_cosmos_access
  }
  
  scope                = var.cosmos_id
  role_definition_name = "Cosmos DB Account Reader Role"
  principal_id         = each.value.principal_id
}

# ----------------------------
# OpenAI Role Assignment
# ----------------------------
resource "azurerm_role_assignment" "fsdu_openai_access" {
  for_each = {
    for key, identity in azurerm_user_assigned_identity.fsdu_mid :
    key => identity if var.managed_identities[key].has_openai_access
  }
  
  scope                = var.openai_id
  role_definition_name = "Cognitive Services OpenAI User"
  principal_id         = each.value.principal_id
}

# ----------------------------
# ACR (Container Registry) Role Assignment
# ----------------------------
resource "azurerm_role_assignment" "fsdu_acr_access" {
  for_each = {
    for key, identity in azurerm_user_assigned_identity.fsdu_mid :
    key => identity if var.managed_identities[key].has_acr_access
  }
  
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = each.value.principal_id
}


