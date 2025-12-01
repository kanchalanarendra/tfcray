resource "azurerm_container_registry" "fsdu_acr" {
  name                = var.acr_name
  resource_group_name = var.resourcegroupname
  location            = var.location

  sku = "Premium"

  admin_enabled                 = false
  zone_redundancy_enabled       = true
  public_network_access_enabled = false
  tags                          = var.tags
}
