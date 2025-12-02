variable "appinsights_name" {
  description = "Name of the Application Insights resource"
  type        = string
}

variable "location" {
  description = "Azure region for Application Insights"
  type        = string
}

variable "resourcegroupname" {
  description = "Name of the resource group"
  type        = string
}

variable "application_type" {
  description = "Type of application being monitored (web, ios, other, etc.)"
  type        = string
  default     = "web"
}

