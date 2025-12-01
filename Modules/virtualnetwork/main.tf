resource "azurerm_virtual_network" "fsdu_vnet" {
  name                = var.vnetname
  location            = var.location
  resource_group_name = var.resourcegroupname
  address_space       = var.address_space
  tags                = var.tags
}

resource "azurerm_subnet" "fsdu_subnet" {
  for_each             = var.subnets
  name                 = "snet-${var.project_name}-${each.key}-${var.environment}"
  resource_group_name  = var.resourcegroupname
  virtual_network_name = azurerm_virtual_network.fsdu_vnet.name
  address_prefixes     = each.value.address_prefixes

  private_endpoint_network_policies = "Enabled"

}
