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

output "subscription_name" {
  description = "Name for Subscription"
  value       = local.names.subscription_name
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

output "vm_hostname" {
  description = "Custom virtual machine hostname following cloud_acronym + location + os + app_name + environment + number format"
  value       = local.vm_hostname
}

output "vm_details" {
  description = "Virtual machine naming details"
  value = {
    hostname            = local.vm_hostname
    cloud_acronym_short = local.vm_cloud_acronym_short
    location            = local.location_abbr
    os_type             = var.vm_os_type
    application_name    = var.vm_application_name
    environment_short   = local.vm_environment_short
  }
}

output "location" {
  description = "Location name used in naming"
  value       = var.location
}

output "managed_disk_data" {
  description = "Name for Managed Disk (Data Disk)"
  value       = local.names.managed_disk_data
}

output "managed_disk_os" {
  description = "Name for Managed Disk (OS Disk)"
  value       = local.names.managed_disk_os
}

# AI and Cognitive Services (Extended)
output "ai_services" {
  description = "Name for AI Services"
  value       = local.names.ai_services
}

output "ai_foundry_account" {
  description = "Name for AI Foundry Account"
  value       = local.names.ai_foundry_account
}

output "ai_foundry_account_project" {
  description = "Name for AI Foundry Account Project"
  value       = local.names.ai_foundry_account_project
}

output "ai_foundry_hub" {
  description = "Name for AI Foundry Hub"
  value       = local.names.ai_foundry_hub
}

output "ai_foundry_hub_project" {
  description = "Name for AI Foundry Hub Project"
  value       = local.names.ai_foundry_hub_project
}

output "ai_video_indexer" {
  description = "Name for AI Video Indexer"
  value       = local.names.ai_video_indexer
}

output "bot_service" {
  description = "Name for Bot Service"
  value       = local.names.bot_service
}

output "computer_vision" {
  description = "Name for Computer Vision"
  value       = local.names.computer_vision
}

output "content_moderator" {
  description = "Name for Content Moderator"
  value       = local.names.content_moderator
}

output "content_safety" {
  description = "Name for Content Safety"
  value       = local.names.content_safety
}

output "custom_vision_prediction" {
  description = "Name for Custom Vision Prediction"
  value       = local.names.custom_vision_prediction
}

output "custom_vision_training" {
  description = "Name for Custom Vision Training"
  value       = local.names.custom_vision_training
}

output "document_intelligence" {
  description = "Name for Document Intelligence"
  value       = local.names.document_intelligence
}

output "face_api" {
  description = "Name for Face API"
  value       = local.names.face_api
}

output "health_insights" {
  description = "Name for Health Insights"
  value       = local.names.health_insights
}

output "immersive_reader" {
  description = "Name for Immersive Reader"
  value       = local.names.immersive_reader
}

output "language_service" {
  description = "Name for Language Service"
  value       = local.names.language_service
}

output "speech_service" {
  description = "Name for Speech Service"
  value       = local.names.speech_service
}

output "translator" {
  description = "Name for Translator"
  value       = local.names.translator
}

# Analytics (Extended)
output "analysis_services" {
  description = "Name for Analysis Services"
  value       = local.names.analysis_services
}

output "databricks_access_connector" {
  description = "Name for Databricks Access Connector"
  value       = local.names.databricks_access_connector
}

output "data_explorer_cluster" {
  description = "Name for Data Explorer Cluster"
  value       = local.names.data_explorer_cluster
}

output "data_explorer_database" {
  description = "Name for Data Explorer Database"
  value       = local.names.data_explorer_database
}

output "digital_twin" {
  description = "Name for Digital Twin"
  value       = local.names.digital_twin
}

output "stream_analytics" {
  description = "Name for Stream Analytics"
  value       = local.names.stream_analytics
}

output "synapse_private_link_hub" {
  description = "Name for Synapse Private Link Hub"
  value       = local.names.synapse_private_link_hub
}

output "synapse_sql_pool" {
  description = "Name for Synapse SQL Pool"
  value       = local.names.synapse_sql_pool
}

output "synapse_spark_pool" {
  description = "Name for Synapse Spark Pool"
  value       = local.names.synapse_spark_pool
}

output "data_lake_store" {
  description = "Name for Data Lake Store"
  value       = local.names.data_lake_store
}

output "data_lake_analytics" {
  description = "Name for Data Lake Analytics"
  value       = local.names.data_lake_analytics
}

output "event_grid_domain" {
  description = "Name for Event Grid Domain"
  value       = local.names.event_grid_domain
}

output "event_grid_namespace" {
  description = "Name for Event Grid Namespace"
  value       = local.names.event_grid_namespace
}

output "event_grid_subscription" {
  description = "Name for Event Grid Subscription"
  value       = local.names.event_grid_subscription
}

output "event_grid_topic" {
  description = "Name for Event Grid Topic"
  value       = local.names.event_grid_topic
}

output "event_grid_system_topic" {
  description = "Name for Event Grid System Topic"
  value       = local.names.event_grid_system_topic
}

output "fabric_capacity" {
  description = "Name for Fabric Capacity"
  value       = local.names.fabric_capacity
}

output "hdinsight_hadoop_cluster" {
  description = "Name for HDInsight Hadoop Cluster"
  value       = local.names.hdinsight_hadoop_cluster
}

output "hdinsight_hbase_cluster" {
  description = "Name for HDInsight HBase Cluster"
  value       = local.names.hdinsight_hbase_cluster
}

output "hdinsight_kafka_cluster" {
  description = "Name for HDInsight Kafka Cluster"
  value       = local.names.hdinsight_kafka_cluster
}

output "hdinsight_spark_cluster" {
  description = "Name for HDInsight Spark Cluster"
  value       = local.names.hdinsight_spark_cluster
}

output "hdinsight_storm_cluster" {
  description = "Name for HDInsight Storm Cluster"
  value       = local.names.hdinsight_storm_cluster
}

output "hdinsight_ml_services_cluster" {
  description = "Name for HDInsight ML Services Cluster"
  value       = local.names.hdinsight_ml_services_cluster
}

output "provisioning_services" {
  description = "Name for Provisioning Services"
  value       = local.names.provisioning_services
}

output "provisioning_services_certificate" {
  description = "Name for Provisioning Services Certificate"
  value       = local.names.provisioning_services_certificate
}

output "power_bi_embedded" {
  description = "Name for Power BI Embedded"
  value       = local.names.power_bi_embedded
}

output "time_series_insights" {
  description = "Name for Time Series Insights"
  value       = local.names.time_series_insights
}

# Compute (Extended)
output "app_service_environment" {
  description = "Name for App Service Environment"
  value       = local.names.app_service_environment
}

output "load_testing" {
  description = "Name for Load Testing"
  value       = local.names.load_testing
}

output "availability_set" {
  description = "Name for Availability Set"
  value       = local.names.availability_set
}

output "arc_enabled_server" {
  description = "Name for Arc Enabled Server"
  value       = local.names.arc_enabled_server
}

output "arc_enabled_kubernetes" {
  description = "Name for Arc Enabled Kubernetes"
  value       = local.names.arc_enabled_kubernetes
}

output "arc_private_link_scope" {
  description = "Name for Arc Private Link Scope"
  value       = local.names.arc_private_link_scope
}

output "arc_gateway" {
  description = "Name for Arc Gateway"
  value       = local.names.arc_gateway
}

output "batch_account" {
  description = "Name for Batch Account"
  value       = local.names.batch_account
}

output "cloud_service" {
  description = "Name for Cloud Service"
  value       = local.names.cloud_service
}

output "communication_services" {
  description = "Name for Communication Services"
  value       = local.names.communication_services
}

output "disk_encryption_set" {
  description = "Name for Disk Encryption Set"
  value       = local.names.disk_encryption_set
}

output "gallery" {
  description = "Name for Gallery"
  value       = local.names.gallery
}

output "hosting_environment" {
  description = "Name for Hosting Environment"
  value       = local.names.hosting_environment
}

output "image_template" {
  description = "Name for Image Template"
  value       = local.names.image_template
}

output "notification_hub" {
  description = "Name for Notification Hub"
  value       = local.names.notification_hub
}

output "notification_hub_namespace" {
  description = "Name for Notification Hub Namespace"
  value       = local.names.notification_hub_namespace
}

output "proximity_placement_group" {
  description = "Name for Proximity Placement Group"
  value       = local.names.proximity_placement_group
}

output "restore_point_collection" {
  description = "Name for Restore Point Collection"
  value       = local.names.restore_point_collection
}

output "snapshot" {
  description = "Name for Snapshot"
  value       = local.names.snapshot
}

output "static_web_app" {
  description = "Name for Static Web App"
  value       = local.names.static_web_app
}

output "vm_maintenance_configuration" {
  description = "Name for VM Maintenance Configuration"
  value       = local.names.vm_maintenance_configuration
}

output "vm_storage_account" {
  description = "Name for VM Storage Account"
  value       = local.names.vm_storage_account
}

# Containers (Extended)
output "aks_system_node_pool" {
  description = "Name for AKS System Node Pool"
  value       = local.names.aks_system_node_pool
}

output "aks_user_node_pool" {
  description = "Name for AKS User Node Pool"
  value       = local.names.aks_user_node_pool
}

output "container_app_environment" {
  description = "Name for Container App Environment"
  value       = local.names.container_app_environment
}

output "container_app_job" {
  description = "Name for Container App Job"
  value       = local.names.container_app_job
}

output "service_fabric_cluster" {
  description = "Name for Service Fabric Cluster"
  value       = local.names.service_fabric_cluster
}

output "service_fabric_managed_cluster" {
  description = "Name for Service Fabric Managed Cluster"
  value       = local.names.service_fabric_managed_cluster
}

# Databases (Extended)
output "cosmos_db_cassandra" {
  description = "Name for Cosmos DB Cassandra"
  value       = local.names.cosmos_db_cassandra
}

output "cosmos_db_mongodb" {
  description = "Name for Cosmos DB MongoDB"
  value       = local.names.cosmos_db_mongodb
}

output "cosmos_db_nosql" {
  description = "Name for Cosmos DB NoSQL"
  value       = local.names.cosmos_db_nosql
}

output "cosmos_db_table" {
  description = "Name for Cosmos DB Table"
  value       = local.names.cosmos_db_table
}

output "cosmos_db_gremlin" {
  description = "Name for Cosmos DB Gremlin"
  value       = local.names.cosmos_db_gremlin
}

output "cosmos_db_postgresql" {
  description = "Name for Cosmos DB PostgreSQL"
  value       = local.names.cosmos_db_postgresql
}

output "managed_redis" {
  description = "Name for Managed Redis"
  value       = local.names.managed_redis
}

output "sql_elastic_job_agent" {
  description = "Name for SQL Elastic Job Agent"
  value       = local.names.sql_elastic_job_agent
}

output "sql_elastic_pool" {
  description = "Name for SQL Elastic Pool"
  value       = local.names.sql_elastic_pool
}

output "sql_stretch_database" {
  description = "Name for SQL Stretch Database"
  value       = local.names.sql_stretch_database
}

output "sql_managed_instance" {
  description = "Name for SQL Managed Instance"
  value       = local.names.sql_managed_instance
}

# Integration (Extended)
output "app_configuration" {
  description = "Name for App Configuration"
  value       = local.names.app_configuration
}

output "maps_account" {
  description = "Name for Maps Account"
  value       = local.names.maps_account
}

output "signalr" {
  description = "Name for SignalR"
  value       = local.names.signalr
}

output "web_pubsub" {
  description = "Name for Web PubSub"
  value       = local.names.web_pubsub
}

output "managed_grafana" {
  description = "Name for Managed Grafana"
  value       = local.names.managed_grafana
}

output "integration_account" {
  description = "Name for Integration Account"
  value       = local.names.integration_account
}

output "service_bus_queue" {
  description = "Name for Service Bus Queue"
  value       = local.names.service_bus_queue
}

output "service_bus_topic" {
  description = "Name for Service Bus Topic"
  value       = local.names.service_bus_topic
}

output "service_bus_topic_subscription" {
  description = "Name for Service Bus Topic Subscription"
  value       = local.names.service_bus_topic_subscription
}

# Management and Governance (Extended)
output "monitor_action_group" {
  description = "Name for Monitor Action Group"
  value       = local.names.monitor_action_group
}

output "monitor_data_collection_rule" {
  description = "Name for Monitor Data Collection Rule"
  value       = local.names.monitor_data_collection_rule
}

output "monitor_alert_processing_rule" {
  description = "Name for Monitor Alert Processing Rule"
  value       = local.names.monitor_alert_processing_rule
}

output "blueprint" {
  description = "Name for Blueprint"
  value       = local.names.blueprint
}

output "blueprint_assignment" {
  description = "Name for Blueprint Assignment"
  value       = local.names.blueprint_assignment
}

output "data_collection_endpoint" {
  description = "Name for Data Collection Endpoint"
  value       = local.names.data_collection_endpoint
}

output "deployment_script" {
  description = "Name for Deployment Script"
  value       = local.names.deployment_script
}

output "log_analytics_query_pack" {
  description = "Name for Log Analytics Query Pack"
  value       = local.names.log_analytics_query_pack
}

output "management_group" {
  description = "Name for Management Group"
  value       = local.names.management_group
}

output "purview" {
  description = "Name for Purview"
  value       = local.names.purview
}

output "template_spec" {
  description = "Name for Template Spec"
  value       = local.names.template_spec
}

# Migration
output "migrate_project" {
  description = "Name for Migrate Project"
  value       = local.names.migrate_project
}

output "database_migration_service" {
  description = "Name for Database Migration Service"
  value       = local.names.database_migration_service
}

# Networking (Extended)
output "application_security_group" {
  description = "Name for Application Security Group"
  value       = local.names.application_security_group
}

output "cdn_profile" {
  description = "Name for CDN Profile"
  value       = local.names.cdn_profile
}

output "cdn_endpoint" {
  description = "Name for CDN Endpoint"
  value       = local.names.cdn_endpoint
}

output "connection" {
  description = "Name for Connection"
  value       = local.names.connection
}

output "dns_forwarding_ruleset" {
  description = "Name for DNS Forwarding Ruleset"
  value       = local.names.dns_forwarding_ruleset
}

output "dns_private_resolver" {
  description = "Name for DNS Private Resolver"
  value       = local.names.dns_private_resolver
}

output "dns_resolver_inbound_endpoint" {
  description = "Name for DNS Resolver Inbound Endpoint"
  value       = local.names.dns_resolver_inbound_endpoint
}

output "dns_resolver_outbound_endpoint" {
  description = "Name for DNS Resolver Outbound Endpoint"
  value       = local.names.dns_resolver_outbound_endpoint
}

output "firewall_policy" {
  description = "Name for Firewall Policy"
  value       = local.names.firewall_policy
}

output "expressroute_circuit" {
  description = "Name for ExpressRoute Circuit"
  value       = local.names.expressroute_circuit
}

output "expressroute_direct" {
  description = "Name for ExpressRoute Direct"
  value       = local.names.expressroute_direct
}

output "expressroute_gateway" {
  description = "Name for ExpressRoute Gateway"
  value       = local.names.expressroute_gateway
}

output "front_door_profile" {
  description = "Name for Front Door Profile"
  value       = local.names.front_door_profile
}

output "front_door_endpoint" {
  description = "Name for Front Door Endpoint"
  value       = local.names.front_door_endpoint
}

output "front_door_firewall_policy" {
  description = "Name for Front Door Firewall Policy"
  value       = local.names.front_door_firewall_policy
}

output "front_door_classic" {
  description = "Name for Front Door Classic"
  value       = local.names.front_door_classic
}

output "ip_group" {
  description = "Name for IP Group"
  value       = local.names.ip_group
}

output "load_balancer_rule" {
  description = "Name for Load Balancer Rule"
  value       = local.names.load_balancer_rule
}

output "local_network_gateway" {
  description = "Name for Local Network Gateway"
  value       = local.names.local_network_gateway
}

output "nat_gateway" {
  description = "Name for NAT Gateway"
  value       = local.names.nat_gateway
}

output "network_security_perimeter" {
  description = "Name for Network Security Perimeter"
  value       = local.names.network_security_perimeter
}

output "network_security_group_rule" {
  description = "Name for Network Security Group Rule"
  value       = local.names.network_security_group_rule
}

output "network_watcher" {
  description = "Name for Network Watcher"
  value       = local.names.network_watcher
}

output "private_link" {
  description = "Name for Private Link"
  value       = local.names.private_link
}

output "public_ip_prefix" {
  description = "Name for Public IP Prefix"
  value       = local.names.public_ip_prefix
}

output "route_filter" {
  description = "Name for Route Filter"
  value       = local.names.route_filter
}

output "route_server" {
  description = "Name for Route Server"
  value       = local.names.route_server
}

output "service_endpoint_policy" {
  description = "Name for Service Endpoint Policy"
  value       = local.names.service_endpoint_policy
}

output "traffic_manager" {
  description = "Name for Traffic Manager"
  value       = local.names.traffic_manager
}

output "user_defined_route" {
  description = "Name for User Defined Route"
  value       = local.names.user_defined_route
}

output "virtual_network_gateway" {
  description = "Name for Virtual Network Gateway"
  value       = local.names.virtual_network_gateway
}

output "virtual_network_manager" {
  description = "Name for Virtual Network Manager"
  value       = local.names.virtual_network_manager
}

output "virtual_network_peering" {
  description = "Name for Virtual Network Peering"
  value       = local.names.virtual_network_peering
}

output "virtual_wan" {
  description = "Name for Virtual WAN"
  value       = local.names.virtual_wan
}

output "virtual_wan_hub" {
  description = "Name for Virtual WAN Hub"
  value       = local.names.virtual_wan_hub
}

output "vpn_connection" {
  description = "Name for VPN Connection"
  value       = local.names.vpn_connection
}

output "vpn_site" {
  description = "Name for VPN Site"
  value       = local.names.vpn_site
}

output "waf_policy" {
  description = "Name for WAF Policy"
  value       = local.names.waf_policy
}

output "waf_policy_rule_group" {
  description = "Name for WAF Policy Rule Group"
  value       = local.names.waf_policy_rule_group
}

# Security (Extended)
output "key_vault_managed_hsm" {
  description = "Name for Key Vault Managed HSM"
  value       = local.names.key_vault_managed_hsm
}

output "ssh_key" {
  description = "Name for SSH Key"
  value       = local.names.ssh_key
}

# Storage (Extended)
output "storsimple" {
  description = "Name for StorSimple"
  value       = local.names.storsimple
}

output "backup_vault_policy" {
  description = "Name for Backup Vault Policy"
  value       = local.names.backup_vault_policy
}

output "storage_sync_service" {
  description = "Name for Storage Sync Service"
  value       = local.names.storage_sync_service
}

# Virtual Desktop
output "virtual_desktop_host_pool" {
  description = "Name for Virtual Desktop Host Pool"
  value       = local.names.virtual_desktop_host_pool
}

output "virtual_desktop_application_group" {
  description = "Name for Virtual Desktop Application Group"
  value       = local.names.virtual_desktop_application_group
}

output "virtual_desktop_workspace" {
  description = "Name for Virtual Desktop Workspace"
  value       = local.names.virtual_desktop_workspace
}

output "virtual_desktop_scaling_plan" {
  description = "Name for Virtual Desktop Scaling Plan"
  value       = local.names.virtual_desktop_scaling_plan
}
