variable "storageaccountid" {
  type        = string
  description = "The ID of the storage account"
}

variable "storage_account_name" {
  type        = string
  description = "The name of the storage account"
}

variable "storagecontainername" {
  type = string
}

variable "create_container" {
  type        = bool
  description = "Whether to create the storage container"
  default     = true
}

variable "private_endpoint_dependency" {
  type    = list(string)
  default = []
}