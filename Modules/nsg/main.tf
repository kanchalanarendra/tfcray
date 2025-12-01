resource "azurerm_network_security_group" "fsdu_nsg" {
  for_each            = var.subnets
  name                = "nsg-${var.project_name}-${each.key}-${var.environment}"
  location            = var.location
  resource_group_name = var.resourcegroupname
}

resource "azurerm_subnet_network_security_group_association" "fsdu_nsg_association" {
  for_each                  = var.subnets
  depends_on                = [azurerm_network_security_group.fsdu_nsg]
  subnet_id                 = each.value.subnet_id
  network_security_group_id = azurerm_network_security_group.fsdu_nsg[each.key].id
}