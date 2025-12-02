output "openai_endpoint" {
  description = "Endpoint URL for the OpenAI cognitive account"
  value       = azurerm_cognitive_account.fsdu_openai.endpoint
}

output "openai_account_id" {
  description = "Resource ID of the OpenAI cognitive account"
  value       = azurerm_cognitive_account.fsdu_openai.id
}

output "model_deployment_id" {
  description = "Resource ID of the model deployment"
  value       = azapi_resource.fsdu_openai_model_deployment.id
}

output "openai_primary_access_key" {
  description = "Primary access key for OpenAI account"
  value       = azurerm_cognitive_account.fsdu_openai.primary_access_key
  sensitive   = true
}
output "aifoundry_workspace_id" {
  description = "Resource ID of the Azure AI Foundry workspace"
  value       = azapi_resource.fsdu_ai_foundry.id
}

