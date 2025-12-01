resource "azurerm_resource_group" "fsdu-rg" {
  name     = var.resourcegroupname
  location = var.location
  tags     = var.tags
}