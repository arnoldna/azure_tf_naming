# Advanced Example - Azure Terraform Naming Module
#
# This example demonstrates advanced usage with multiple environments,
# region abbreviations, and differentiation using workload or environment.

terraform {
  required_version = ">= 1.0"
}

# Development Environment - East US
module "naming_dev_eus" {
  source = "../.."

  cloud_acronym         = "azc"
  workload              = "ecommerce"
  environment           = "dev"
  location              = "eastus"
  use_azure_region_abbr = true
}

# Production Environment - East US
module "naming_prod_eus" {
  source = "../.."

  cloud_acronym         = "azc"
  prefix                = "acme"
  workload              = "ecommerce"
  environment           = "p"
  location              = "eastus"
  use_azure_region_abbr = true
}

# Production Environment - West US 2 (DR Site)
module "naming_prod_wus2" {
  source = "../.."

  cloud_acronym         = "azc"
  prefix                = "acme"
  workload              = "ecommerce"
  environment           = "prod"
  location              = "westus2"
  use_azure_region_abbr = true
}

# Staging Environment
module "naming_staging" {
  source = "../.."

  cloud_acronym = "azc"
  prefix        = "acme"
  workload      = "ecommerce"
  environment   = "stage"
  location      = "centralus"
}

# Example: Linux VM for autopilot application in development
module "vm_linux_autopilot_dev" {
  source = "../.."

  cloud_acronym         = "azc"
  workload              = "ecommerce"
  environment           = "dev"
  location              = "eastus2"
  use_azure_region_abbr = true

  # VM-specific settings
  vm_os_type          = "l"
  vm_application_name = "autop"
}

# Example: Windows VM for NDS application in production
module "vm_windows_nds_prod" {
  source = "../.."

  cloud_acronym         = "azc"
  workload              = "ecommerce"
  environment           = "p"
  location              = "centralus"
  use_azure_region_abbr = true

  # VM-specific settings
  vm_os_type          = "w"
  vm_application_name = "nds"
}

# Example: Azure Government VM
module "vm_gov_airway" {
  source = "../.."

  cloud_acronym         = "azg"
  environment           = "d"
  location              = "usgovvirginia"
  use_azure_region_abbr = true

  # VM-specific settings
  vm_os_type          = "l"
  vm_application_name = "airway"
}

# Output examples for each environment
output "dev_environment" {
  description = "Development environment resource names"
  value = {
    subscription_name  = module.naming_dev_eus.subscription_name
    resource_group     = module.naming_dev_eus.resource_group
    virtual_network    = module.naming_dev_eus.virtual_network
    aks_cluster        = module.naming_dev_eus.aks_cluster
    key_vault          = "${module.naming_dev_eus.key_vault}-01"
    storage_account    = module.naming_dev_eus.storage_account
    sql_server         = module.naming_dev_eus.sql_server
    container_registry = module.naming_dev_eus.container_registry
  }
}

output "locations" {
  description = "Locations used in the examples"
  value = {
    dev_eus         = module.naming_dev_eus.location
    prod_eus        = module.naming_prod_eus.location
    prod_wus2       = module.naming_prod_wus2.location
    staging         = module.naming_staging.location
    linux_vm_dev    = module.vm_linux_autopilot_dev.location
    windows_vm_prod = module.vm_windows_nds_prod.location
    gov_vm          = module.vm_gov_airway.location
  }
}

output "prod_environment_primary" {
  description = "Production environment primary site (East US)"
  value = {
    resource_group     = module.naming_prod_eus.resource_group
    virtual_network    = module.naming_prod_eus.virtual_network
    aks_cluster        = module.naming_prod_eus.aks_cluster
    key_vault          = module.naming_prod_eus.key_vault
    storage_account    = module.naming_prod_eus.storage_account
    sql_server         = module.naming_prod_eus.sql_server
    container_registry = module.naming_prod_eus.container_registry
  }
}

output "prod_environment_dr" {
  description = "Production environment DR site (West US 2)"
  value = {
    resource_group     = module.naming_prod_wus2.resource_group
    virtual_network    = module.naming_prod_wus2.virtual_network
    aks_cluster        = module.naming_prod_wus2.aks_cluster
    key_vault          = module.naming_prod_wus2.key_vault
    storage_account    = module.naming_prod_wus2.storage_account
    sql_server         = module.naming_prod_wus2.sql_server
    container_registry = module.naming_prod_wus2.container_registry
  }
}

output "staging_environment" {
  description = "Staging environment"
  value = {
    resource_group   = module.naming_staging.resource_group
    virtual_network  = module.naming_staging.virtual_network
    app_service_plan = module.naming_staging.app_service_plan
    web_app          = module.naming_staging.web_app
    function_app     = module.naming_staging.function_app
    cosmos_db        = module.naming_staging.cosmos_db
    redis_cache      = module.naming_staging.redis_cache
  }
}

# Demonstrate all names output
output "all_resource_types" {
  description = "Map showing all available resource type names for dev environment"
  value       = module.naming_dev_eus.names
}

output "vm_hostnames" {
  description = "Generated VM hostnames"
  value = {
    linux_autopilot_dev = module.vm_linux_autopilot_dev.vm_hostname # azeus2lautopd01
    windows_nds_prod    = module.vm_windows_nds_prod.vm_hostname    # azcuswndsp01
    gov_airway_dev      = module.vm_gov_airway.vm_hostname          # agugvlairwayd02
  }
}
