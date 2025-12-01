output "openai_endpoint" {
  value = azurerm_cognitive_account.fsdu_openai.endpoint
}

# output "ai_foundry_workspace_id" {
#   value = azapi_resource.fsdu_ai_foundry.id
# }

output "model_deployment_id" {
  value = azapi_resource.fsdu_openai_model_deployment.id
}
output "openai_account_id" {
  value = azurerm_cognitive_account.fsdu_openai.id
}
