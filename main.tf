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

  # Environment abbreviation for sanitized names
  environment_short = length(var.environment) == 1 ? var.environment : (
    var.environment == "prod" ? "p" :
    var.environment == "dev" ? "d" :
    var.environment == "test" ? "t" :
    var.environment == "non-prod" ? "np" :
    var.environment == "stage" ? "s" :
    substr(var.environment, 0, 1)
  )

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

  # Sanitized name components with shortened environment
  sanitized_name_components = compact([
    var.prefix,
    var.workload,
    local.environment_short,
    local.location_abbr,
  ])

  # Sanitized names for resources with special character requirements
  # Remove delimiters and special characters, lowercase only
  sanitized_base_name = lower(replace(join(var.delimiter, local.sanitized_name_components), var.delimiter, ""))

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
  names_base = {
    for type, abbr in local.abbreviations :
    type => join(var.delimiter, compact([var.cloud_acronym, abbr, local.full_base_name]))
  }

  # Clean names for resources with strict naming requirements
  # Reference: https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules
  names_clean = {
    # AI + Machine Learning
    # AI Search: 2-60 chars, lowercase letters, numbers, and hyphens
    ai_search = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.ai_search, local.full_base_name])), "/[^a-z0-9-]/", ""),
      0, 60
    ))

    # AI Services (Cognitive Services): 2-64 chars, alphanumeric and hyphens
    ai_services = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.ai_services, local.full_base_name])), "/[^a-z0-9-]/", ""),
      0, 64
    ))

    # Machine Learning Workspace: 3-33 chars, alphanumeric and hyphens
    machine_learning_workspace = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.machine_learning_workspace, local.full_base_name])), "/[^a-zA-Z0-9-]/", ""),
      0, 33
    ))

    # OpenAI Service: 2-64 chars, alphanumeric and hyphens
    openai_service = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.openai_service, local.full_base_name])), "/[^a-z0-9-]/", ""),
      0, 64
    ))

    # Bot Service: 2-64 chars, alphanumeric, hyphens, and underscores
    bot_service = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.bot_service, local.full_base_name])), "/[^a-z0-9-_]/", ""),
      0, 64
    ))

    # Analytics and IoT
    # Analysis Services: 3-63 chars, lowercase letters and numbers only
    analysis_services = lower(substr(
      replace("${var.cloud_acronym}${local.abbreviations.analysis_services}${local.sanitized_base_name}", "/[^a-z0-9]/", ""),
      0, 63
    ))

    # Databricks Workspace: 3-30 chars, alphanumeric and hyphens
    databricks_workspace = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.databricks_workspace, local.full_base_name])), "/[^a-zA-Z0-9-]/", ""),
      0, 30
    ))

    # Data Factory: 3-63 chars, alphanumeric and hyphens
    data_factory = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.data_factory, local.full_base_name])), "/[^a-zA-Z0-9-]/", ""),
      0, 63
    ))

    # Digital Twin: 3-63 chars, alphanumeric and hyphens
    digital_twin = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.digital_twin, local.full_base_name])), "/[^a-zA-Z0-9-]/", ""),
      0, 63
    ))

    # Stream Analytics: 3-63 chars, alphanumeric, hyphens, and underscores
    stream_analytics = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.stream_analytics, local.full_base_name])), "/[^a-zA-Z0-9-_]/", ""),
      0, 63
    ))

    # Synapse Workspace: 1-50 chars, alphanumeric and hyphens
    synapse_workspace = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.synapse_workspace, local.full_base_name])), "/[^a-z0-9-]/", ""),
      0, 50
    ))

    # Event Hub Namespace: 6-50 chars, alphanumeric and hyphens
    event_hub_namespace = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.event_hub_namespace, local.full_base_name])), "/[^a-zA-Z0-9-]/", ""),
      0, 50
    ))

    # Event Hub: 1-50 chars, alphanumeric, periods, hyphens, and underscores
    event_hub = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.event_hub, local.full_base_name])), "/[^a-zA-Z0-9._-]/", ""),
      0, 50
    ))

    # IoT Hub: 3-50 chars, alphanumeric and hyphens
    iot_hub = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.iot_hub, local.full_base_name])), "/[^a-zA-Z0-9-]/", ""),
      0, 50
    ))

    # Compute and Web
    # App Service Plan: 1-40 chars, alphanumeric and hyphens
    app_service_plan = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.app_service_plan, local.full_base_name])), "/[^a-zA-Z0-9-]/", ""),
      0, 40
    ))

    # Function App: 2-60 chars, alphanumeric and hyphens
    function_app = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.function_app, local.full_base_name])), "/[^a-z0-9-]/", ""),
      0, 60
    ))

    # Web App: 2-60 chars, alphanumeric and hyphens
    web_app = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.web_app, local.full_base_name])), "/[^a-z0-9-]/", ""),
      0, 60
    ))

    # Static Web App: 1-40 chars, alphanumeric and hyphens
    static_web_app = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.static_web_app, local.full_base_name])), "/[^a-zA-Z0-9-]/", ""),
      0, 40
    ))

    # Virtual Machine (Windows): 1-15 chars, alphanumeric and hyphens (cannot be all numbers)
    # Virtual Machine (Linux): 1-64 chars, alphanumeric, hyphens, and underscores
    virtual_machine = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.virtual_machine, local.full_base_name])), "/[^a-zA-Z0-9-]/", ""),
      0, 64
    ))

    # Virtual Machine Scale Set: 1-64 chars, alphanumeric, hyphens, and underscores
    virtual_machine_scale_set = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.virtual_machine_scale_set, local.full_base_name])), "/[^a-zA-Z0-9-_]/", ""),
      0, 64
    ))

    # Availability Set: 1-80 chars, alphanumeric, hyphens, and underscores
    availability_set = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.availability_set, local.full_base_name])), "/[^a-zA-Z0-9-_]/", ""),
      0, 80
    ))

    # Batch Account: 3-24 chars, lowercase letters and numbers only
    batch_account = lower(substr(
      replace("${var.cloud_acronym}${local.abbreviations.batch_account}${local.sanitized_base_name}", "/[^a-z0-9]/", ""),
      0, 24
    ))

    # Managed Disk: 1-80 chars, alphanumeric, hyphens, and underscores
    managed_disk_os = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.managed_disk_os, local.full_base_name])), "/[^a-zA-Z0-9-_]/", ""),
      0, 80
    ))

    managed_disk_data = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.managed_disk_data, local.full_base_name])), "/[^a-zA-Z0-9-_]/", ""),
      0, 80
    ))

    # Snapshot: 1-80 chars, alphanumeric, hyphens, and underscores
    snapshot = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.snapshot, local.full_base_name])), "/[^a-zA-Z0-9-_]/", ""),
      0, 80
    ))

    # Containers
    # AKS Cluster: 1-63 chars, alphanumeric, hyphens, and underscores
    aks_cluster = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.aks_cluster, local.full_base_name])), "/[^a-zA-Z0-9-_]/", ""),
      0, 63
    ))

    # Container Registry: 5-50 chars, alphanumeric only
    container_registry = lower(substr(
      replace("${var.cloud_acronym}${local.abbreviations.container_registry}${local.sanitized_base_name}", "/[^a-z0-9]/", ""),
      0, 50
    ))

    # Container Instance: 1-63 chars, alphanumeric and hyphens
    container_instance = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.container_instance, local.full_base_name])), "/[^a-z0-9-]/", ""),
      0, 63
    ))

    # Container App: 2-32 chars, lowercase letters, numbers, and hyphens
    container_app = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.container_app, local.full_base_name])), "/[^a-z0-9-]/", ""),
      0, 32
    ))

    # Container App Environment: 2-60 chars, alphanumeric and hyphens
    container_app_environment = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.container_app_environment, local.full_base_name])), "/[^a-zA-Z0-9-]/", ""),
      0, 60
    ))

    # Databases
    # Cosmos DB: 3-44 chars, lowercase letters, numbers, and hyphens
    cosmos_db = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.cosmos_db, local.full_base_name])), "/[^a-z0-9-]/", ""),
      0, 44
    ))

    # Redis Cache: 1-63 chars, alphanumeric and hyphens
    redis_cache = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.redis_cache, local.full_base_name])), "/[^a-zA-Z0-9-]/", ""),
      0, 63
    ))

    # Managed Redis: 1-63 chars, alphanumeric and hyphens
    managed_redis = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.managed_redis, local.full_base_name])), "/[^a-zA-Z0-9-]/", ""),
      0, 63
    ))

    # SQL Server: 1-63 chars, lowercase letters, numbers, and hyphens
    sql_server = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.sql_server, local.full_base_name])), "/[^a-z0-9-]/", ""),
      0, 63
    ))

    # SQL Database: 1-128 chars, cannot use reserved words or special characters
    sql_database = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.sql_database, local.full_base_name])), "/[^a-zA-Z0-9-_]/", ""),
      0, 128
    ))

    # SQL Elastic Pool: 1-128 chars
    sql_elastic_pool = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.sql_elastic_pool, local.full_base_name])), "/[^a-zA-Z0-9-_]/", ""),
      0, 128
    ))

    # SQL Managed Instance: 1-63 chars, lowercase letters, numbers, and hyphens
    sql_managed_instance = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.sql_managed_instance, local.full_base_name])), "/[^a-z0-9-]/", ""),
      0, 63
    ))

    # MySQL Database: 1-63 chars, alphanumeric and hyphens
    mysql_database = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.mysql_database, local.full_base_name])), "/[^a-zA-Z0-9-]/", ""),
      0, 63
    ))

    # PostgreSQL Database: 1-63 chars, alphanumeric and hyphens
    postgresql_database = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.postgresql_database, local.full_base_name])), "/[^a-zA-Z0-9-]/", ""),
      0, 63
    ))

    # Developer Tools
    # App Configuration: 5-50 chars, alphanumeric, hyphens, and underscores
    app_configuration = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.app_configuration, local.full_base_name])), "/[^a-zA-Z0-9-_]/", ""),
      0, 50
    ))

    # Maps Account: 1-98 chars, alphanumeric, hyphens, periods, and underscores
    maps_account = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.maps_account, local.full_base_name])), "/[^a-zA-Z0-9-._]/", ""),
      0, 98
    ))

    # SignalR: 3-63 chars, alphanumeric and hyphens
    signalr = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.signalr, local.full_base_name])), "/[^a-zA-Z0-9-]/", ""),
      0, 63
    ))

    # Integration
    # API Management: 1-50 chars, alphanumeric and hyphens
    api_management = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.api_management, local.full_base_name])), "/[^a-zA-Z0-9-]/", ""),
      0, 50
    ))

    # Service Bus Namespace: 6-50 chars, alphanumeric and hyphens
    service_bus_namespace = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.service_bus_namespace, local.full_base_name])), "/[^a-zA-Z0-9-]/", ""),
      0, 50
    ))

    # Service Bus Queue: 1-260 chars, alphanumeric, periods, hyphens, underscores, and forward slashes
    service_bus_queue = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.service_bus_queue, local.full_base_name])), "/[^a-zA-Z0-9._\\/-]/", ""),
      0, 260
    ))

    # Service Bus Topic: 1-260 chars, alphanumeric, periods, hyphens, underscores, and forward slashes
    service_bus_topic = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.service_bus_topic, local.full_base_name])), "/[^a-zA-Z0-9._\\/-]/", ""),
      0, 260
    ))

    # Logic App: 1-80 chars, alphanumeric, hyphens, underscores, periods, and parentheses
    logic_app = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.logic_app, local.full_base_name])), "/[^a-zA-Z0-9-_.()]/", ""),
      0, 80
    ))

    # Management and Governance
    # Automation Account: 6-50 chars, alphanumeric and hyphens
    automation_account = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.automation_account, local.full_base_name])), "/[^a-zA-Z0-9-]/", ""),
      0, 50
    ))

    # Application Insights: 1-260 chars, alphanumeric, hyphens, periods, underscores, and parentheses
    application_insights = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.application_insights, local.full_base_name])), "/[^a-zA-Z0-9-_.()]/", ""),
      0, 260
    ))

    # Log Analytics Workspace: 4-63 chars, alphanumeric and hyphens
    log_analytics_workspace = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.log_analytics_workspace, local.full_base_name])), "/[^a-zA-Z0-9-]/", ""),
      0, 63
    ))

    # Resource Group: 1-90 chars, alphanumeric, hyphens, underscores, periods, and parentheses
    resource_group = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.resource_group, local.full_base_name])), "/[^a-zA-Z0-9-_.()]/", ""),
      0, 90
    ))

    # Management Group: 1-90 chars, alphanumeric, hyphens, underscores, periods, and parentheses
    management_group = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.management_group, local.full_base_name])), "/[^a-zA-Z0-9-_.()]/", ""),
      0, 90
    ))

    # Networking
    # Virtual Network: 2-64 chars, alphanumeric, hyphens, underscores, and periods
    virtual_network = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.virtual_network, local.full_base_name])), "/[^a-zA-Z0-9-_.]/", ""),
      0, 64
    ))

    # Subnet: 1-80 chars, alphanumeric, hyphens, underscores, and periods
    subnet = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.subnet, local.full_base_name])), "/[^a-zA-Z0-9-_.]/", ""),
      0, 80
    ))

    # Network Security Group: 1-80 chars, alphanumeric, hyphens, underscores, and periods
    network_security_group = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.network_security_group, local.full_base_name])), "/[^a-zA-Z0-9-_.]/", ""),
      0, 80
    ))

    # Network Interface: 1-80 chars, alphanumeric, hyphens, underscores, and periods
    network_interface = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.network_interface, local.full_base_name])), "/[^a-zA-Z0-9-_.]/", ""),
      0, 80
    ))

    # Public IP: 1-80 chars, alphanumeric, hyphens, underscores, and periods
    public_ip = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.public_ip, local.full_base_name])), "/[^a-zA-Z0-9-_.]/", ""),
      0, 80
    ))

    # Load Balancer: 1-80 chars, alphanumeric, hyphens, underscores, and periods
    load_balancer_internal = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.load_balancer_internal, local.full_base_name])), "/[^a-zA-Z0-9-_.]/", ""),
      0, 80
    ))

    load_balancer_external = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.load_balancer_external, local.full_base_name])), "/[^a-zA-Z0-9-_.]/", ""),
      0, 80
    ))

    # Application Gateway: 1-80 chars, alphanumeric, hyphens, and underscores
    application_gateway = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.application_gateway, local.full_base_name])), "/[^a-zA-Z0-9-_]/", ""),
      0, 80
    ))

    # Firewall: 1-80 chars, alphanumeric, hyphens, and underscores
    firewall = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.firewall, local.full_base_name])), "/[^a-zA-Z0-9-_]/", ""),
      0, 80
    ))

    # VPN Gateway: 1-80 chars, alphanumeric, hyphens, and underscores
    vpn_gateway = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.vpn_gateway, local.full_base_name])), "/[^a-zA-Z0-9-_]/", ""),
      0, 80
    ))

    # Virtual Network Gateway: 1-80 chars, alphanumeric, hyphens, and underscores
    virtual_network_gateway = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.virtual_network_gateway, local.full_base_name])), "/[^a-zA-Z0-9-_]/", ""),
      0, 80
    ))

    # Route Table: 1-80 chars, alphanumeric, hyphens, underscores, and periods
    route_table = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.route_table, local.full_base_name])), "/[^a-zA-Z0-9-_.]/", ""),
      0, 80
    ))

    # Private Endpoint: 1-80 chars, alphanumeric, hyphens, underscores, and periods
    private_endpoint = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.private_endpoint, local.full_base_name])), "/[^a-zA-Z0-9-_.]/", ""),
      0, 80
    ))

    # NAT Gateway: 1-80 chars, alphanumeric, hyphens, and underscores
    nat_gateway = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.nat_gateway, local.full_base_name])), "/[^a-zA-Z0-9-_]/", ""),
      0, 80
    ))

    # ExpressRoute Circuit: 1-80 chars, alphanumeric, hyphens, and underscores
    expressroute_circuit = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.expressroute_circuit, local.full_base_name])), "/[^a-zA-Z0-9-_]/", ""),
      0, 80
    ))

    # Front Door Profile: 5-64 chars, alphanumeric and hyphens
    front_door_profile = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.front_door_profile, local.full_base_name])), "/[^a-zA-Z0-9-]/", ""),
      0, 64
    ))

    # Security
    # Key Vault: 3-24 chars, alphanumeric and hyphens
    key_vault = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.key_vault, local.full_base_name])), "/[^a-zA-Z0-9-]/", ""),
      0, 24
    ))

    # Key Vault Managed HSM: 3-24 chars, alphanumeric and hyphens
    key_vault_managed_hsm = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.key_vault_managed_hsm, local.full_base_name])), "/[^a-zA-Z0-9-]/", ""),
      0, 24
    ))

    # Managed Identity: 3-128 chars, alphanumeric, hyphens, and underscores
    managed_identity = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.managed_identity, local.full_base_name])), "/[^a-zA-Z0-9-_]/", ""),
      0, 128
    ))

    # Bastion: 1-80 chars, alphanumeric, hyphens, and underscores
    bastion = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.bastion, local.full_base_name])), "/[^a-zA-Z0-9-_]/", ""),
      0, 80
    ))

    # Storage
    # Storage Account: 3-24 chars, lowercase letters and numbers only
    storage_account = lower(substr(
      replace("${var.cloud_acronym}${local.abbreviations.storage_account}${local.sanitized_base_name}", "/[^a-z0-9]/", ""),
      0, 24
    ))

    # File Share: 3-63 chars, lowercase letters, numbers, and hyphens
    file_share = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.file_share, local.full_base_name])), "/[^a-z0-9-]/", ""),
      0, 63
    ))

    # Backup Vault: 2-50 chars, alphanumeric and hyphens
    backup_vault = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.backup_vault, local.full_base_name])), "/[^a-zA-Z0-9-]/", ""),
      0, 50
    ))

    # Recovery Services Vault: 2-50 chars, alphanumeric and hyphens
    recovery_services_vault = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.recovery_services_vault, local.full_base_name])), "/[^a-zA-Z0-9-]/", ""),
      0, 50
    ))

    # Storage Sync Service: 1-260 chars, alphanumeric, hyphens, underscores, and periods
    storage_sync_service = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.storage_sync_service, local.full_base_name])), "/[^a-zA-Z0-9-_.]/", ""),
      0, 260
    ))

    # Virtual Desktop Infrastructure
    # Virtual Desktop Host Pool: 3-64 chars, alphanumeric and hyphens
    virtual_desktop_host_pool = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.virtual_desktop_host_pool, local.full_base_name])), "/[^a-zA-Z0-9-]/", ""),
      0, 64
    ))

    # Virtual Desktop Application Group: 3-64 chars, alphanumeric and hyphens
    virtual_desktop_application_group = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.virtual_desktop_application_group, local.full_base_name])), "/[^a-zA-Z0-9-]/", ""),
      0, 64
    ))

    # Virtual Desktop Workspace: 3-64 chars, alphanumeric and hyphens
    virtual_desktop_workspace = lower(substr(
      replace(join(var.delimiter, compact([var.cloud_acronym, local.abbreviations.virtual_desktop_workspace, local.full_base_name])), "/[^a-zA-Z0-9-]/", ""),
      0, 64
    ))

    location_abbr = lower(var.location)
  }

  # Merge base names with clean names for resources that require special formatting
  # This ensures resources like storage_account, container_registry, etc. use their clean versions
  names = merge(
    local.names_base,
    {
      # Resources that require alphanumeric only (no delimiters)
      storage_account      = local.names_clean.storage_account
      container_registry   = local.names_clean.container_registry
      batch_account        = local.names_clean.batch_account
      analysis_services    = local.names_clean.analysis_services
      cosmos_db            = local.names_clean.cosmos_db
      sql_server           = local.names_clean.sql_server
      sql_managed_instance = local.names_clean.sql_managed_instance

      # Resources with specific character restrictions
      key_vault             = local.names_clean.key_vault
      key_vault_managed_hsm = local.names_clean.key_vault_managed_hsm
    }
  )

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
    format("%s%s%s%s%s",
      local.vm_cloud_acronym_short,
      local.location_abbr,
      lower(var.vm_os_type),
      var.vm_application_name,
      local.vm_environment_short,
    )
  ) : ""
}
