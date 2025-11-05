# Azure Terraform Naming Module

A Terraform module for generating consistent Azure resource names following [Microsoft's Cloud Adoption Framework](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations) naming conventions.

## Features

✅ **200+ Azure resource types** with official Microsoft abbreviations  
✅ **Flexible naming pattern** - use only the components you need  
✅ **Cloud acronym support** - distinguish Azure Commercial (`azc`) vs Government (`azg`)  
✅ **Region abbreviation support** - optional short codes for Azure regions  
✅ **Character limit handling** - automatic clean names for Storage Accounts, Key Vaults, etc.  
✅ **Azure Government support** - includes US Gov and DoD regions  
✅ **Input validation** - ensures lowercase alphanumeric values  
✅ **Zero dependencies** - pure Terraform with no providers required  

## Quick Start

```hcl
module "naming" {
  source = "./azure_tf_naming"

  cloud_acronym = "azc"  # Azure Commercial
  prefix        = "contoso"
  workload      = "webapp"
  environment   = "prod"
  location      = "eastus"
}

resource "azurerm_resource_group" "example" {
  name     = module.naming.resource_group  # Output: azc-rg-contoso-webapp-prod-eastus
  location = "East US"
}

resource "azurerm_key_vault" "example" {
  name                = module.naming.key_vault  # Output: azc-kv-contoso-webap (truncated to 24 chars)
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
}
```

## Naming Pattern

```
<cloud_acronym>-<abbreviation>-<prefix>-<workload>-<environment>-<location>
```

### Example Outputs

| Resource Type | Output Name |
|--------------|-------------|
| Resource Group | `azc-rg-contoso-webapp-prod-eastus` |
| Virtual Network | `azc-vnet-contoso-webapp-prod-eastus` |
| Storage Account | `azcstcontosowebappprode` (clean, no hyphens, max 24 chars) |
| Key Vault | `azc-kv-contoso-webap-p` (truncated to 24 chars with hyphens) |
| AKS Cluster | `azc-aks-contoso-webapp-prod-eastus` |

## Documentation

- **[NAMING_CONVENTION.md](NAMING_CONVENTION.md)** - Complete documentation with examples
- **[CHARACTER_LIMITS.md](CHARACTER_LIMITS.md)** - Handling Azure resource character limitations
- **[AZURE_GOVERNMENT.md](AZURE_GOVERNMENT.md)** - Azure Government and DoD regions guide
- **[Microsoft CAF - Resource Abbreviations](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations)** - Official abbreviation reference

## Supported Resource Categories

- 🤖 AI + Machine Learning (20+ resources)
- 📊 Analytics and IoT (30+ resources)
- 💻 Compute and Web (30+ resources)
- 📦 Containers (10+ resources)
- 🗄️ Databases (15+ resources)
- 🌐 Networking (50+ resources)
- 🔒 Security (10+ resources)
- 💾 Storage (6+ resources)
- ⚙️ Management and Governance (15+ resources)
- 🔄 Integration (8+ resources)
- 🖥️ Virtual Desktop Infrastructure (4+ resources)
- 🔧 Developer Tools (4+ resources)

## Usage Examples

### Minimal Configuration

```hcl
module "naming" {
  source = "./azure_tf_naming"

  workload    = "api"
  environment = "dev"
}

# Output: azc-app-api-dev (cloud_acronym defaults to "azc")
resource "azurerm_linux_web_app" "example" {
  name                = module.naming.web_app
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  service_plan_id     = azurerm_service_plan.example.id
  site_config {}
}
```

### With Region Abbreviations

```hcl
module "naming" {
  source = "./azure_tf_naming"

  cloud_acronym         = "azc"
  prefix                = "acme"
  workload              = "data"
  environment           = "prod"
  location              = "eastus"
  use_azure_region_abbr = true  # Uses "eus" instead of "eastus"
}

# Output: azc-vnet-acme-data-prod-eus
resource "azurerm_virtual_network" "example" {
  name                = module.naming.virtual_network
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}
```

### Resources with Character Limitations

```hcl
module "naming" {
  source = "./azure_tf_naming"

  cloud_acronym         = "azc"
  prefix                = "acme"
  workload              = "shop"
  environment           = "prod"
  location              = "eastus"
  use_azure_region_abbr = true
}

# Storage Account requires: 3-24 chars, alphanumeric only (no hyphens)
# Output automatically returns clean name: azcstacmeshopprodeus
resource "azurerm_storage_account" "example" {
  name                     = module.naming.storage_account
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

# Container Registry requires: 5-50 chars, alphanumeric only
# Output automatically returns clean name: azccracmeshopprodeus
resource "azurerm_container_registry" "example" {
  name                = module.naming.container_registry
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Premium"
}
```

### Azure Government Regions

```hcl
module "naming_gov" {
  source = "./azure_tf_naming"

  cloud_acronym         = "azg"  # Azure Government
  prefix                = "dod"
  workload              = "mission"
  environment           = "prod"
  location              = "usgovvirginia"
  use_azure_region_abbr = true
}

# Output: azg-rg-dod-mission-prod-ugv
resource "azurerm_resource_group" "example" {
  name     = module.naming_gov.resource_group
  location = "US Gov Virginia"
}

# Output: azg-kv-dod-mission-pro (truncated to 24 chars)
resource "azurerm_key_vault" "example" {
  name                = module.naming_gov.key_vault
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "premium"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cloud_acronym | Cloud acronym: 'azc' for Azure Commercial or 'azg' for Azure Government | `string` | `"azc"` | no |
| prefix | Prefix for resource names (e.g., company name) | `string` | `""` | no |
| workload | Workload or application name | `string` | `""` | no |
| environment | Environment name (e.g., dev, test, prod) | `string` | `""` | no |
| location | Azure region location code | `string` | `""` | no |
| delimiter | Delimiter between name components | `string` | `"-"` | no |
| use_azure_region_abbr | Use abbreviated region names | `bool` | `false` | no |

## Key Outputs

The module provides 200+ resource name outputs. Here are the most commonly used:

### Standard Names (with hyphens)

| Output | Description | Example |
|--------|-------------|---------|
| `resource_group` | Resource Group | `azc-rg-contoso-app-prod-eastus` |
| `virtual_network` | Virtual Network | `azc-vnet-contoso-app-prod-eastus` |
| `subnet` | Subnet | `azc-snet-contoso-app-prod-eastus` |
| `aks_cluster` | AKS Cluster | `azc-aks-contoso-app-prod-eastus` |
| `sql_server` | SQL Server | `azc-sql-contoso-app-prod-eastus` |
| `app_service_plan` | App Service Plan | `azc-asp-contoso-app-prod-eastus` |
| `function_app` | Function App | `azc-func-contoso-app-prod-eastus` |
| `web_app` | Web App | `azc-app-contoso-app-prod-eastus` |

### Resources with Strict Naming Requirements

These resources automatically handle character limitations:

| Output | Description | Max Length | Hyphens? | Example |
|--------|-------------|-----------|----------|---------|
| `storage_account` | Storage Account | 24 chars | ❌ No | `azcstcontosoapprodeas` |
| `container_registry` | Container Registry | 50 chars | ❌ No | `azccrcontosoapprodeastus` |
| `key_vault` | Key Vault | 24 chars | ✅ Yes | `azc-kv-contoso-app-pro` |

See [outputs.tf](outputs.tf) for the complete list and [CHARACTER_LIMITS.md](CHARACTER_LIMITS.md) for detailed guidance.

## Examples

Check the [examples](examples/) directory for complete working examples:

- [Basic Example](examples/basic/) - Simple usage with common resources
- [Advanced Example](examples/advanced/) - Complex multi-environment setup
- [Character Limits Example](examples/character_limits/) - Handling resources with naming restrictions
- [Azure Government Example](examples/azure_government/) - Government and DoD regions

## Requirements

- Terraform >= 1.0

## Best Practices

1. ✅ Keep names lowercase and alphanumeric
2. ✅ Use `cloud_acronym` to distinguish Commercial vs Government clouds
3. ✅ Use consistent naming across your organization
4. ✅ Be mindful of Azure resource name length limits
5. ✅ Use region abbreviations for long names
6. ✅ Document your specific naming patterns

## Contributing

Contributions are welcome! Please open an issue or pull request.

## References

- [Azure Cloud Adoption Framework - Naming Conventions](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging)
- [Azure Resource Abbreviations](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations)
- [Azure Naming Rules and Restrictions](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules)

## License

See [LICENSE](LICENSE) for details.
