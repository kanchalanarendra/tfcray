variable "managed_identities" {
  type = map(object({
    name                = string
    has_keyvault_access = optional(bool, false)
    has_storage_access  = optional(bool, false)
    has_cosmos_access   = optional(bool, false)
    has_openai_access   = optional(bool, false)
    has_acr_access      = optional(bool, false)
  }))
  description = "Map of managed identities to create with their service access permissions"
  default = {
    staticwebapp = {
      name                = "mi-staticwebapp"
      has_keyvault_access = false
      has_storage_access  = false
      has_cosmos_access   = false
      has_openai_access   = false
      has_acr_access      = false
    }
    backend = {
      name                = "mi-backend"
      has_keyvault_access = true
      has_storage_access  = true
      has_cosmos_access   = true
      has_openai_access   = true
      has_acr_access      = true
    }
  }
}

variable "keyvault_id" {
  type        = string
  description = "Resource ID of the Key Vault"
}

variable "storage_account_id" {
  type        = string
  description = "Resource ID of the storage account"
}

variable "cosmos_id" {
  type        = string
  description = "Resource ID of the Cosmos DB account"
}

variable "tenant_id" {
  type        = string
  description = "Azure tenant ID"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resourcegroupname" {
  type        = string
  description = "Name of the resource group"
}

variable "acr_id" {
  type        = string
  description = "Resource ID of the Azure Container Registry"
}

variable "openai_id" {
  type        = string
  description = "Resource ID of the Azure OpenAI account"
}

variable "ai_foundry_id" {
  type        = string
  description = "Resource ID of the AI Foundry workspace (optional)"
  default     = null
}