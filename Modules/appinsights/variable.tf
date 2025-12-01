variable "appinsights_name" {
  description = "Name of the Application Insights resource"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resourcegroupname" {
  description = "Resource group name"
  type        = string
}

variable "application_type" {
  description = "Type of application being monitored"
  type        = string
  default     = "web"
}

