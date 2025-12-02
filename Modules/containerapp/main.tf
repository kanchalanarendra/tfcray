resource "azurerm_container_app_environment" "fsdu_container_environment" {
  name                           = var.container_environment_name
  location                       = var.location
  resource_group_name            = var.resourcegroupname
  # Internal Load Balancer enabled: Traffic routed through internal ALB only
  # No external/public access possible
  internal_load_balancer_enabled = var.internal_load_balancer_enabled
  infrastructure_subnet_id       = var.subnet_id
}

resource "azurerm_container_app" "fsdu_container_app" {
  name                         = var.container_app_name
  container_app_environment_id = azurerm_container_app_environment.fsdu_container_environment.id
  resource_group_name          = var.resourcegroupname
  revision_mode                = "Single"

  identity {
    type         = "UserAssigned"
    identity_ids = [var.managed_identity_id]
  }

  ingress {
    # External access disabled: Internal-only access through ALB/API Gateway
    external_enabled = var.external_enabled
    target_port      = var.target_port

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  template {
    container {
      name   = var.container_name
      # Use production image from ACR with managed identity authentication
      # Requires: managed identity with AcrPull role assigned to ACR
      image  = var.use_acr_image ? "${var.acr_login_server}/${var.acr_image_name}" : "mcr.microsoft.com/k8se/quickstart:latest"
      cpu    = var.cpu
      memory = var.memory
    }
  }
}