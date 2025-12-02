variable "resourcegroupname" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region for resources"
}

variable "openainame" {
  type        = string
  description = "Name of the OpenAI cognitive account (must be globally unique)"
}

variable "model_name" {
  type        = string
  description = "Name of the OpenAI model to deploy (e.g., gpt-4o-mini, gpt-4, gpt-35-turbo)"
}

variable "model_version" {
  type        = string
  description = "Version of the OpenAI model (e.g., 2024-07-18)"
  default     = "2024-07-18"
}

variable "modeldeploymentname" {
  type        = string
  description = "Name of the model deployment (e.g., chat-model, code-model)"
  default     = "chat-model"
}

variable "aifoundryname" {
  type        = string
  description = "Name of the Azure AI Foundry workspace"
}

variable "resource_group_id" {
  type        = string
  description = "The ID of the resource group where the AI Foundry workspace will be created"
}

variable "storage_account_id" {
  type        = string
  description = "The ID of the storage account to be used by the AI Foundry workspace"
}

variable "keyvault_id" {
  type        = string
  description = "The ID of the Key Vault to be used by the AI Foundry workspace (sensitive)"
  sensitive   = true
}

variable "app_insights_id" {
  type        = string
  description = "The ID of the Application Insights resource to be used by the AI Foundry workspace"
}
