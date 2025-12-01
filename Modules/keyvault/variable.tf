variable "keyvaultname" {
  description = "The name of the Key Vault."
  type        = string
}
variable "location" {
  description = "The location of the Key Vault."
  type        = string
}
variable "resourcegroupname" {
  description = "The name of the Resource Group where the Key Vault will be created."
  type        = string
}

variable "tenant_id" {
  description = "The Tenant ID for the Key Vault."
  type        = string
}
variable "object_id" {
  description = "The Object ID for the Key Vault access policy."
  type        = string
}
