# Azure Government and Special Regions Support

This module includes full support for Azure Government regions with cloud-specific naming through the `cloud_acronym` variable.

## Supported Cloud Environments

### Azure Public Cloud
Set `cloud_acronym = "azc"` (default) for all standard Azure regions.

### Azure Government
Set `cloud_acronym = "azg"` for Azure Government deployments.

The following Azure Government regions are supported with optional abbreviations:

| Region Name | Region Code | Abbreviation |
|-------------|-------------|--------------|
| US Gov Virginia | `usgovvirginia` | `ugv` |
| US Gov Texas | `usgovtexas` | `ugt` |
| US Gov Arizona | `usgovarizona` | `uga` |
| US DoD East | `usdodeast` | `ude` |
| US DoD Central | `usdodcentral` | `udc` |

## Usage Examples

### Azure Government Example

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

# Output: azgkvdodmissionprodugv (clean, truncated to 24 chars max)
resource "azurerm_key_vault" "example" {
  name                = module.naming.key_vault
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "premium"
}
```

### Multi-Region Government Setup

```hcl
# Primary Site - US Gov Virginia
module "naming_primary" {
  source = "./azure_tf_naming"

  cloud_acronym         = "azg"
  prefix                = "agency"
  workload              = "system"
  environment           = "prod"
  location              = "usgovvirginia"
  use_azure_region_abbr = true
}

# DR Site - US Gov Texas
module "naming_dr" {
  source = "./azure_tf_naming"

  cloud_acronym         = "azg"
  prefix                = "agency"
  workload              = "system"
  environment           = "prod"
  location              = "usgovtexas"
  use_azure_region_abbr = true
}

resource "azurerm_resource_group" "primary" {
  name     = module.naming_primary.resource_group  # azg-rg-agency-system-prod-ugv
  location = "US Gov Virginia"
}

resource "azurerm_resource_group" "dr" {
  name     = module.naming_dr.resource_group  # azg-rg-agency-system-prod-ugt
  location = "US Gov Texas"
}
```

### Azure Commercial vs Government

```hcl
# Commercial Cloud
module "naming_commercial" {
  source = "./azure_tf_naming"

  cloud_acronym = "azc"  # Azure Commercial
  prefix        = "corp"
  workload      = "app"
  environment   = "prod"
  location      = "eastus"
}

# Output: azc-rg-corp-app-prod-eastus
resource "azurerm_resource_group" "commercial" {
  name     = module.naming_commercial.resource_group
  location = "East US"
}
```

## Compliance Considerations

### FedRAMP and DoD Compliance
When deploying to Azure Government regions, ensure your naming conventions align with your organization's compliance requirements:

- Use appropriate classification levels in your naming (consider using the `workload` parameter)
- Separate classified and unclassified workloads using different prefixes or environments
- Consider using the `workload` parameter to indicate the classification level
- Document your naming strategy for audit purposes

### Example: Classified Workload Naming

```hcl
# Classified workload in DoD region
module "naming_classified" {
  source = "./azure_tf_naming"

  cloud_acronym         = "azg"
  prefix                = "dod"
  workload              = "classified"
  environment           = "prod"
  location              = "usdodeast"
  use_azure_region_abbr = true
}

# Output: azg-rg-dod-classified-prod-ude
resource "azurerm_resource_group" "classified" {
  name     = module.naming_classified.resource_group
  location = "US DoD East"
}
```

## Regional Availability

Not all Azure services are available in all regions. Before deploying to Azure Government regions:

1. Verify service availability in your target region
2. Review region-specific documentation
3. Test your naming conventions with actual deployments
4. Consider name length restrictions (some services have stricter limits in government clouds)

## Additional Resources

- [Azure Government Documentation](https://docs.microsoft.com/en-us/azure/azure-government/)
- [Azure Government Services](https://docs.microsoft.com/en-us/azure/azure-government/compare-azure-government-global-azure)
- [FedRAMP Compliance](https://docs.microsoft.com/en-us/azure/compliance/offerings/offering-fedramp)
