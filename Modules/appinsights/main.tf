resource "azurerm_application_insights" "fsdu_appinsights" {
  name                = var.appinsights_name
  location            = var.location
  resource_group_name = var.resourcegroupname
  application_type    = var.application_type
  
  lifecycle {
    ignore_changes = [workspace_id]
  }
}
