output "container_app_id" {
  value       = azurerm_container_app.fsdu_container_app.id
  description = "Container App resource ID"
}

output "container_app_name" {
  value       = azurerm_container_app.fsdu_container_app.name
  description = "Container App name"
}

output "container_app_environment_id" {
  value       = azurerm_container_app_environment.fsdu_container_environment.id
  description = "Container App Environment resource ID"
}

output "container_app_environment_name" {
  value       = azurerm_container_app_environment.fsdu_container_environment.name
  description = "Container App Environment name"
}

output "container_app_fqdn" {
  value       = azurerm_container_app.fsdu_container_app.ingress[0].fqdn
  description = "Fully qualified domain name (FQDN) of the container app"
}

output "acr_image_used" {
  value       = var.use_acr_image ? "${var.acr_login_server}/${var.acr_image_name}" : "mcr.microsoft.com/k8se/quickstart:latest"
  description = "Container image URL in use"
}
