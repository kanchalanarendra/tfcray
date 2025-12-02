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
  description = "Name of the OpenAI cognitive account"
}

variable "model_name" {
  type        = string
  description = "Name of the OpenAI model to deploy"
}

variable "model_version" {
  type        = string
  description = "Version of the OpenAI model"
  default     = "2024-07-18"
}

variable "modeldeploymentname" {
  type        = string
  description = "Name of the model deployment"
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
  description = "The ID of the Key Vault to be used by the AI Foundry workspace"
}

variable "app_insights_id" {
  type        = string
  description = "The ID of the Application Insights resource to be used by the AI Foundry workspace"
}
