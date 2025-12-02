resource "azurerm_storage_container" "fsdu_storage_blob_container" {
  count                 = var.create_container ? 1 : 0
  name                  = var.storagecontainername
  storage_account_name  = var.storage_account_name
  container_access_type = "private"
}