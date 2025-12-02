variable "container_environment_name" {
  type        = string
  description = "Name of the container app environment"
}

variable "container_app_name" {
  type        = string
  description = "Name of the container app"
}

variable "container_name" {
  type        = string
  description = "Name of the container running in the app"
}

variable "location" {
  type        = string
  description = "Azure region location for resources"
}

variable "resourcegroupname" {
  type        = string
  description = "Name of the resource group"
}

variable "cpu" {
  type        = number
  description = "CPU allocation in cores (e.g., 0.5, 1, 2)"
}

variable "memory" {
  type        = string
  description = "Memory allocation (e.g., '0.5Gi', '1Gi', '2Gi')"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for container app environment infrastructure (must be in a VNet)"
}

variable "managed_identity_id" {
  type        = string
  description = "User-assigned managed identity ID for container app (sensitive - used for ACR authentication)"
  sensitive   = true
}

variable "internal_load_balancer_enabled" {
  type        = bool
  description = "Enable internal load balancer. When true, container app is only accessible through internal ALB (no external/public access)"
  default     = true
}

variable "external_enabled" {
  type        = bool
  description = "Enable external ingress. Set to false for internal-only access through ALB or API Gateway"
  default     = false
}

variable "target_port" {
  type        = number
  description = "Target port for container ingress (port inside the container)"
  default     = 80
}

variable "acr_login_server" {
  type        = string
  description = "ACR login server URL (e.g., myacr.azurecr.io)"
}

variable "acr_image_name" {
  type        = string
  description = "Production image name/tag in ACR (e.g., myapp:latest or myapp:v1.0.0)"
}

variable "use_acr_image" {
  type        = bool
  description = "Use image from ACR instead of public registry. Requires managed identity with AcrPull role"
  default     = true
}