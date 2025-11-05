# Base name outputs
output "base_name" {
  description = "Base name without resource type abbreviation"
  value       = local.base_name
}

output "full_base_name" {
  description = "Full base name"
  value       = local.full_base_name
}

# Sanitized base name (no delimiters)
output "sanitized_base_name" {
  description = "Sanitized base name with no delimiters (for resources with strict naming requirements)"
  value       = local.sanitized_base_name
}

# All resource type names
output "names" {
  description = "Map of all Azure resource names with abbreviations"
  value       = local.names
}

# Clean names for resources with special requirements
output "names_clean" {
  description = "Map of clean resource names (no hyphens, length-restricted) for resources like Storage Accounts"
  value       = local.names_clean
}

# AI + Machine Learning
output "ai_search" {
  description = "Name for AI Search"
  value       = local.names.ai_search
}

output "machine_learning_workspace" {
  description = "Name for Azure Machine Learning Workspace"
  value       = local.names.machine_learning_workspace
}

output "openai_service" {
  description = "Name for Azure OpenAI Service"
  value       = local.names.openai_service
}

# Analytics and IoT
output "data_factory" {
  description = "Name for Data Factory"
  value       = local.names.data_factory
}

output "databricks_workspace" {
  description = "Name for Databricks Workspace"
  value       = local.names.databricks_workspace
}

output "synapse_workspace" {
  description = "Name for Synapse Workspace"
  value       = local.names.synapse_workspace
}

output "event_hub_namespace" {
  description = "Name for Event Hub Namespace"
  value       = local.names.event_hub_namespace
}

output "event_hub" {
  description = "Name for Event Hub"
  value       = local.names.event_hub
}

output "iot_hub" {
  description = "Name for IoT Hub"
  value       = local.names.iot_hub
}

# Compute and Web
output "app_service_plan" {
  description = "Name for App Service Plan"
  value       = local.names.app_service_plan
}

output "function_app" {
  description = "Name for Function App"
  value       = local.names.function_app
}

output "web_app" {
  description = "Name for Web App"
  value       = local.names.web_app
}

output "virtual_machine" {
  description = "Name for Virtual Machine"
  value       = local.names.virtual_machine
}

output "virtual_machine_scale_set" {
  description = "Name for Virtual Machine Scale Set"
  value       = local.names.virtual_machine_scale_set
}

# Containers
output "aks_cluster" {
  description = "Name for AKS Cluster"
  value       = local.names.aks_cluster
}

output "container_registry" {
  description = "Name for Container Registry (alphanumeric only, max 50 chars)"
  value       = local.names_clean.container_registry
}

output "container_instance" {
  description = "Name for Container Instance"
  value       = local.names.container_instance
}

output "container_app" {
  description = "Name for Container App"
  value       = local.names.container_app
}

# Databases
output "cosmos_db" {
  description = "Name for Cosmos DB"
  value       = local.names.cosmos_db
}

output "sql_server" {
  description = "Name for SQL Server"
  value       = local.names.sql_server
}

output "sql_database" {
  description = "Name for SQL Database"
  value       = local.names.sql_database
}

output "mysql_database" {
  description = "Name for MySQL Database"
  value       = local.names.mysql_database
}

output "postgresql_database" {
  description = "Name for PostgreSQL Database"
  value       = local.names.postgresql_database
}

output "redis_cache" {
  description = "Name for Redis Cache"
  value       = local.names.redis_cache
}

# Networking
output "virtual_network" {
  description = "Name for Virtual Network"
  value       = local.names.virtual_network
}

output "subnet" {
  description = "Name for Subnet"
  value       = local.names.subnet
}

output "network_security_group" {
  description = "Name for Network Security Group"
  value       = local.names.network_security_group
}

output "network_interface" {
  description = "Name for Network Interface"
  value       = local.names.network_interface
}

output "public_ip" {
  description = "Name for Public IP"
  value       = local.names.public_ip
}

output "load_balancer_internal" {
  description = "Name for Load Balancer (Internal)"
  value       = local.names.load_balancer_internal
}

output "load_balancer_external" {
  description = "Name for Load Balancer (External)"
  value       = local.names.load_balancer_external
}

output "application_gateway" {
  description = "Name for Application Gateway"
  value       = local.names.application_gateway
}

output "firewall" {
  description = "Name for Firewall"
  value       = local.names.firewall
}

output "vpn_gateway" {
  description = "Name for VPN Gateway"
  value       = local.names.vpn_gateway
}

output "route_table" {
  description = "Name for Route Table"
  value       = local.names.route_table
}

output "private_endpoint" {
  description = "Name for Private Endpoint"
  value       = local.names.private_endpoint
}

# Security
output "key_vault" {
  description = "Name for Key Vault (alphanumeric and hyphens, max 24 chars)"
  value       = local.names_clean.key_vault
}

output "managed_identity" {
  description = "Name for Managed Identity"
  value       = local.names.managed_identity
}

output "bastion" {
  description = "Name for Bastion"
  value       = local.names.bastion
}

# Storage
output "storage_account" {
  description = "Name for Storage Account (alphanumeric only, max 24 chars)"
  value       = local.names_clean.storage_account
}

output "file_share" {
  description = "Name for File Share"
  value       = local.names.file_share
}

output "backup_vault" {
  description = "Name for Backup Vault"
  value       = local.names.backup_vault
}

output "recovery_services_vault" {
  description = "Name for Recovery Services Vault"
  value       = local.names.recovery_services_vault
}

# Management and Governance
output "resource_group" {
  description = "Name for Resource Group"
  value       = local.names.resource_group
}

output "log_analytics_workspace" {
  description = "Name for Log Analytics Workspace"
  value       = local.names.log_analytics_workspace
}

output "application_insights" {
  description = "Name for Application Insights"
  value       = local.names.application_insights
}

output "automation_account" {
  description = "Name for Automation Account"
  value       = local.names.automation_account
}

# Integration
output "api_management" {
  description = "Name for API Management"
  value       = local.names.api_management
}

output "service_bus_namespace" {
  description = "Name for Service Bus Namespace"
  value       = local.names.service_bus_namespace
}

output "logic_app" {
  description = "Name for Logic App"
  value       = local.names.logic_app
}
