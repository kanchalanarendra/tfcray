# All Managed Identities
output "managed_identities" {
  description = "Map of all created managed identities with their details"
  value = {
    for key, identity in azurerm_user_assigned_identity.fsdu_mid : key => {
      id           = identity.id
      principal_id = identity.principal_id
      client_id    = identity.client_id
    }
  }
}

# Static Web App Managed Identity (convenient direct access)
output "staticwebapp_identity_id" {
  description = "The ID of the Static Web App managed identity"
  value       = try(azurerm_user_assigned_identity.fsdu_mid["staticwebapp"].id, null)
}

output "staticwebapp_identity_principal_id" {
  description = "The Principal ID of the Static Web App managed identity"
  value       = try(azurerm_user_assigned_identity.fsdu_mid["staticwebapp"].principal_id, null)
}

output "staticwebapp_identity_client_id" {
  description = "The Client ID of the Static Web App managed identity"
  value       = try(azurerm_user_assigned_identity.fsdu_mid["staticwebapp"].client_id, null)
}

# Backend Container App Managed Identity (convenient direct access)
output "backend_identity_id" {
  description = "The ID of the Backend (Storage/KeyVault/Cosmos) managed identity"
  value       = try(azurerm_user_assigned_identity.fsdu_mid["backend"].id, null)
}

output "backend_identity_principal_id" {
  description = "The Principal ID of the Backend managed identity"
  value       = try(azurerm_user_assigned_identity.fsdu_mid["backend"].principal_id, null)
}

output "backend_identity_client_id" {
  description = "The Client ID of the Backend managed identity"
  value       = try(azurerm_user_assigned_identity.fsdu_mid["backend"].client_id, null)
}

