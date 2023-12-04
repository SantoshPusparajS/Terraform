variable "resource_location" {
  type        = string
  description = "Location where the resources will be created"
  validation {
    condition     = var.resource_location == "eastus" || var.resource_location == "westus"
    error_message = "We allow resources to create only in eastus and westus regions only."
  }
  default = "eastus"
}

variable "db_username" {
  description = "Azure MySql database administrator username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Azure MySql database administrator password"
  type        = string
  sensitive   = true
}

variable "auto_grow_enabled_value" {
  description = "auto_grow_enabled_value"
  type        = bool
  default     = true
}

#Object type: contains types in key value pair format
variable "threat_detection_policy" {
  description = "Azure MYSQL DB threat detection policy"
  type = object({
    enabled              = bool,
    retention_days       = number,
    email_account_admins = bool,
  email_addresses = list(string) })
}
