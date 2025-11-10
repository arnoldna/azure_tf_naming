# Azure Terraform Naming Convention

This module implements the [Microsoft Azure Cloud Adoption Framework](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations) naming conventions for Azure resources.

> **Reference:** For detailed information on Azure resource naming rules and character limits, see [Naming rules and restrictions for Azure resources](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules?source=recommendations).

## Naming Pattern

The module generates resource names using the following pattern:

```txt
<cloud_acronym>-<abbreviation>-<prefix>-<workload>-<environment>-<location>
```

### Components

- **cloud_acronym**: Cloud designation - `azc` for Azure Commercial or `azg` for Azure Government (default: `azc`)
- **abbreviation**: Resource type abbreviation based on Microsoft CAF best practices (e.g., `rg`, `vnet`, `kv`)
- **prefix**: Optional company or project identifier
- **workload**: Application or workload name
- **environment**: Environment designation (e.g., `dev`, `test`, `prod`)
- **location**: Azure region (can be abbreviated, e.g., `eus` for `eastus`)
- **delimiter**: Character to separate components (default: `-`)

All components are optional except the resource type abbreviation, which is always included. Empty components are automatically filtered out.

## Features

- ✅ **200+ Azure resource types** with official Microsoft abbreviations
- ✅ **Flexible naming components** - use only what you need
- ✅ **Cloud acronym support** - distinguish between Azure Commercial and Government
- ✅ **Region abbreviation support** - optional short codes for Azure regions
- ✅ **Consistent delimiter** - configurable separator between name parts
- ✅ **Input validation** - ensures lowercase alphanumeric values
- ✅ **Multiple output formats** - standard names and clean names for strict requirements

## Usage Examples

### Basic Usage

```hcl
module "naming" {
  source = "./azure_tf_naming"

  cloud_acronym = "azc"  # Azure Commercial
  prefix        = "contoso"
  workload      = "webapp"
  environment   = "prod"
  location      = "eastus"
}

# Output: azc-rg-contoso-webapp-prod-eastus
resource "azurerm_resource_group" "example" {
  name     = module.naming.resource_group
  location = "East US"
}

# Output: azc-kv-contoso-webap-p (truncated to 24 chars, includes hyphens)
resource "azurerm_key_vault" "example" {
  name                = module.naming.key_vault
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
}
```

### With Region Abbreviation

```hcl
module "naming" {
  source = "./azure_tf_naming"

  cloud_acronym         = "azc"  # Azure Commercial
  prefix                = "acme"
  workload              = "api"
  environment           = "dev"
  location              = "eastus"
  use_azure_region_abbr = true
}

# Output: azc-vnet-acme-api-dev-eus
resource "azurerm_virtual_network" "example" {
  name                = module.naming.virtual_network
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}
```

### Minimal Configuration

```hcl
module "naming" {
  source = "./azure_tf_naming"

  workload    = "backend"
  environment = "staging"
}

# Output: azc-app-backend-staging (cloud_acronym defaults to "azc")
resource "azurerm_linux_web_app" "example" {
  name                = module.naming.web_app
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  service_plan_id     = azurerm_service_plan.example.id

  site_config {}
}
```

### Azure Government

```hcl
module "naming" {
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
  name     = module.naming.resource_group
  location = "US Gov Virginia"
}
```

### Custom Delimiter

```hcl
module "naming" {
  source = "./azure_tf_naming"

  workload    = "data"
  environment = "test"
  delimiter   = "_"
}

# Output: azc_cosmos_data_test (cloud_acronym defaults to "azc")
resource "azurerm_cosmosdb_account" "example" {
  name                = module.naming.cosmos_db
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = azurerm_resource_group.example.location
    failover_priority = 0
  }
}
```

### Virtual Machine Hostnames

For organizations requiring a specific VM hostname format, the module provides specialized VM naming that differs from the standard resource naming pattern.

**VM Hostname Format:**

```txt
<cloud_short><location><os><app_name><env><number>
```

**Components:**

- **cloud_short**: 2-character cloud identifier
  - `az` for Azure Commercial (from `azc`)
  - `ag` for Azure Government (from `azg`)
- **location**: 3-4 character region abbreviation (requires `use_azure_region_abbr = true`)
  - Examples: `cus`, `eus2`, `wus2`, `ugv`, `ugt`
- **os**: 1-character OS type
  - `l` for Linux
  - `w` for Windows
- **app_name**: 3-6 character application identifier
  - Examples: `nds`, `autop`, `automg`, `vem`, `airway`
- **env**: 1-character environment identifier
  - `p` - Production
  - `d` - Development
  - `t` - Test
  - `n` - Non-Production (shared servers)
  - `s` - Staging
- **number**: 2-digit numeric identifier (01-99)

**Example:**

```hcl
# Windows VM for NDS application in Production
module "vm_naming" {
  source = "./azure_tf_naming"

  cloud_acronym         = "azc"
  environment           = "p"
  location              = "centralus"
  use_azure_region_abbr = true

  vm_os_type          = "w"
  vm_application_name = "nds"
  vm_number           = 1
}

resource "azurerm_windows_virtual_machine" "nds" {
  name                = module.vm_naming.vm_hostname  # Output: azcuswndsp01
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                = "Standard_DS2_v2"
  admin_username      = "adminuser"

  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
}
```

**More Examples:**

```hcl
# Linux VM for Autopilot in Development
module "vm_autopilot_dev" {
  source = "./azure_tf_naming"

  cloud_acronym         = "azc"
  environment           = "dev"
  location              = "eastus2"
  use_azure_region_abbr = true
  
  vm_os_type          = "l"
  vm_application_name = "autop"
  vm_number           = 5
}
# Output: azeus2lautopd05

# Windows VM for VEM in Test (Azure Government)
module "vm_gov_vem" {
  source = "./azure_tf_naming"

  cloud_acronym         = "azg"
  environment           = "t"
  location              = "usgovvirginia"
  use_azure_region_abbr = true
  
  vm_os_type          = "w"
  vm_application_name = "vem"
  vm_number           = 12
}
# Output: agugvwvemt12

# Linux VM for Airway in Non-Prod
module "vm_airway_nonprod" {
  source = "./azure_tf_naming"

  cloud_acronym         = "azc"
  environment           = "n"
  location              = "westus2"
  use_azure_region_abbr = true

  vm_os_type          = "l"
  vm_application_name = "airway"
  vm_number           = 3
}
# Output: azwus2lairwayn03
```

**VM Hostname Output Details:**

The module provides two VM-related outputs:

1. **`vm_hostname`**: The complete hostname string (e.g., `azeus2wndsp01`)
2. **`vm_details`**: A map containing the breakdown of all components:

   ```hcl
   {
     hostname            = "azeus2wndsp01"
     cloud_acronym_short = "az"
     location            = "eus2"
     os_type             = "w"
     application_name    = "nds"
     environment_short   = "p"
     number              = 1
   }
   ```

**Important Notes:**

- VM hostnames are always lowercase
- The `use_azure_region_abbr` should be set to `true` for proper region abbreviations
- Both `vm_os_type` and `vm_application_name` must be provided to generate a VM hostname
- If VM parameters are not provided, `vm_hostname` will be an empty string
- The environment input accepts both short (`p`, `d`, `t`) and long (`prod`, `dev`, `test`) forms
- Numbers are zero-padded to 2 digits (1 becomes 01, 25 stays 25)

## Supported Resource Types

The module supports 200+ Azure resource types organized by category:

### AI + Machine Learning

- AI Search (`ai_search`) - `srch`
- AI Services (`ai_services`) - `ais`
- AI Foundry Account (`ai_foundry_account`) - `aif`
- AI Foundry Hub (`ai_foundry_hub`) - `hub`
- Azure OpenAI Service (`openai_service`) - `oai`
- Machine Learning Workspace (`machine_learning_workspace`) - `mlw`
- Computer Vision (`computer_vision`) - `cv`
- Content Moderator (`content_moderator`) - `cm`
- Content Safety (`content_safety`) - `cs`
- Document Intelligence (`document_intelligence`) - `di`
- Face API (`face_api`) - `face`
- Language Service (`language_service`) - `lang`
- Speech Service (`speech_service`) - `spch`
- Translator (`translator`) - `trsl`
- And more...

### Analytics and IoT

- Data Factory (`data_factory`) - `adf`
- Synapse Workspace (`synapse_workspace`) - `synw`
- Synapse SQL Pool (`synapse_sql_pool`) - `syndp`
- Synapse Spark Pool (`synapse_spark_pool`) - `synsp`
- Databricks Workspace (`databricks_workspace`) - `dbw`
- Event Hub Namespace (`event_hub_namespace`) - `evhns`
- Event Hub (`event_hub`) - `evh`
- Event Grid Domain (`event_grid_domain`) - `evgd`
- Event Grid Topic (`event_grid_topic`) - `evgt`
- IoT Hub (`iot_hub`) - `iot`
- Fabric Capacity (`fabric_capacity`) - `fc`
- Stream Analytics (`stream_analytics`) - `asa`
- And 30+ more...

### Compute and Web

- Virtual Machine (`virtual_machine`) - `vm`
- Virtual Machine Scale Set (`virtual_machine_scale_set`) - `vmss`
- App Service Plan (`app_service_plan`) - `asp`
- Function App (`function_app`) - `func`
- Web App (`web_app`) - `app`
- Static Web App (`static_web_app`) - `stapp`
- Availability Set (`availability_set`) - `avail`
- Managed Disk (OS) (`managed_disk_os`) - `osdisk`
- Managed Disk (Data) (`managed_disk_data`) - `disk`
- Snapshot (`snapshot`) - `snap`
- And 30+ more...

### Containers

- AKS Cluster (`aks_cluster`) - `aks`
- AKS System Node Pool (`aks_system_node_pool`) - `npsystem`
- AKS User Node Pool (`aks_user_node_pool`) - `np`
- Container Registry (`container_registry`) - `cr`
- Container Instance (`container_instance`) - `ci`
- Container App (`container_app`) - `ca`
- Container App Environment (`container_app_environment`) - `cae`
- Service Fabric Cluster (`service_fabric_cluster`) - `sf`
- And more...

### Databases

- SQL Server (`sql_server`) - `sql`
- SQL Database (`sql_database`) - `sqldb`
- SQL Elastic Pool (`sql_elastic_pool`) - `sqlep`
- SQL Managed Instance (`sql_managed_instance`) - `sqlmi`
- Cosmos DB (`cosmos_db`) - `cosmos`
- Cosmos DB for NoSQL (`cosmos_db_nosql`) - `cosno`
- Cosmos DB for MongoDB (`cosmos_db_mongodb`) - `cosmon`
- Cosmos DB for PostgreSQL (`cosmos_db_postgresql`) - `cospos`
- PostgreSQL Database (`postgresql_database`) - `psql`
- MySQL Database (`mysql_database`) - `mysql`
- Redis Cache (`redis_cache`) - `redis`
- Managed Redis (`managed_redis`) - `amr`
- And more...

### Networking

- Virtual Network (`virtual_network`) - `vnet`
- Subnet (`subnet`) - `snet`
- Network Security Group (`network_security_group`) - `nsg`
- Network Interface (`network_interface`) - `nic`
- Public IP (`public_ip`) - `pip`
- Load Balancer (Internal) (`load_balancer_internal`) - `lbi`
- Load Balancer (External) (`load_balancer_external`) - `lbe`
- Application Gateway (`application_gateway`) - `agw`
- VPN Gateway (`vpn_gateway`) - `vpng`
- Virtual Network Gateway (`virtual_network_gateway`) - `vgw`
- ExpressRoute Circuit (`expressroute_circuit`) - `erc`
- Firewall (`firewall`) - `afw`
- Firewall Policy (`firewall_policy`) - `afwp`
- Front Door Profile (`front_door_profile`) - `afd`
- Private Endpoint (`private_endpoint`) - `pep`
- Route Table (`route_table`) - `rt`
- NAT Gateway (`nat_gateway`) - `ng`
- And 50+ more...

### Security

- Key Vault (`key_vault`) - `kv`
- Key Vault Managed HSM (`key_vault_managed_hsm`) - `kvmhsm`
- Managed Identity (`managed_identity`) - `id`
- Bastion (`bastion`) - `bas`
- SSH Key (`ssh_key`) - `sshkey`
- WAF Policy (`waf_policy`) - `waf`
- And more...

### Storage

- Storage Account (`storage_account`) - `st`
- File Share (`file_share`) - `share`
- Backup Vault (`backup_vault`) - `bvault`
- Recovery Services Vault (`recovery_services_vault`) - `rsv`
- Storage Sync Service (`storage_sync_service`) - `sss`
- And more...

### Management and Governance

- Resource Group (`resource_group`) - `rg`
- Log Analytics Workspace (`log_analytics_workspace`) - `log`
- Application Insights (`application_insights`) - `appi`
- Automation Account (`automation_account`) - `aa`
- Monitor Action Group (`monitor_action_group`) - `ag`
- Monitor Data Collection Rule (`monitor_data_collection_rule`) - `dcr`
- Management Group (`management_group`) - `mg`
- Purview (`purview`) - `pview`
- And 15+ more...

### Integration

- API Management (`api_management`) - `apim`
- Service Bus Namespace (`service_bus_namespace`) - `sbns`
- Service Bus Queue (`service_bus_queue`) - `sbq`
- Service Bus Topic (`service_bus_topic`) - `sbt`
- Logic App (`logic_app`) - `logic`
- Integration Account (`integration_account`) - `ia`
- And more...

For a complete list of all supported resource types, see the [outputs.tf](outputs.tf) file or the [Microsoft documentation](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations).

## Region Abbreviations

When `use_azure_region_abbr = true`, the following region abbreviations are used:

### Azure Public Cloud Regions

| Region | Abbreviation |
|--------|--------------|
| eastus | eus |
| eastus2 | eus2 |
| westus | wus |
| westus2 | wus2 |
| westus3 | wus3 |
| centralus | cus |
| northcentralus | ncus |
| southcentralus | scus |
| westcentralus | wcus |
| canadacentral | cac |
| canadaeast | cae |
| brazilsouth | brs |
| brazilsoutheast | brse |
| northeurope | neu |
| westeurope | weu |
| uksouth | uks |
| ukwest | ukw |
| francecentral | frc |
| francesouth | frs |
| germanywestcentral | gwc |
| germanynorth | gno |
| norwayeast | noe |
| norwaywest | now |
| switzerlandnorth | szn |
| switzerlandwest | szw |
| swedencentral | swc |
| eastasia | eas |
| southeastasia | seas |
| australiaeast | aue |
| australiasoutheast | ause |
| australiacentral | auc |
| australiacentral2 | auc2 |
| japaneast | jpe |
| japanwest | jpw |
| koreacentral | krc |
| koreasouth | krs |
| southindia | ins |
| centralindia | inc |
| westindia | inw |
| jioindiawest | jiw |
| jioindiacentral | jic |
| uaenorth | uan |
| uaecentral | uac |
| southafricanorth | san |
| southafricawest | saw |
| qatarcentral | qac |

### Azure Government Regions

| Region | Abbreviation |
|--------|--------------|
| usgovvirginia | ugv |
| usgovtexas | ugt |
| usgovarizona | uga |
| usdodeast | ude |
| usdodcentral | udc |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cloud_acronym | Cloud acronym: 'azc' for Azure Commercial or 'azg' for Azure Government | `string` | `"azc"` | no |
| prefix | Prefix for resource names (e.g., company name) | `string` | `""` | no |
| workload | Workload or application name | `string` | `""` | no |
| environment | Environment name: supports both long and short forms (prod/p, dev/d, test/t, stage/s, non-prod/np) | `string` | `"d"` | no |
| location | Azure region location code | `string` | `""` | no |
| delimiter | Delimiter between name components | `string` | `"-"` | no |
| use_azure_region_abbr | Use abbreviated region names | `bool` | `false` | no |

### Environment Validation

The `environment` variable accepts both long and short forms for convenience:

| Short Form | Long Form | Use Case |
|------------|-----------|----------|
| `p` | `prod` | Production environments |
| `d` | `dev` | Development environments |
| `t` | `test` | Test/QA environments |
| `s` | `stage` | Staging environments |
| `np` | `non-prod` | Non-production/shared environments |

Both forms are valid and will work identically in name generation. Choose the form that best fits your naming length requirements.

**Example:**

```hcl
# These produce identical results
module "naming_short" {
  source      = "./azure_tf_naming"
  environment = "p"
}

module "naming_long" {
  source      = "./azure_tf_naming"
  environment = "prod"
}
```

## Outputs

| Name | Description |
|------|-------------|
| base_name | Base name without resource type abbreviation |
| full_base_name | Full base name |
| sanitized_base_name | Base name with no delimiters |
| names | Map of all Azure resource names with abbreviations |
| names_clean | Map of clean resource names for strict naming requirements |
| resource_group | Name for Resource Group |
| virtual_network | Name for Virtual Network |
| storage_account | Name for Storage Account (clean, max 24 chars) |
| key_vault | Name for Key Vault (clean, max 24 chars) |
| container_registry | Name for Container Registry (clean, max 50 chars) |
| ... | And 200+ more resource type outputs |

## Best Practices

1. **Keep names lowercase**: All inputs are validated to be lowercase alphanumeric
2. **Use consistent patterns**: Stick to the same naming convention across your organization
3. **Consider character limits**: Some Azure resources have strict name length limits (e.g., Storage Accounts: 24 chars)
4. **Use region abbreviations for long names**: Enable `use_azure_region_abbr` to keep names shorter
5. **Document your naming strategy**: Maintain documentation of your specific naming patterns
6. **Use cloud_acronym**: Distinguish between Azure Commercial (`azc`) and Government (`azg`) deployments

## Character Limits

Be aware of Azure resource naming restrictions. The module automatically handles these for certain resources:

| Resource | Max Length | Valid Characters | Auto-Clean? |
|----------|------------|------------------|-------------|
| Storage Account | 24 | Lowercase letters and numbers | ✅ Yes |
| Container Registry | 50 | Alphanumeric only | ✅ Yes |
| Key Vault | 24 | Alphanumeric and hyphens | ✅ Yes (truncated) |
| Resource Group | 90 | Alphanumeric, hyphens, underscores, periods | ❌ No |
| Virtual Machine | 64 | Alphanumeric and hyphens | ❌ No |
| AKS Cluster | 63 | Alphanumeric and hyphens | ❌ No |

See [CHARACTER_LIMITS.md](CHARACTER_LIMITS.md) for detailed guidance.

## Contributing

Contributions are welcome! If you find any issues or want to add support for new Azure resource types, please open an issue or pull request.

## References

- [Azure Cloud Adoption Framework - Naming Conventions](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging)
- [Azure Resource Abbreviations](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations)
- [Azure Naming Rules and Restrictions](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules)

## License

See [LICENSE](LICENSE) file for details.
