locals {
  project_name = "fsdu"
  owner        = "crayola"
  region       = "eastus2"

  tags = {
    Project = local.project_name
    Owner   = local.owner
  }
}
