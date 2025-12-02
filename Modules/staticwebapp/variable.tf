variable "resourcegroupname" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the static web app"
  type        = string
}

variable "static_web_app_name" {
  description = "Name of the static web app resource"
  type        = string
}
