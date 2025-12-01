
# SKIPPED - Requires storage account access permissions
# resource "azurerm_storage_container" "fsdu_storage_blob_container" {
#   name                  = var.storagecontainername
#   storage_account_name = var.storageaccountname
#   container_access_type = "private"
#
#   depends_on = [
#      var.private_endpoint_dependency 
#   ]
# }