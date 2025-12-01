variable "storageaccountname" {
  description = "name of storage account"
  type        = string
}
variable "location" {
  description = "location of storage account"
  type        = string
}
variable "resourcegroupname" {
  description = "name of the resource group"
  type        = string
}
variable "account_tier" {
  type        = string
  description = "tier of the storage account"
}
variable "account_replication_type" {
  type        = string
  description = "replication type of the storage account"
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "storagecontainername" {
  description = "name of the storage container"
  type        = string
}