variable "rg_prefixes" {
  description = "Prefixes for each resource group (e.g., network, storage, backend, frontend, monitor, infra, ai)"
  type        = map(string)
}

variable "location" {
  description = "Primary Azure region for resource deployment"
  type        = string
}

variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "environment" {
  description = "Deployment environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "subnets" {
  description = "Map of subnet configurations for VNet"
  type = map(object({
    address_prefixes = list(string)
  }))
}

variable "address_space" {
  description = "Address space for the VNet (e.g., [\"10.0.0.0/16\"])"
  type        = list(string)
}

variable "storage_account_tier" {
  description = "Storage account tier: Standard or Premium"
  type        = string
}

variable "account_replication_type" {
  description = "Storage account replication type: LRS, GRS, RAGRS, ZRS"
  type        = string
}

variable "cpu" {
  description = "CPU allocation for the container app in cores"
  type        = number
}

variable "memory" {
  description = "Memory allocation for the container app (e.g., \"2Gi\", \"1Gi\")"
  type        = string
}

variable "openai_model_id" {
  description = "OpenAI model deployment name (e.g., gpt-4o-mini, gpt-4, gpt-35-turbo)"
  type        = string
}

variable "acr_image_name" {
  description = "Production container image name/tag in ACR (e.g., myapp:latest or myapp:v1.0.0)"
  type        = string
}

variable "client_id" {
  description = "Azure Service Principal Client ID for authentication (sensitive)"
  type        = string
  sensitive   = true
}

variable "client_secret" {
  description = "Azure Service Principal Client Secret for authentication (sensitive)"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "Azure Tenant ID (sensitive)"
  type        = string
  sensitive   = true
}

variable "subscription_id" {
  description = "Azure Subscription ID (sensitive)"
  type        = string
  sensitive   = true
}