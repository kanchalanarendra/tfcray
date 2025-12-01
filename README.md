# Azure Infrastructure Terraform Configuration

This Terraform configuration deploys a complete Azure infrastructure including networking, storage, container services, databases, and AI services.

## Architecture Overview

This configuration creates the following Azure resources across 7 resource groups:

### Resource Groups
- **networking** - Network resources (VNet, Subnets, NSGs)
- **storage** - Storage Account, Key Vault, Cosmos DB
- **backend** - Azure Container Registry (ACR)
- **frontend** - Reserved for frontend services
- **monitoring** - Reserved for monitoring services
- **infra** - Reserved for infrastructure services
- **ai** - Azure OpenAI and AI Foundry services

### Resources Deployed (36 total)

#### Networking (22 resources)
- 7 Resource Groups
- 1 Virtual Network (10.0.0.0/16)
- 7 Subnets (one per resource group)
- 7 Network Security Groups
- 7 NSG-Subnet Associations

#### Storage & Data (7 resources)
- 1 Azure Key Vault
- 1 Storage Account with private networking
- 1 Blob Storage Container
- 1 Cosmos DB Account (NoSQL)
- 1 Cosmos DB SQL Database
- 1 Cosmos DB SQL Container

#### Container & Compute (1 resource)
- 1 Azure Container Registry (Premium SKU)

#### AI Services (6 resources)
- 1 Azure OpenAI Cognitive Account
- 1 AI Foundry Workspace
- 1 AI Foundry Project
- 1 AI Foundry Endpoint
- 1 Model Deployment

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.6.0
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- Azure subscription with appropriate permissions
- Authenticated Azure CLI session

## Project Structure

```
.
├── main.tf                      # Main configuration with module calls
├── provider.tf                  # Provider configuration
├── variable.tf                  # Variable declarations
├── locals.tf                    # Local values
├── output.tf                    # Output definitions
├── backend.tf                   # Backend configuration (empty)
├── environments/
│   └── dev/
│       └── dev.tfvars          # Development environment variables
└── Modules/
    ├── Resource_Group/         # Resource group module
    ├── Virtual_Network/        # VNet and subnet module
    ├── NSG/                    # Network security group module
    ├── keyvault/               # Key Vault module
    ├── storage_account/        # Storage account module
    ├── ACR/                    # Container registry module
    ├── cosmosDB/               # Cosmos DB module
    └── openAI/                 # Azure OpenAI & AI Foundry module
```

## Configuration

### Required Variables

The following variables must be set in your `.tfvars` file:

| Variable | Description | Example |
|----------|-------------|---------|
| `rg_prefixes` | Map of resource group name prefixes | See dev.tfvars |
| `location` | Azure region | "eastus2" |
| `environment` | Environment name | "dev" |
| `tags` | Resource tags | { env = "dev", owner = "DevTeam" } |
| `address_space` | VNet address space | ["10.0.0.0/16"] |
| `subnets` | Subnet configurations | See dev.tfvars |
| `storage_account_tier` | Storage account tier | "Standard" |
| `account_replication_type` | Storage replication type | "LRS" |
| `openai_model_id` | OpenAI model ID for deployment | "gpt-4o-mini" |

### Local Values

The following are defined in `locals.tf`:

- `project_name`: "fsdu" (used as resource name prefix)
- `owner`: "Crayola"
- `region`: "eastus2"

## Usage

### 1. Authentication

```bash
# Login to Azure
az login

# Set subscription (if needed)
az account set --subscription "your-subscription-id"
```

### 2. Initialize Terraform

```bash
terraform init
```

### 3. Plan Deployment

```bash
# Using dev environment
terraform plan -var-file="environments/dev/dev.tfvars"
```

### 4. Deploy Infrastructure

```bash
terraform apply -var-file="environments/dev/dev.tfvars"
```

### 5. Destroy Infrastructure

```bash
terraform destroy -var-file="environments/dev/dev.tfvars"
```

## Naming Conventions

Resources follow this naming pattern:
- Resource Groups: `rg-{project_name}-{category}-{environment}`
- Virtual Network: `vnet-{project_name}-{environment}`
- Subnets: `snet-{project_name}-{category}-{environment}`
- NSGs: `nsg-{project_name}-{category}-{environment}`
- Key Vault: `kv-{project_name}-{environment}`
- Storage Account: `storage{project_name}{environment}`
- Container Registry: `acr{project_name}{environment}`
- Cosmos DB: `cosmos{project_name}{environment}`

## Network Configuration

### Address Space
- VNet: 10.0.0.0/16

### Subnets
| Subnet | CIDR | Purpose |
|--------|------|---------|
| network | 10.0.1.0/24 | Network resources |
| storage | 10.0.2.0/24 | Storage services |
| backend | 10.0.3.0/24 | Backend services |
| frontend | 10.0.4.0/24 | Frontend services |
| monitor | 10.0.5.0/24 | Monitoring services |
| infra | 10.0.6.0/24 | Infrastructure services |
| ai | 10.0.7.0/24 | AI services |

## Security Features

- **Network Security Groups**: Applied to all subnets
- **Private Networking**: Storage account with default deny and Azure Services bypass
- **Key Vault**: Soft delete enabled (7 days retention)
- **TLS**: Minimum TLS 1.2 for storage
- **ACR**: Public access disabled, zone redundancy enabled
- **Container Access**: Private blob containers

## Modules

### Resource_Group
Creates Azure resource groups with tags.

### Virtual_Network
Creates VNet with multiple subnets using for_each loop.

### NSG
Creates Network Security Groups and associates them with subnets.

### keyvault
Deploys Azure Key Vault with access policies for the current user/service principal.

### storage_account
Deploys Storage Account with private networking and blob container.

### ACR
Deploys Azure Container Registry with Premium SKU and private access.

### cosmosDB
Deploys Cosmos DB account with NoSQL API, database, and container.

### openAI
Deploys Azure OpenAI Cognitive Service, AI Foundry workspace, project, endpoint, and model deployment.

## Dependencies

The modules have the following dependency chain:

1. Resource Groups (created first)
2. Virtual Network (depends on Resource Groups)
3. Network Security Groups (depends on Virtual Network)
4. All other services (depend on Resource Groups)

## Providers

- **azurerm**: ~> 3.110.0 (HashiCorp)
- **azapi**: >= 2.0.0 (Azure)

The `azapi` provider is used for Azure AI services that don't yet have full support in the azurerm provider.

## Outputs

The configuration can be extended to output:
- Resource group IDs and names
- Virtual network and subnet IDs
- Key Vault URI
- Storage account endpoints
- ACR login server
- Cosmos DB endpoints
- OpenAI endpoints

## Notes

- The AI Foundry resources use preview API versions (2024-05-01-preview)
- Schema validation is disabled for AI resources due to preview status
- All AI resources have `schema_validation_enabled = false`
- Cosmos DB uses Session consistency level by default

## Troubleshooting

### Issue: Plan shows fewer than 36 resources
**Solution**: Run `terraform init` to ensure all modules are loaded.

### Issue: Provider azapi not found
**Solution**: The openAI module requires `azure/azapi` provider. Ensure `versions.tf` exists in the openAI module.

### Issue: Authentication errors
**Solution**: Ensure you're logged in with `az login` and have the correct permissions.

## Contributing

When adding new modules:
1. Create module in `Modules/` directory
2. Add module call in `main.tf`
3. Update `variable.tf` and `dev.tfvars` as needed
4. Run `terraform init` to register the module
5. Update this README

## License

[Specify your license here]

## Authors

- DevTeam

## Version History

- **1.0.0** - Initial release with networking, storage, container, database, and AI services
