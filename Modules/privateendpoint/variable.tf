variable "location" {
  type = string
}

variable "resourcegroupname" {
  type = string
}

variable "private_endpoints" {
  description = "Map of private endpoints to create"
  type = map(object({
    name               = string
    subnet_id          = string
    resource_id        = string
    subresource_names  = list(string)
  }))
}
