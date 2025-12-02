resource "azurerm_storage_account" "fsdu_storage" {
  name                     = var.storageaccountname
  location                 = var.location
  resource_group_name      = var.resourcegroupname
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  allow_nested_items_to_be_public = false
  min_tls_version                 = "TLS1_2"

  network_rules {
    default_action = "Allow"
    bypass         = ["AzureServices"]
  }

  tags = var.tags
}




