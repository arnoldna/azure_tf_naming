# Handling Azure Resource Character Limitations

Many Azure resources have strict naming requirements that differ from the standard naming convention.

## Resources with Special Requirements

### Storage Account
- **Length**: 3-24 characters
- **Allowed**: Lowercase letters and numbers only
- **No hyphens allowed**

### Container Registry
- **Length**: 5-50 characters  
- **Allowed**: Alphanumeric characters only
- **No hyphens allowed**

### Key Vault
- **Length**: 3-24 characters
- **Allowed**: Alphanumeric and hyphens
- **Must start with letter**
- **Must end with letter or number**
- **Can't contain consecutive hyphens**

## Solution: Automatic Clean Names

This module automatically handles naming requirements for resources with strict limitations:

**For resources that don't allow hyphens** (Storage Account, Container Registry):
- Remove all hyphens/delimiters
- Lowercase alphanumeric only
- Automatically truncated to maximum allowed length

**For resources that allow hyphens** (Key Vault):
- Keep hyphens for readability
- Automatically truncated to maximum allowed length (24 chars)

## Usage

### Resources That Return Clean Names Automatically

The following outputs automatically return clean names (no `_clean` suffix needed):

```hcl
module "naming" {
  source = "./azure_tf_naming"

  cloud_acronym = "azc"
  prefix        = "contoso"
  workload      = "webapp"
  environment   = "prod"
  location      = "eastus"
}

# Storage Account - automatically returns clean name (max 24 chars)
# Result: azcstcontosowebappprode
resource "azurerm_storage_account" "example" {
  name                     = module.naming.storage_account  # ✅ Clean by default!
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Container Registry - automatically returns clean name (max 50 chars)  
# Result: azccrcontosowebapprodeastus
resource "azurerm_container_registry" "example" {
  name                = module.naming.container_registry  # ✅ Clean by default!
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Premium"
}

# Key Vault - automatically returns name with hyphens (max 24 chars)
# Result: azc-kv-contoso-webapp-p (truncated to 24 chars, keeps hyphens)
resource "azurerm_key_vault" "example" {
  name                = module.naming.key_vault  # ✅ Includes hyphens!
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id
}
```

## Optimizing for Short Names

If your standard naming convention produces names that are too long, use shorter components:

```hcl
module "naming_short" {
  source = "./azure_tf_naming"

  cloud_acronym         = "azc"
  prefix                = "cto"     # Shorter prefix
  workload              = "app"     # Shorter workload name
  environment           = "p"       # Single letter for prod
  location              = "eastus"
  use_azure_region_abbr = true      # Use "eus" instead of "eastus"
}

# Result: azcstctoapppeus (16 chars - plenty of room!)
resource "azurerm_storage_account" "optimized" {
  name                     = module.naming_short.storage_account
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
```

## Available Outputs for Character-Limited Resources

The module provides these outputs for resources with naming restrictions:

| Output | Max Length | Hyphens? | Description |
|--------|-----------|----------|-------------|
| `storage_account` | 24 chars | ❌ No | Storage account name (alphanumeric only) |
| `container_registry` | 50 chars | ❌ No | Container registry name (alphanumeric only) |
| `key_vault` | 24 chars | ✅ Yes | Key vault name (alphanumeric and hyphens) |

Additional clean names available in `names_clean` map:

| Output | Max Length | Description |
|--------|-----------|-------------|
| `app_configuration_clean` | 50 chars | App Configuration name (alphanumeric only) |
| `cosmos_db_clean` | 44 chars | Cosmos DB name (alphanumeric only) |
| `redis_cache_clean` | 63 chars | Redis Cache name (alphanumeric only) |
| `storage_sync_service_clean` | 50 chars | Storage Sync Service name (alphanumeric only) |

## All Clean Names Map

You can also access all clean names via the `names_clean` output:

```hcl
module "naming" {
  source = "./azure_tf_naming"

  cloud_acronym = "azc"
  prefix        = "contoso"
  workload      = "webapp"
  environment   = "prod"
  location      = "eastus"
}

output "all_clean_names" {
  value = module.naming.names_clean
}
```

## Best Practices

1. **Use region abbreviations** when possible (`use_azure_region_abbr = true`)
2. **Keep prefix and workload short** - every character counts
3. **Use abbreviated environments** - `p`, `d`, `s` instead of `prod`, `dev`, `staging`
4. **Test name lengths** - use the character_limits example to verify
5. **Document your abbreviations** - maintain a reference for your team

## Character Limit Reference

| Resource Type | Min | Max | Allowed Characters | Additional Rules |
|--------------|-----|-----|-------------------|-----------------|
| Storage Account | 3 | 24 | Lowercase letters, numbers | No hyphens |
| Container Registry | 5 | 50 | Letters, numbers | No hyphens |
| Key Vault | 3 | 24 | Letters, numbers, hyphens | Start with letter, end with letter/number, no consecutive hyphens |
| Cosmos DB | 3 | 44 | Lowercase letters, numbers, hyphens | - |
| Redis Cache | 1 | 63 | Letters, numbers, hyphens | - |
| App Configuration | 5 | 50 | Letters, numbers, hyphens, underscores | - |

## Example: Complete Setup

```hcl
module "naming" {
  source = "./azure_tf_naming"

  cloud_acronym         = "azc"
  prefix                = "acme"
  workload              = "shop"
  environment           = "prod"
  location              = "eastus"
  use_azure_region_abbr = true
}

resource "azurerm_resource_group" "example" {
  name     = module.naming.resource_group  # azc-rg-acme-shop-prod-eus
  location = "East US"
}

resource "azurerm_storage_account" "example" {
  name                     = module.naming.storage_account  # azcstacmeshopprodeus
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_key_vault" "example" {
  name                = module.naming.key_vault  # azc-kv-acme-shop-prod (truncated to 24 chars)
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "premium"
}

resource "azurerm_container_registry" "example" {
  name                = module.naming.container_registry  # azccracmeshopprodeus
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Premium"
}
```

## Common Pitfalls

### Pitfall 1: Names Too Long

**Problem**: Using all naming components can exceed 24-character limit for Storage Accounts.

**Solution**: Use abbreviated components and enable region abbreviations:

```hcl
module "naming" {
  source = "./azure_tf_naming"

  cloud_acronym         = "azc"
  prefix                = "cto"    # Instead of "contoso"
  workload              = "app"    # Instead of "application"
  environment           = "p"      # Instead of "prod"
  location              = "eastus"
  use_azure_region_abbr = true     # "eus" instead of "eastus"
}
```

### Pitfall 2: Special Characters

**Problem**: Using hyphens or underscores in component values.

**Solution**: The module validates inputs to ensure they're lowercase alphanumeric only. This error will be caught at `terraform plan`:

```hcl
# ❌ This will fail validation
module "naming" {
  source      = "./azure_tf_naming"
  workload    = "my-app"    # Contains hyphen
  environment = "prod_env"  # Contains underscore
}

# ✅ Correct approach
module "naming" {
  source      = "./azure_tf_naming"
  workload    = "myapp"
  environment = "prodenv"
}
```

## Testing Name Lengths

Use the [character_limits example](../examples/character_limits/) to test your naming strategy:

```bash
cd examples/character_limits
terraform init
terraform plan
```

This will show you the actual generated names and their lengths before you deploy any resources.
