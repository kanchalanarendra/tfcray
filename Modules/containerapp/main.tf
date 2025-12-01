resource "azurerm_container_app_environment" "fsdu_container_environment" {
  name                           = var.container_environment_name
  location                       = var.location
  resource_group_name            = var.resourcegroupname
  internal_load_balancer_enabled = true
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
    external_enabled = false
    target_port      = 80

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  template {
    container {
      name   = var.container_name
      image  = "mcr.microsoft.com/k8se/quickstart:latest"
      cpu    = var.cpu
      memory = var.memory
    }
  }
}