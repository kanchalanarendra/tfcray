variable "location" {
  description = "The location of the Cosmos DB account"
  type        = string
}

variable "resourcegroupname" {
  description = "The name of the Resource Group where the Cosmos DB account will be created"
  type        = string
}

variable "cosmos_db_name" {
  description = "The name of the Cosmos DB NoSQL database"
  type        = string
}

variable "cosmos_sql_container_name" {
  description = "The name of the Cosmos DB NoSQL container"
  type        = string
}

variable "cosmosdb_account_name" {
  type        = string
  description = "The name of the Cosmos DB Account (must be globally unique)"
}
