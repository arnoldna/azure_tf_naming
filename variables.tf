variable "cloud_acronym" {
  description = "Cloud acronym: 'azc' or 'ac' for Azure Commercial or 'azg' or 'ag'for Azure Government"
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
  description = "Environment name both long and short versions(e.g., prod(p), non-prod(np), dev(d), test(t), stage(s))"
  type        = string
  default     = "d"
  validation {
    condition     = contains(["p", "prod", "np", "non-prod", "d", "dev", "t", "test", "s", "stage"], var.environment)
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

variable "vm_os_type" {
  description = "Operating system type for virtual machine: 'l' for Linux or 'w' for Windows"
  type        = string
  default     = ""
  validation {
    condition     = var.vm_os_type == "" || contains(["l", "w"], lower(var.vm_os_type))
    error_message = "VM OS type must be either 'l' (Linux) or 'w' (Windows), or empty string if not used."
  }
}

variable "vm_application_name" {
  description = "Application name for virtual machine (3-6 characters: nds, autop, automg, vem, airway, etc.)"
  type        = string
  default     = ""
  validation {
    condition     = var.vm_application_name == "" || (can(regex("^[a-z0-9]{3,6}$", var.vm_application_name)))
    error_message = "VM application name must be 3-6 lowercase alphanumeric characters."
  }
}

variable "vm_number" {
  description = "Numeric identifier for virtual machine (1-99)"
  type        = number
  default     = 1
  validation {
    condition     = var.vm_number >= 1 && var.vm_number <= 99
    error_message = "VM number must be between 1 and 99."
  }
}
