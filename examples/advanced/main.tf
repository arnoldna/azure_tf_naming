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
  prefix                = "acme"
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
  environment           = "prod"
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
  environment   = "staging"
  location      = "centralus"
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
