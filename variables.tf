variable "cloud_acronym" {
  description = "Cloud acronym: 'azc' for Azure Commercial or 'azg' for Azure Government"
  type        = string
  default     = "azc"
  validation {
    condition     = contains(["azc", "azg"], var.cloud_acronym)
    error_message = "Cloud acronym must be either 'azc' (Azure Commercial) or 'azg' (Azure Government)."
  }
}

variable "prefix" {
  description = "Prefix to be used for resource names (e.g., company name or project identifier)"
  type        = string
  default     = ""
  validation {
    condition     = can(regex("^[a-z0-9]*$", var.prefix))
    error_message = "Prefix must contain only lowercase letters and numbers."
  }
}

variable "environment" {
  description = "Environment name (e.g., dev, test, staging, prod)"
  type        = string
  default     = ""
  validation {
    condition     = can(regex("^[a-z0-9]*$", var.environment))
    error_message = "Environment must contain only lowercase letters and numbers."
  }
}

variable "location" {
  description = "Azure region location code (e.g., eastus, westus2, westeurope)"
  type        = string
  default     = ""
  validation {
    condition     = can(regex("^[a-z0-9]*$", var.location))
    error_message = "Location must contain only lowercase letters and numbers."
  }
}

variable "workload" {
  description = "Workload or application name"
  type        = string
  default     = ""
  validation {
    condition     = can(regex("^[a-z0-9]*$", var.workload))
    error_message = "Workload must contain only lowercase letters and numbers."
  }
}

variable "delimiter" {
  description = "Delimiter to use between name components"
  type        = string
  default     = "-"
}

variable "use_azure_region_abbr" {
  description = "Use abbreviated region names (e.g., eus for eastus, wus2 for westus2)"
  type        = bool
  default     = false
}
