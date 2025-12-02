rg_prefixes = {
  network  = "networking"
  storage  = "storage"
  backend  = "backend"
  frontend = "frontend"
  monitor  = "monitoring"
  infra    = "infra"
  ai       = "ai"
}

location    = "eastus2"
environment = "dev"

tags = {
  owner = "DevTeam"
  env   = "dev"
}

address_space = ["10.0.0.0/16"]
subnets = {
  network  = { address_prefixes = ["10.0.1.0/24"] }
  storage  = { address_prefixes = ["10.0.2.0/24"] }
  backend  = { address_prefixes = ["10.0.4.0/23"] }
  frontend = { address_prefixes = ["10.0.6.0/24"] }
  monitor  = { address_prefixes = ["10.0.7.0/24"] }
  infra    = { address_prefixes = ["10.0.8.0/24"] }
  ai       = { address_prefixes = ["10.0.9.0/24"] }
}


storage_account_tier     = "Standard"
account_replication_type = "LRS"
cpu                      = 1
memory                   = "2Gi"
openai_model_id          = "gpt-4o-mini"
acr_image_name           = "fsdu-app:latest"


subscription_id = ""
client_id       = ""
client_secret   = ""
tenant_id       = ""
