output "cosmosdb_account_name" {
  value = azurerm_cosmosdb_account.fsdu_cosmos_account.name
}
output "cosmosdb_account_id" {
  value = azurerm_cosmosdb_account.fsdu_cosmos_account.id
}
output "cosmosdb_sql_database_id" {
  value = azurerm_cosmosdb_sql_database.fsdu_cosmos_sql_db.id
}
output "cosmosdb_sql_container_id" {
  value = azurerm_cosmosdb_sql_container.fsdu_cosmos_sql_container.id
}
