variable "resourcegroupname" {}
variable "resource_group_id" {}
variable "location" {}

variable "openainame" {}
variable "model_name" {
  #default = "gpt-4o-mini"
}
variable "model_version" {
  description = "Model version to deploy"
  type        = string
  default     = "2024-07-18"
}
variable "modeldeploymentname" {
  default = "chat-model"
}

variable "aifoundryname" {}

variable "storage_account_id" {
  description = "Full resource ID of storage account"
  type        = string
}

variable "app_insights_id" {
  description = "Full resource ID of application insights"
  type        = string
}