resource "azurerm_static_web_app" "fsdu_static_web_app" {
  name                = var.static_web_app_name
  resource_group_name = var.resourcegroupname
  location            = var.location

}