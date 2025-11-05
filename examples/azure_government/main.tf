# Azure Government Example - Azure Terraform Naming Module
#
# This example demonstrates usage of the naming module
# with Azure Government regions.

terraform {
  required_version = ">= 1.0"
}

# Production Environment - US Gov Virginia
module "naming_gov_virginia" {
  source = "../.."

  cloud_acronym         = "azg" # Azure Government
  prefix                = "dod"
  workload              = "mission"
  environment           = "prod"
  location              = "usgovvirginia"
  use_azure_region_abbr = true
}

# Production Environment - US Gov Texas (DR Site)
module "naming_gov_texas" {
  source = "../.."

  cloud_acronym         = "azg" # Azure Government
  prefix                = "dod"
  workload              = "mission"
  environment           = "prod"
  location              = "usgovtexas"
  use_azure_region_abbr = true
}

# Development Environment - US Gov Arizona
module "naming_gov_arizona_dev" {
  source = "../.."

  cloud_acronym         = "azg" # Azure Government
  prefix                = "dod"
  workload              = "mission"
  environment           = "dev"
  location              = "usgovarizona"
  use_azure_region_abbr = true
}

# DoD East Environment
module "naming_dod_east" {
  source = "../.."

  cloud_acronym         = "azg" # Azure Government
  prefix                = "dod"
  workload              = "classified"
  environment           = "prod"
  location              = "usdodeast"
  use_azure_region_abbr = true
}

# DoD Central Environment
module "naming_dod_central" {
  source = "../.."

  cloud_acronym         = "azg" # Azure Government
  prefix                = "dod"
  workload              = "classified"
  environment           = "prod"
  location              = "usdodcentral"
  use_azure_region_abbr = true
}

# Output examples for Azure Government regions
output "gov_virginia_primary" {
  description = "Azure Government Virginia (Primary) resource names"
  value = {
    resource_group  = module.naming_gov_virginia.resource_group
    virtual_network = module.naming_gov_virginia.virtual_network
    subnet          = module.naming_gov_virginia.subnet
    key_vault       = module.naming_gov_virginia.key_vault
    storage_account = module.naming_gov_virginia.storage_account
    sql_server      = module.naming_gov_virginia.sql_server
    log_analytics   = module.naming_gov_virginia.log_analytics_workspace
  }
}

output "gov_texas_dr" {
  description = "Azure Government Texas (DR) resource names"
  value = {
    resource_group  = module.naming_gov_texas.resource_group
    virtual_network = module.naming_gov_texas.virtual_network
    subnet          = module.naming_gov_texas.subnet
    key_vault       = module.naming_gov_texas.key_vault
    storage_account = module.naming_gov_texas.storage_account
    sql_server      = module.naming_gov_texas.sql_server
    recovery_vault  = module.naming_gov_texas.recovery_services_vault
  }
}

output "gov_arizona_dev" {
  description = "Azure Government Arizona (Development) resource names"
  value = {
    resource_group     = module.naming_gov_arizona_dev.resource_group
    virtual_network    = module.naming_gov_arizona_dev.virtual_network
    aks_cluster        = module.naming_gov_arizona_dev.aks_cluster
    container_registry = module.naming_gov_arizona_dev.container_registry
    app_service_plan   = module.naming_gov_arizona_dev.app_service_plan
    function_app       = module.naming_gov_arizona_dev.function_app
  }
}

output "dod_east_classified" {
  description = "DoD East (Classified) resource names"
  value = {
    resource_group         = module.naming_dod_east.resource_group
    virtual_network        = module.naming_dod_east.virtual_network
    network_security_group = module.naming_dod_east.network_security_group
    key_vault              = module.naming_dod_east.key_vault
    virtual_machine        = module.naming_dod_east.virtual_machine
  }
}

output "dod_central_classified" {
  description = "DoD Central (Classified) resource names"
  value = {
    resource_group         = module.naming_dod_central.resource_group
    virtual_network        = module.naming_dod_central.virtual_network
    network_security_group = module.naming_dod_central.network_security_group
    key_vault              = module.naming_dod_central.key_vault
    virtual_machine        = module.naming_dod_central.virtual_machine
  }
}

# Show comparison of region abbreviations
output "region_comparison" {
  description = "Comparison of region names in resource names"
  value = {
    virginia_rg    = module.naming_gov_virginia.resource_group
    texas_rg       = module.naming_gov_texas.resource_group
    arizona_rg     = module.naming_gov_arizona_dev.resource_group
    dod_east_rg    = module.naming_dod_east.resource_group
    dod_central_rg = module.naming_dod_central.resource_group
  }
}
