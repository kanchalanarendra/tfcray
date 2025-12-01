variable "rg_prefixes" {
  description = "Prefixes for each resource group"
  type        = map(string)
}

variable "location" {
  type = string
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "environment" {
  type = string
}
variable "subnets" {
  description = "Map of subnet configurations for VNet"
  type = map(object({
    address_prefixes = list(string)
  }))
}
variable "address_space" {
  description = "Address space for the VNet"
  type        = list(string)
}

# variable "private_endpoints" {
#   description = "name of the private endpoints"
#   type = map(object({
#     subnet_id        = string
#     resource_id      = string
#     subresource_names = list(string)
#   }))
# }
variable "storage_account_tier" {
  description = "value for the account tier"
  type        = string
}
variable "account_replication_type" {
  description = "storage account replication type"
  type        = string
}

variable "cpu" {
  description = "CPU allocation for the container app"
  type        = number
}

variable "memory" {
  description = "Memory allocation for the container app"
  type        = string
}

variable "openai_model_id" {
  type = string
}

variable "client_id" {
  
}
variable "client_secret" {
  
}
variable "tenant_id" {
  
}
variable "subscription_id" {
  
}