variable "location" {
  description = "Azure region for private endpoints"
  type        = string
}

variable "resourcegroupname" {
  description = "Name of the resource group"
  type        = string
}

variable "private_endpoints" {
  description = "Map of private endpoints to create with their configurations"
  type = map(object({
    name               = string
    subnet_id          = string
    resource_id        = string
    subresource_names  = list(string)
  }))
}
