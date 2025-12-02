variable "acr_name" {
  type        = string
  description = "Name of the container registry (must be globally unique, lowercase alphanumeric only)"
}

variable "location" {
  type        = string
  description = "Azure region for the container registry"
}

variable "resourcegroupname" {
  type        = string
  description = "Name of the resource group where the container registry will be created"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the container registry"
}
