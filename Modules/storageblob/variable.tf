variable "storageaccountname" {
  type        = string
  description = "The name of the storage account"
}
variable "storagecontainername" {
  type = string
}
variable "private_endpoint_dependency" {
  type    = list(string)
  default = []
}