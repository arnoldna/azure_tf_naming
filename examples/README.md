# Examples

This directory contains examples demonstrating how to use the Azure Terraform Naming Module.

## Basic Example

The [basic](basic/) example shows the simplest usage with common Azure resources:

```bash
cd examples/basic
terraform init
terraform plan
```

This example demonstrates:

- Basic module configuration with all standard parameters
- Generated names for 12 common Azure resources
- Output showing all available resource type names

## Advanced Example

The [advanced](advanced/) example demonstrates more complex scenarios:

```bash
cd examples/advanced
terraform init
terraform plan
```

This example demonstrates:

- Multiple environments (dev, staging, prod)
- Multiple instances of resources
- Region abbreviations usage
- Disaster recovery setup across regions
- Custom suffixes for blue/green deployments

## Azure Government Example

The [azure_government](azure_government/) example demonstrates usage with Azure Government regions:

```bash
cd examples/azure_government
terraform init
terraform plan
```

This example demonstrates:

- Azure Government region naming (US Gov Virginia, Texas, Arizona)
- DoD region naming (DoD East, DoD Central)
- Government cloud region abbreviations
- Multi-region setup for government workloads
- Classified and unclassified environment separation

## Character Limits Example

The [character_limits](character_limits/) example demonstrates handling of Azure resource character limitations:

```bash
cd examples/character_limits
terraform init
terraform plan
```

This example demonstrates:

- Clean names for Storage Accounts (24 char limit, no hyphens)
- Clean names for Container Registry (50 char limit, no hyphens)
- Clean names for Key Vault (24 char limit)
- Comparison of standard vs clean names
- Length optimization strategies

## Running the Examples

1. Navigate to the example directory:

   ```bash
   cd examples/basic  # or examples/advanced
   ```

2. Initialize Terraform:

   ```bash
   terraform init
   ```

3. View the generated names:

   ```bash
   terraform plan
   ```

4. (Optional) Apply to save outputs:

   ```bash
   terraform apply
   ```

## Example Output

When you run `terraform plan` in the basic example, you'll see output like:

```txt
example_names = {
  application_insights    = "azc-appi-contoso-webapp-dev-eastus"
  app_service_plan        = "azc-asp-contoso-webapp-dev-eastus"
  key_vault               = "azc-kv-contoso-webap-"
  log_analytics_workspace = "azc-log-contoso-webapp-dev-eastus"
  network_security_group  = "azc-nsg-contoso-webapp-dev-eastus"
  resource_group          = "azc-rg-contoso-webapp-dev-eastus"
  sql_database            = "azc-sqldb-contoso-webapp-dev-eastus"
  sql_server              = "azc-sql-contoso-webapp-dev-eastus"
  storage_account         = "azcstcontosowebappdevea"
  subnet                  = "azc-snet-contoso-webapp-dev-eastus"
  virtual_network         = "azc-vnet-contoso-webapp-dev-eastus"
  web_app                 = "azc-app-contoso-webapp-dev-eastus"
}

base_name = "contoso-webapp-dev-eastus"
```

## Notes

- These examples don't actually create any Azure resources
- They only demonstrate the naming module's output
- The module has zero dependencies on Azure providers
- You can use these naming patterns in your actual infrastructure code
