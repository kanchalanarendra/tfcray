output "user_assigned_identity_principal_id" {
  description = "The Principal ID of the User Assigned Managed Identity"
  value       = azurerm_user_assigned_identity.fsdu_backend_MID.principal_id
}
output "user_assigned_identity_client_id" {
  description = "The Client ID of the User Assigned Managed Identity"
  value       = azurerm_user_assigned_identity.fsdu_backend_MID.client_id
}
output "user_assigned_identity_id" {
  description = "The ID of the User Assigned Managed Identity"
  value       = azurerm_user_assigned_identity.fsdu_backend_MID.id
}
