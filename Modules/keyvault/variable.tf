variable "keyvaultname" {
  description = "The name of the Key Vault (must be globally unique)"
  type        = string
}

variable "location" {
  description = "The location of the Key Vault"
  type        = string
}

variable "resourcegroupname" {
  description = "The name of the Resource Group where the Key Vault will be created"
  type        = string
}

variable "tenant_id" {
  description = "The Tenant ID for the Key Vault access policies (sensitive)"
  type        = string
  sensitive   = true
}

variable "object_id" {
  description = "The Object ID for the Key Vault access policy - typically a service principal or user (sensitive)"
  type        = string
  sensitive   = true
}
