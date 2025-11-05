# Character-Limited Resources Example
#
# This example demonstrates how to use clean names for Azure resources
# that have strict character limitations (no hyphens, length limits).

terraform {
  required_version = ">= 1.0"
}

# Standard naming
module "naming_standard" {
  source = "../.."

  cloud_acronym = "azc"
  prefix        = "contoso"
  workload      = "webapp"
  environment   = "prod"
  location      = "eastus"
}

# Abbreviated naming for shorter names
module "naming_short" {
  source = "../.."

  cloud_acronym         = "azc"
  prefix                = "cto"
  workload              = "app"
  environment           = "p"
  location              = "eastus"
  use_azure_region_abbr = true
}

# Comparison of standard vs clean names
output "storage_account_names" {
  description = "Storage Account naming comparison"
  value = {
    clean_name       = module.naming_standard.storage_account
    short_clean_name = module.naming_short.storage_account

    standard_length = length(module.naming_standard.storage_account)
    short_length    = length(module.naming_short.storage_account)
  }
}

output "container_registry_names" {
  description = "Container Registry naming comparison"
  value = {
    clean_name       = module.naming_standard.container_registry
    short_clean_name = module.naming_short.container_registry

    standard_length = length(module.naming_standard.container_registry)
    short_length    = length(module.naming_short.container_registry)
  }
}

output "key_vault_names" {
  description = "Key Vault naming comparison"
  value = {
    clean_name       = module.naming_standard.key_vault
    short_clean_name = module.naming_short.key_vault

    standard_length = length(module.naming_standard.key_vault)
    short_length    = length(module.naming_short.key_vault)
  }
}

output "all_clean_names" {
  description = "All available clean names"
  value       = module.naming_standard.names_clean
}

output "character_limits_info" {
  description = "Azure resource character limits reference"
  value = {
    storage_account    = "3-24 chars, lowercase alphanumeric only"
    container_registry = "5-50 chars, alphanumeric only"
    key_vault          = "3-24 chars, alphanumeric and hyphens"
    app_configuration  = "5-50 chars, alphanumeric and hyphens"
    cosmos_db          = "3-44 chars, lowercase alphanumeric and hyphens"
    redis_cache        = "1-63 chars, alphanumeric and hyphens"
  }
}
