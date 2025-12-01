variable "acr_name" {
  type        = string
  description = "name of the container registry"
}
variable "location" {
  type        = string
  description = "location of the container registry"
}
variable "resourcegroupname" {
  type        = string
  description = "name of the resource group where the container registry will be created"
}
variable "tags" {
  type        = map(string)
  description = "tags to be applied to the container registry"
}
