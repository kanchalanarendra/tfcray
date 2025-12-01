# 1. Cosmos DB Account (GlobalDocumentDB for NoSQL)
resource "azurerm_cosmosdb_account" "fsdu_cosmos_account" {
  name                = var.cosmosdb_account_name
  location            = var.location
  resource_group_name = var.resourcegroupname
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB" # Use this for NoSQL API

  # Define consistency policy (e.g., Session, BoundedStaleness, Strong)
  consistency_policy {
    consistency_level = "Session"
  }

  # Define one or more geo-locations for replication
  geo_location {
    location          = var.location
    failover_priority = 0
  }
}

# 2. Cosmos DB NoSQL Database
resource "azurerm_cosmosdb_sql_database" "fsdu_cosmos_sql_db" {
  name                = var.cosmos_db_name
  resource_group_name = azurerm_cosmosdb_account.fsdu_cosmos_account.resource_group_name
  account_name        = azurerm_cosmosdb_account.fsdu_cosmos_account.name
  throughput          = 400 # Optional: define manual throughput
}

# 3. Cosmos DB NoSQL Container
resource "azurerm_cosmosdb_sql_container" "fsdu_cosmos_sql_container" {
  name                  = var.cosmos_sql_container_name
  resource_group_name   = azurerm_cosmosdb_account.fsdu_cosmos_account.resource_group_name
  account_name          = azurerm_cosmosdb_account.fsdu_cosmos_account.name
  database_name         = azurerm_cosmosdb_sql_database.fsdu_cosmos_sql_db.name
  partition_key_paths   = ["/myPartitionKey"] # REQUIRED for sharding/scaling
  partition_key_version = 2                   # Recommended
  throughput            = 400                 # Optional: define manual throughput at container level
}