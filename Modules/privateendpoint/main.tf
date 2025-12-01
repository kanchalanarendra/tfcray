resource "azurerm_private_endpoint" "fsdu_private_endpoint" {
  for_each            = var.private_endpoints
  name                = each.value.name
  location            = var.location
  resource_group_name = var.resourcegroupname
  subnet_id           = each.value.subnet_id

  private_service_connection {
    name                           = "${each.value.name}-pe-conn"
    private_connection_resource_id = each.value.resource_id
    subresource_names              = each.value.subresource_names
    is_manual_connection           = false
  }
}

