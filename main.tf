locals {
  # Azure region abbreviations mapping
  region_abbreviations = {
    # Azure Public Cloud Regions
    eastus             = "eus"
    eastus2            = "eus2"
    westus             = "wus"
    westus2            = "wus2"
    westus3            = "wus3"
    centralus          = "cus"
    northcentralus     = "ncus"
    southcentralus     = "scus"
    westcentralus      = "wcus"
    canadacentral      = "cac"
    canadaeast         = "cae"
    brazilsouth        = "brs"
    brazilsoutheast    = "brse"
    northeurope        = "neu"
    westeurope         = "weu"
    uksouth            = "uks"
    ukwest             = "ukw"
    francecentral      = "frc"
    francesouth        = "frs"
    germanywestcentral = "gwc"
    germanynorth       = "gno"
    norwayeast         = "noe"
    norwaywest         = "now"
    switzerlandnorth   = "szn"
    switzerlandwest    = "szw"
    swedencentral      = "swc"
    eastasia           = "eas"
    southeastasia      = "seas"
    australiaeast      = "aue"
    australiasoutheast = "ause"
    australiacentral   = "auc"
    australiacentral2  = "auc2"
    japaneast          = "jpe"
    japanwest          = "jpw"
    koreacentral       = "krc"
    koreasouth         = "krs"
    southindia         = "ins"
    centralindia       = "inc"
    westindia          = "inw"
    jioindiawest       = "jiw"
    jioindiacentral    = "jic"
    uaenorth           = "uan"
    uaecentral         = "uac"
    southafricanorth   = "san"
    southafricawest    = "saw"
    qatarcentral       = "qac"

    # Azure Government Regions
    usgovvirginia = "ugv"
    usgovtexas    = "ugt"
    usgovarizona  = "uga"
    usdodeast     = "ude"
    usdodcentral  = "udc"
  }

  # Determine location component
  location_abbr = var.use_azure_region_abbr && lookup(local.region_abbreviations, var.location, null) != null ? local.region_abbreviations[var.location] : var.location

  # Build name components list (filter out empty strings)
  name_components = compact([
    var.prefix,
    var.workload,
    var.environment,
    local.location_abbr,
  ])

  # Base name without resource type abbreviation
  base_name = join(var.delimiter, local.name_components)

  # Full base name
  full_base_name = local.base_name

  # Sanitized names for resources with special character requirements
  # Remove delimiters and special characters, lowercase only
  sanitized_base_name = lower(replace(local.full_base_name, var.delimiter, ""))

  # Azure Resource Type Abbreviations (from Microsoft CAF best practices)
  # Reference: https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations

  abbreviations = {
    # AI + Machine Learning
    ai_search                  = "srch"
    ai_services                = "ais"
    ai_foundry_account         = "aif"
    ai_foundry_account_project = "proj"
    ai_foundry_hub             = "hub"
    ai_foundry_hub_project     = "proj"
    ai_video_indexer           = "avi"
    machine_learning_workspace = "mlw"
    openai_service             = "oai"
    bot_service                = "bot"
    computer_vision            = "cv"
    content_moderator          = "cm"
    content_safety             = "cs"
    custom_vision_prediction   = "cstv"
    custom_vision_training     = "cstvt"
    document_intelligence      = "di"
    face_api                   = "face"
    health_insights            = "hi"
    immersive_reader           = "ir"
    language_service           = "lang"
    speech_service             = "spch"
    translator                 = "trsl"

    # Analytics and IoT
    analysis_services                 = "as"
    databricks_access_connector       = "dbac"
    databricks_workspace              = "dbw"
    data_explorer_cluster             = "dec"
    data_explorer_database            = "dedb"
    data_factory                      = "adf"
    digital_twin                      = "dt"
    stream_analytics                  = "asa"
    synapse_private_link_hub          = "synplh"
    synapse_sql_pool                  = "syndp"
    synapse_spark_pool                = "synsp"
    synapse_workspace                 = "synw"
    data_lake_store                   = "dls"
    data_lake_analytics               = "dla"
    event_hub_namespace               = "evhns"
    event_hub                         = "evh"
    event_grid_domain                 = "evgd"
    event_grid_namespace              = "evgns"
    event_grid_subscription           = "evgs"
    event_grid_topic                  = "evgt"
    event_grid_system_topic           = "egst"
    fabric_capacity                   = "fc"
    hdinsight_hadoop_cluster          = "hadoop"
    hdinsight_hbase_cluster           = "hbase"
    hdinsight_kafka_cluster           = "kafka"
    hdinsight_spark_cluster           = "spark"
    hdinsight_storm_cluster           = "storm"
    hdinsight_ml_services_cluster     = "mls"
    iot_hub                           = "iot"
    provisioning_services             = "provs"
    provisioning_services_certificate = "pcert"
    power_bi_embedded                 = "pbi"
    time_series_insights              = "tsi"

    # Compute and Web
    app_service_environment      = "ase"
    app_service_plan             = "asp"
    load_testing                 = "lt"
    availability_set             = "avail"
    arc_enabled_server           = "arcs"
    arc_enabled_kubernetes       = "arck"
    arc_private_link_scope       = "pls"
    arc_gateway                  = "arcgw"
    batch_account                = "ba"
    cloud_service                = "cld"
    communication_services       = "acs"
    disk_encryption_set          = "des"
    function_app                 = "func"
    gallery                      = "gal"
    hosting_environment          = "host"
    image_template               = "it"
    managed_disk_os              = "osdisk"
    managed_disk_data            = "disk"
    notification_hub             = "ntf"
    notification_hub_namespace   = "ntfns"
    proximity_placement_group    = "ppg"
    restore_point_collection     = "rpc"
    snapshot                     = "snap"
    static_web_app               = "stapp"
    virtual_machine              = "vm"
    virtual_machine_scale_set    = "vmss"
    vm_maintenance_configuration = "mc"
    vm_storage_account           = "stvm"
    web_app                      = "app"

    # Containers
    aks_cluster                    = "aks"
    aks_system_node_pool           = "npsystem"
    aks_user_node_pool             = "np"
    container_app                  = "ca"
    container_app_environment      = "cae"
    container_app_job              = "caj"
    container_registry             = "cr"
    container_instance             = "ci"
    service_fabric_cluster         = "sf"
    service_fabric_managed_cluster = "sfmc"

    # Databases
    cosmos_db             = "cosmos"
    cosmos_db_cassandra   = "coscas"
    cosmos_db_mongodb     = "cosmon"
    cosmos_db_nosql       = "cosno"
    cosmos_db_table       = "costab"
    cosmos_db_gremlin     = "cosgrm"
    cosmos_db_postgresql  = "cospos"
    redis_cache           = "redis"
    managed_redis         = "amr"
    sql_server            = "sql"
    sql_database          = "sqldb"
    sql_elastic_job_agent = "sqlja"
    sql_elastic_pool      = "sqlep"
    mysql_database        = "mysql"
    postgresql_database   = "psql"
    sql_stretch_database  = "sqlstrdb"
    sql_managed_instance  = "sqlmi"

    # Developer Tools
    app_configuration = "appcs"
    maps_account      = "map"
    signalr           = "sigr"
    web_pubsub        = "wps"

    # DevOps
    managed_grafana = "amg"

    # Integration
    api_management                 = "apim"
    integration_account            = "ia"
    logic_app                      = "logic"
    service_bus_namespace          = "sbns"
    service_bus_queue              = "sbq"
    service_bus_topic              = "sbt"
    service_bus_topic_subscription = "sbts"

    # Management and Governance
    automation_account            = "aa"
    application_insights          = "appi"
    monitor_action_group          = "ag"
    monitor_data_collection_rule  = "dcr"
    monitor_alert_processing_rule = "apr"
    blueprint                     = "bp"
    blueprint_assignment          = "bpa"
    data_collection_endpoint      = "dce"
    deployment_script             = "script"
    log_analytics_workspace       = "log"
    log_analytics_query_pack      = "pack"
    management_group              = "mg"
    subscription_name             = "sub"
    purview                       = "pview"
    resource_group                = "rg"
    template_spec                 = "ts"

    # Migration
    migrate_project            = "migr"
    database_migration_service = "dms"
    recovery_services_vault    = "rsv"

    # Networking
    application_gateway            = "agw"
    application_security_group     = "asg"
    cdn_profile                    = "cdnp"
    cdn_endpoint                   = "cdne"
    connection                     = "con"
    dns_forwarding_ruleset         = "dnsfrs"
    dns_private_resolver           = "dnspr"
    dns_resolver_inbound_endpoint  = "in"
    dns_resolver_outbound_endpoint = "out"
    firewall                       = "afw"
    firewall_policy                = "afwp"
    expressroute_circuit           = "erc"
    expressroute_direct            = "erd"
    expressroute_gateway           = "ergw"
    front_door_profile             = "afd"
    front_door_endpoint            = "fde"
    front_door_firewall_policy     = "fdfp"
    front_door_classic             = "afd"
    ip_group                       = "ipg"
    load_balancer_internal         = "lbi"
    load_balancer_external         = "lbe"
    load_balancer_rule             = "rule"
    local_network_gateway          = "lgw"
    nat_gateway                    = "ng"
    network_interface              = "nic"
    network_security_perimeter     = "nsp"
    network_security_group         = "nsg"
    network_security_group_rule    = "nsgsr"
    network_watcher                = "nw"
    private_link                   = "pl"
    private_endpoint               = "pep"
    public_ip                      = "pip"
    public_ip_prefix               = "ippre"
    route_filter                   = "rf"
    route_server                   = "rtserv"
    route_table                    = "rt"
    service_endpoint_policy        = "se"
    traffic_manager                = "traf"
    user_defined_route             = "udr"
    virtual_network                = "vnet"
    virtual_network_gateway        = "vgw"
    virtual_network_manager        = "vnm"
    virtual_network_peering        = "peer"
    subnet                         = "snet"
    virtual_wan                    = "vwan"
    virtual_wan_hub                = "vhub"

    # Security
    bastion               = "bas"
    key_vault             = "kv"
    key_vault_managed_hsm = "kvmhsm"
    managed_identity      = "id"
    ssh_key               = "sshkey"
    vpn_gateway           = "vpng"
    vpn_connection        = "vcn"
    vpn_site              = "vst"
    waf_policy            = "waf"
    waf_policy_rule_group = "wafrg"

    # Storage
    storsimple           = "ssimp"
    backup_vault         = "bvault"
    backup_vault_policy  = "bkpol"
    file_share           = "share"
    storage_account      = "st"
    storage_sync_service = "sss"

    # Virtual Desktop Infrastructure
    virtual_desktop_host_pool         = "vdpool"
    virtual_desktop_application_group = "vdag"
    virtual_desktop_workspace         = "vdws"
    virtual_desktop_scaling_plan      = "vdscaling"
  }

  # Generate names for all resource types
  names = {
    for type, abbr in local.abbreviations :
    type => join(var.delimiter, compact([var.cloud_acronym, abbr, local.full_base_name]))
  }

  # Clean names for resources with strict naming requirements
  # These resources don't allow hyphens and have character limits
  names_clean = {
    # Storage Account: 3-24 chars, lowercase letters and numbers only
    storage_account = lower(substr(
      replace("${var.cloud_acronym}${local.abbreviations.storage_account}${local.sanitized_base_name}", "/[^a-z0-9]/", ""),
      0, 24
    ))

    # Container Registry: 5-50 chars, alphanumeric only (no hyphens)
    container_registry = lower(substr(
      replace("${var.cloud_acronym}${local.abbreviations.container_registry}${local.sanitized_base_name}", "/[^a-z0-9]/", ""),
      0, 50
    ))

    # Key Vault: 3-24 chars, alphanumeric and hyphens allowed
    # Just truncate the standard name (with hyphens) to 24 chars
    key_vault = lower(substr(
      join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.key_vault, local.full_base_name])),
      0, 24
    ))

    # App Configuration: 5-50 chars, alphanumeric and hyphens allowed but clean version available
    app_configuration_clean = lower(substr(
      replace("${var.cloud_acronym}${local.abbreviations.app_configuration}${local.sanitized_base_name}", "/[^a-z0-9]/", ""),
      0, 50
    ))

    # Cosmos DB: 3-44 chars, lowercase, alphanumeric and hyphens
    cosmos_db_clean = lower(substr(
      replace("${var.cloud_acronym}${local.abbreviations.cosmos_db}${local.sanitized_base_name}", "/[^a-z0-9]/", ""),
      0, 44
    ))

    # Redis Cache: 1-63 chars, alphanumeric and hyphens
    redis_cache_clean = lower(substr(
      replace("${var.cloud_acronym}${local.abbreviations.redis_cache}${local.sanitized_base_name}", "/[^a-z0-9]/", ""),
      0, 63
    ))

    # Storage Sync Service: 1-260 chars but clean version for consistency
    storage_sync_service_clean = lower(substr(
      replace("${var.cloud_acronym}${local.abbreviations.storage_sync_service}${local.sanitized_base_name}", "/[^a-z0-9]/", ""),
      0, 50
    ))
  }

  # VM-specific naming format
  # Format: {cloud_acronym}{location}{os}{app_name}{env}{number}
  # Example: azcus2lautopd01
  vm_cloud_acronym_short = var.cloud_acronym == "azc" ? "az" : var.cloud_acronym == "azg" ? "ag" : substr(var.cloud_acronym, 0, 2)

  vm_environment_short = length(var.environment) == 1 ? var.environment : (
    var.environment == "prod" ? "p" :
    var.environment == "dev" ? "d" :
    var.environment == "test" ? "t" :
    var.environment == "non-prod" ? "n" :
    var.environment == "stage" ? "s" :
    substr(var.environment, 0, 1)
  )

  # Custom VM hostname following your specific format
  vm_hostname = var.vm_application_name != "" && var.vm_os_type != "" ? lower(
    format("%s%s%s%s%s%02d",
      local.vm_cloud_acronym_short,
      local.location_abbr,
      lower(var.vm_os_type),
      var.vm_application_name,
      local.vm_environment_short,
      var.vm_number
    )
  ) : ""

  # ...existing names generation code...
}
