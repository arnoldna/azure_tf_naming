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

# Comparison outputs for all resource types with character limits

# AI + Machine Learning
output "ai_search_names" {
  description = "AI Search naming comparison (2-60 chars)"
  value = {
    clean_name       = module.naming_standard.names_clean.ai_search
    short_clean_name = module.naming_short.names_clean.ai_search
    standard_length  = length(module.naming_standard.names_clean.ai_search)
    short_length     = length(module.naming_short.names_clean.ai_search)
  }
}

output "machine_learning_workspace_names" {
  description = "Machine Learning Workspace naming comparison (3-33 chars)"
  value = {
    clean_name       = module.naming_standard.names_clean.machine_learning_workspace
    short_clean_name = module.naming_short.names_clean.machine_learning_workspace
    standard_length  = length(module.naming_standard.names_clean.machine_learning_workspace)
    short_length     = length(module.naming_short.names_clean.machine_learning_workspace)
  }
}

# Analytics and IoT
output "databricks_workspace_names" {
  description = "Databricks Workspace naming comparison (3-30 chars)"
  value = {
    clean_name       = module.naming_standard.names_clean.databricks_workspace
    short_clean_name = module.naming_short.names_clean.databricks_workspace
    standard_length  = length(module.naming_standard.names_clean.databricks_workspace)
    short_length     = length(module.naming_short.names_clean.databricks_workspace)
  }
}

output "data_factory_names" {
  description = "Data Factory naming comparison (3-63 chars)"
  value = {
    clean_name       = module.naming_standard.names_clean.data_factory
    short_clean_name = module.naming_short.names_clean.data_factory
    standard_length  = length(module.naming_standard.names_clean.data_factory)
    short_length     = length(module.naming_short.names_clean.data_factory)
  }
}

output "synapse_workspace_names" {
  description = "Synapse Workspace naming comparison (1-50 chars)"
  value = {
    clean_name       = module.naming_standard.names_clean.synapse_workspace
    short_clean_name = module.naming_short.names_clean.synapse_workspace
    standard_length  = length(module.naming_standard.names_clean.synapse_workspace)
    short_length     = length(module.naming_short.names_clean.synapse_workspace)
  }
}

output "event_hub_namespace_names" {
  description = "Event Hub Namespace naming comparison (6-50 chars)"
  value = {
    clean_name       = module.naming_standard.names_clean.event_hub_namespace
    short_clean_name = module.naming_short.names_clean.event_hub_namespace
    standard_length  = length(module.naming_standard.names_clean.event_hub_namespace)
    short_length     = length(module.naming_short.names_clean.event_hub_namespace)
  }
}

output "iot_hub_names" {
  description = "IoT Hub naming comparison (3-50 chars)"
  value = {
    clean_name       = module.naming_standard.names_clean.iot_hub
    short_clean_name = module.naming_short.names_clean.iot_hub
    standard_length  = length(module.naming_standard.names_clean.iot_hub)
    short_length     = length(module.naming_short.names_clean.iot_hub)
  }
}

# Compute and Web
output "app_service_plan_names" {
  description = "App Service Plan naming comparison (1-40 chars)"
  value = {
    clean_name       = module.naming_standard.names_clean.app_service_plan
    short_clean_name = module.naming_short.names_clean.app_service_plan
    standard_length  = length(module.naming_standard.names_clean.app_service_plan)
    short_length     = length(module.naming_short.names_clean.app_service_plan)
  }
}

output "function_app_names" {
  description = "Function App naming comparison (2-60 chars)"
  value = {
    clean_name       = module.naming_standard.names_clean.function_app
    short_clean_name = module.naming_short.names_clean.function_app
    standard_length  = length(module.naming_standard.names_clean.function_app)
    short_length     = length(module.naming_short.names_clean.function_app)
  }
}

output "web_app_names" {
  description = "Web App naming comparison (2-60 chars)"
  value = {
    clean_name       = module.naming_standard.names_clean.web_app
    short_clean_name = module.naming_short.names_clean.web_app
    standard_length  = length(module.naming_standard.names_clean.web_app)
    short_length     = length(module.naming_short.names_clean.web_app)
  }
}

output "static_web_app_names" {
  description = "Static Web App naming comparison (1-40 chars)"
  value = {
    clean_name       = module.naming_standard.names_clean.static_web_app
    short_clean_name = module.naming_short.names_clean.static_web_app
    standard_length  = length(module.naming_standard.names_clean.static_web_app)
    short_length     = length(module.naming_short.names_clean.static_web_app)
  }
}

output "virtual_machine_names" {
  description = "Virtual Machine naming comparison (1-64 chars)"
  value = {
    clean_name       = module.naming_standard.names_clean.virtual_machine
    short_clean_name = module.naming_short.names_clean.virtual_machine
    standard_length  = length(module.naming_standard.names_clean.virtual_machine)
    short_length     = length(module.naming_short.names_clean.virtual_machine)
  }
}

output "batch_account_names" {
  description = "Batch Account naming comparison (3-24 chars, lowercase alphanumeric only)"
  value = {
    clean_name       = module.naming_standard.names_clean.batch_account
    short_clean_name = module.naming_short.names_clean.batch_account
    standard_length  = length(module.naming_standard.names_clean.batch_account)
    short_length     = length(module.naming_short.names_clean.batch_account)
  }
}

# Containers
output "aks_cluster_names" {
  description = "AKS Cluster naming comparison (1-63 chars)"
  value = {
    clean_name       = module.naming_standard.names_clean.aks_cluster
    short_clean_name = module.naming_short.names_clean.aks_cluster
    standard_length  = length(module.naming_standard.names_clean.aks_cluster)
    short_length     = length(module.naming_short.names_clean.aks_cluster)
  }
}

output "container_registry_names" {
  description = "Container Registry naming comparison (5-50 chars, alphanumeric only)"
  value = {
    clean_name       = module.naming_standard.names_clean.container_registry
    short_clean_name = module.naming_short.names_clean.container_registry
    standard_length  = length(module.naming_standard.names_clean.container_registry)
    short_length     = length(module.naming_short.names_clean.container_registry)
  }
}

output "container_app_names" {
  description = "Container App naming comparison (2-32 chars)"
  value = {
    clean_name       = module.naming_standard.names_clean.container_app
    short_clean_name = module.naming_short.names_clean.container_app
    standard_length  = length(module.naming_standard.names_clean.container_app)
    short_length     = length(module.naming_short.names_clean.container_app)
  }
}

# Databases
output "cosmos_db_names" {
  description = "Cosmos DB naming comparison (3-44 chars, lowercase)"
  value = {
    clean_name       = module.naming_standard.names_clean.cosmos_db
    short_clean_name = module.naming_short.names_clean.cosmos_db
    standard_length  = length(module.naming_standard.names_clean.cosmos_db)
    short_length     = length(module.naming_short.names_clean.cosmos_db)
  }
}

output "redis_cache_names" {
  description = "Redis Cache naming comparison (1-63 chars)"
  value = {
    clean_name       = module.naming_standard.names_clean.redis_cache
    short_clean_name = module.naming_short.names_clean.redis_cache
    standard_length  = length(module.naming_standard.names_clean.redis_cache)
    short_length     = length(module.naming_short.names_clean.redis_cache)
  }
}

output "sql_server_names" {
  description = "SQL Server naming comparison (1-63 chars, lowercase)"
  value = {
    clean_name       = module.naming_standard.names_clean.sql_server
    short_clean_name = module.naming_short.names_clean.sql_server
    standard_length  = length(module.naming_standard.names_clean.sql_server)
    short_length     = length(module.naming_short.names_clean.sql_server)
  }
}

output "sql_database_names" {
  description = "SQL Database naming comparison (1-128 chars)"
  value = {
    clean_name       = module.naming_standard.names_clean.sql_database
    short_clean_name = module.naming_short.names_clean.sql_database
    standard_length  = length(module.naming_standard.names_clean.sql_database)
    short_length     = length(module.naming_short.names_clean.sql_database)
  }
}

# Developer Tools
output "app_configuration_names" {
  description = "App Configuration naming comparison (5-50 chars)"
  value = {
    clean_name       = module.naming_standard.names_clean.app_configuration
    short_clean_name = module.naming_short.names_clean.app_configuration
    standard_length  = length(module.naming_standard.names_clean.app_configuration)
    short_length     = length(module.naming_short.names_clean.app_configuration)
  }
}

output "signalr_names" {
  description = "SignalR naming comparison (3-63 chars)"
  value = {
    clean_name       = module.naming_standard.names_clean.signalr
    short_clean_name = module.naming_short.names_clean.signalr
    standard_length  = length(module.naming_standard.names_clean.signalr)
    short_length     = length(module.naming_short.names_clean.signalr)
  }
}

# Integration
output "api_management_names" {
  description = "API Management naming comparison (1-50 chars)"
  value = {
    clean_name       = module.naming_standard.names_clean.api_management
    short_clean_name = module.naming_short.names_clean.api_management
    standard_length  = length(module.naming_standard.names_clean.api_management)
    short_length     = length(module.naming_short.names_clean.api_management)
  }
}

output "service_bus_namespace_names" {
  description = "Service Bus Namespace naming comparison (6-50 chars)"
  value = {
    clean_name       = module.naming_standard.names_clean.service_bus_namespace
    short_clean_name = module.naming_short.names_clean.service_bus_namespace
    standard_length  = length(module.naming_standard.names_clean.service_bus_namespace)
    short_length     = length(module.naming_short.names_clean.service_bus_namespace)
  }
}

# Management and Governance
output "automation_account_names" {
  description = "Automation Account naming comparison (6-50 chars)"
  value = {
    clean_name       = module.naming_standard.names_clean.automation_account
    short_clean_name = module.naming_short.names_clean.automation_account
    standard_length  = length(module.naming_standard.names_clean.automation_account)
    short_length     = length(module.naming_short.names_clean.automation_account)
  }
}

output "log_analytics_workspace_names" {
  description = "Log Analytics Workspace naming comparison (4-63 chars)"
  value = {
    clean_name       = module.naming_standard.names_clean.log_analytics_workspace
    short_clean_name = module.naming_short.names_clean.log_analytics_workspace
    standard_length  = length(module.naming_standard.names_clean.log_analytics_workspace)
    short_length     = length(module.naming_short.names_clean.log_analytics_workspace)
  }
}

output "resource_group_names" {
  description = "Resource Group naming comparison (1-90 chars)"
  value = {
    clean_name       = module.naming_standard.names_clean.resource_group
    short_clean_name = module.naming_short.names_clean.resource_group
    standard_length  = length(module.naming_standard.names_clean.resource_group)
    short_length     = length(module.naming_short.names_clean.resource_group)
  }
}

# Networking
output "virtual_network_names" {
  description = "Virtual Network naming comparison (2-64 chars)"
  value = {
    clean_name       = module.naming_standard.names_clean.virtual_network
    short_clean_name = module.naming_short.names_clean.virtual_network
    standard_length  = length(module.naming_standard.names_clean.virtual_network)
    short_length     = length(module.naming_short.names_clean.virtual_network)
  }
}

output "subnet_names" {
  description = "Subnet naming comparison (1-80 chars)"
  value = {
    clean_name       = module.naming_standard.names_clean.subnet
    short_clean_name = module.naming_short.names_clean.subnet
    standard_length  = length(module.naming_standard.names_clean.subnet)
    short_length     = length(module.naming_short.names_clean.subnet)
  }
}

output "network_security_group_names" {
  description = "Network Security Group naming comparison (1-80 chars)"
  value = {
    clean_name       = module.naming_standard.names_clean.network_security_group
    short_clean_name = module.naming_short.names_clean.network_security_group
    standard_length  = length(module.naming_standard.names_clean.network_security_group)
    short_length     = length(module.naming_short.names_clean.network_security_group)
  }
}

output "application_gateway_names" {
  description = "Application Gateway naming comparison (1-80 chars)"
  value = {
    clean_name       = module.naming_standard.names_clean.application_gateway
    short_clean_name = module.naming_short.names_clean.application_gateway
    standard_length  = length(module.naming_standard.names_clean.application_gateway)
    short_length     = length(module.naming_short.names_clean.application_gateway)
  }
}

output "vpn_gateway_names" {
  description = "VPN Gateway naming comparison (1-80 chars)"
  value = {
    clean_name       = module.naming_standard.names_clean.vpn_gateway
    short_clean_name = module.naming_short.names_clean.vpn_gateway
    standard_length  = length(module.naming_standard.names_clean.vpn_gateway)
    short_length     = length(module.naming_short.names_clean.vpn_gateway)
  }
}

output "front_door_profile_names" {
  description = "Front Door Profile naming comparison (5-64 chars)"
  value = {
    clean_name       = module.naming_standard.names_clean.front_door_profile
    short_clean_name = module.naming_short.names_clean.front_door_profile
    standard_length  = length(module.naming_standard.names_clean.front_door_profile)
    short_length     = length(module.naming_short.names_clean.front_door_profile)
  }
}

# Security
output "key_vault_names" {
  description = "Key Vault naming comparison (3-24 chars)"
  value = {
    clean_name       = module.naming_standard.names_clean.key_vault
    short_clean_name = module.naming_short.names_clean.key_vault
    standard_length  = length(module.naming_standard.names_clean.key_vault)
    short_length     = length(module.naming_short.names_clean.key_vault)
  }
}

output "key_vault_managed_hsm_names" {
  description = "Key Vault Managed HSM naming comparison (3-24 chars)"
  value = {
    clean_name       = module.naming_standard.names_clean.key_vault_managed_hsm
    short_clean_name = module.naming_short.names_clean.key_vault_managed_hsm
    standard_length  = length(module.naming_standard.names_clean.key_vault_managed_hsm)
    short_length     = length(module.naming_short.names_clean.key_vault_managed_hsm)
  }
}

output "managed_identity_names" {
  description = "Managed Identity naming comparison (3-128 chars)"
  value = {
    clean_name       = module.naming_standard.names_clean.managed_identity
    short_clean_name = module.naming_short.names_clean.managed_identity
    standard_length  = length(module.naming_standard.names_clean.managed_identity)
    short_length     = length(module.naming_short.names_clean.managed_identity)
  }
}

# Storage
output "storage_account_names" {
  description = "Storage Account naming comparison (3-24 chars, lowercase alphanumeric only)"
  value = {
    clean_name       = module.naming_standard.names_clean.storage_account
    short_clean_name = module.naming_short.names_clean.storage_account
    standard_length  = length(module.naming_standard.names_clean.storage_account)
    short_length     = length(module.naming_short.names_clean.storage_account)
  }
}

output "file_share_names" {
  description = "File Share naming comparison (3-63 chars, lowercase)"
  value = {
    clean_name       = module.naming_standard.names_clean.file_share
    short_clean_name = module.naming_short.names_clean.file_share
    standard_length  = length(module.naming_standard.names_clean.file_share)
    short_length     = length(module.naming_short.names_clean.file_share)
  }
}

output "recovery_services_vault_names" {
  description = "Recovery Services Vault naming comparison (2-50 chars)"
  value = {
    clean_name       = module.naming_standard.names_clean.recovery_services_vault
    short_clean_name = module.naming_short.names_clean.recovery_services_vault
    standard_length  = length(module.naming_standard.names_clean.recovery_services_vault)
    short_length     = length(module.naming_short.names_clean.recovery_services_vault)
  }
}

# Virtual Desktop Infrastructure
output "virtual_desktop_host_pool_names" {
  description = "Virtual Desktop Host Pool naming comparison (3-64 chars)"
  value = {
    clean_name       = module.naming_standard.names_clean.virtual_desktop_host_pool
    short_clean_name = module.naming_short.names_clean.virtual_desktop_host_pool
    standard_length  = length(module.naming_standard.names_clean.virtual_desktop_host_pool)
    short_length     = length(module.naming_short.names_clean.virtual_desktop_host_pool)
  }
}

# Summary output
output "all_clean_names" {
  description = "All available clean names"
  value       = module.naming_standard.names_clean
}

output "character_limits_summary" {
  description = "Azure resource character limits reference"
  value = {
    # Strictest limits (most likely to need abbreviation)
    storage_account            = "3-24 chars, lowercase alphanumeric only"
    key_vault                  = "3-24 chars, alphanumeric and hyphens"
    key_vault_managed_hsm      = "3-24 chars, alphanumeric and hyphens"
    batch_account              = "3-24 chars, lowercase alphanumeric only"
    databricks_workspace       = "3-30 chars, alphanumeric and hyphens"
    container_app              = "2-32 chars, lowercase alphanumeric and hyphens"
    machine_learning_workspace = "3-33 chars, alphanumeric and hyphens"
    app_service_plan           = "1-40 chars, alphanumeric and hyphens"
    static_web_app             = "1-40 chars, alphanumeric and hyphens"
    cosmos_db                  = "3-44 chars, lowercase alphanumeric and hyphens"

    # Medium limits
    api_management        = "1-50 chars, alphanumeric and hyphens"
    event_hub_namespace   = "6-50 chars, alphanumeric and hyphens"
    service_bus_namespace = "6-50 chars, alphanumeric and hyphens"
    iot_hub               = "3-50 chars, alphanumeric and hyphens"
    synapse_workspace     = "1-50 chars, lowercase alphanumeric and hyphens"
    container_registry    = "5-50 chars, alphanumeric only"
    app_configuration     = "5-50 chars, alphanumeric, hyphens, and underscores"

    # Moderate limits
    ai_search               = "2-60 chars, lowercase alphanumeric and hyphens"
    function_app            = "2-60 chars, lowercase alphanumeric and hyphens"
    web_app                 = "2-60 chars, lowercase alphanumeric and hyphens"
    aks_cluster             = "1-63 chars, alphanumeric, hyphens, and underscores"
    redis_cache             = "1-63 chars, alphanumeric and hyphens"
    sql_server              = "1-63 chars, lowercase alphanumeric and hyphens"
    log_analytics_workspace = "4-63 chars, alphanumeric and hyphens"
    data_factory            = "3-63 chars, alphanumeric and hyphens"
    signalr                 = "3-63 chars, alphanumeric and hyphens"
    file_share              = "3-63 chars, lowercase alphanumeric and hyphens"

    # Relaxed limits
    virtual_network        = "2-64 chars, alphanumeric, hyphens, underscores, and periods"
    virtual_machine        = "1-64 chars, alphanumeric and hyphens"
    front_door_profile     = "5-64 chars, alphanumeric and hyphens"
    subnet                 = "1-80 chars, alphanumeric, hyphens, underscores, and periods"
    network_security_group = "1-80 chars, alphanumeric, hyphens, underscores, and periods"
    application_gateway    = "1-80 chars, alphanumeric, hyphens, and underscores"
    vpn_gateway            = "1-80 chars, alphanumeric, hyphens, and underscores"
    resource_group         = "1-90 chars, alphanumeric, hyphens, underscores, periods, and parentheses"
    sql_database           = "1-128 chars, alphanumeric, hyphens, and underscores"
    managed_identity       = "3-128 chars, alphanumeric, hyphens, and underscores"
  }
}

output "validation_check" {
  description = "Validation check for character limits compliance"
  value = {
    storage_account_valid            = length(module.naming_standard.names_clean.storage_account) >= 3 && length(module.naming_standard.names_clean.storage_account) <= 24
    key_vault_valid                  = length(module.naming_standard.names_clean.key_vault) >= 3 && length(module.naming_standard.names_clean.key_vault) <= 24
    container_registry_valid         = length(module.naming_standard.names_clean.container_registry) >= 5 && length(module.naming_standard.names_clean.container_registry) <= 50
    batch_account_valid              = length(module.naming_standard.names_clean.batch_account) >= 3 && length(module.naming_standard.names_clean.batch_account) <= 24
    databricks_workspace_valid       = length(module.naming_standard.names_clean.databricks_workspace) >= 3 && length(module.naming_standard.names_clean.databricks_workspace) <= 30
    container_app_valid              = length(module.naming_standard.names_clean.container_app) >= 2 && length(module.naming_standard.names_clean.container_app) <= 32
    machine_learning_workspace_valid = length(module.naming_standard.names_clean.machine_learning_workspace) >= 3 && length(module.naming_standard.names_clean.machine_learning_workspace) <= 33
    app_service_plan_valid           = length(module.naming_standard.names_clean.app_service_plan) >= 1 && length(module.naming_standard.names_clean.app_service_plan) <= 40
    cosmos_db_valid                  = length(module.naming_standard.names_clean.cosmos_db) >= 3 && length(module.naming_standard.names_clean.cosmos_db) <= 44
  }
}
