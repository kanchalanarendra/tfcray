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
# Key Vault Access - Only for identities with has_keyvault_access = true
# ----------------------------
resource "azurerm_key_vault_access_policy" "fsdu_kv_access" {
  for_each = {
    for key, identity in azurerm_user_assigned_identity.fsdu_mid :
    key => identity if var.managed_identities[key].has_keyvault_access
  }
  
  key_vault_id = var.keyvault_id
  tenant_id    = var.tenant_id
  object_id    = each.value.principal_id

  secret_permissions = ["Get", "List"]
  key_permissions    = ["Get", "List"]
}

# # ----------------------------
# # Storage Account Role Assignment
# # ----------------------------
resource "azurerm_role_assignment" "fsdu_storage_access" {
  for_each = {
    for key, identity in azurerm_user_assigned_identity.fsdu_mid :
    key => identity if var.managed_identities[key].has_storage_access
  }
  
  scope                = var.storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = each.value.principal_id
}

# # ----------------------------
# # Cosmos DB Role Assignment
# # ----------------------------
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


