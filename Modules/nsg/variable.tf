variable "location" {
  type = string
}

variable "resourcegroupname" {
  type = string
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "subnets" {
  type = map(object({
    subnet_id = string
  }))
}
