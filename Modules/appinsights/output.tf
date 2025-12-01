output "app_insights_id" {
  description = "The ID of the Application Insights resource"
  value       = azurerm_application_insights.fsdu_appinsights.id
}

output "app_insights_name" {
  description = "The name of the Application Insights resource"
  value       = azurerm_application_insights.fsdu_appinsights.name
}

output "instrumentation_key" {
  description = "The Instrumentation Key for this Application Insights component"
  value       = azurerm_application_insights.fsdu_appinsights.instrumentation_key
  sensitive   = true
}

output "connection_string" {
  description = "The Connection String for this Application Insights component"
  value       = azurerm_application_insights.fsdu_appinsights.connection_string
  sensitive   = true
}
