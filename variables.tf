variable "admin_password" {
  type        = string
  sensitive   = true
  description = "Admin password for the VM (do not commit secrets to source control)."
}

variable "subscription_id" {
  type        = string
  sensitive   = true
  description = "Azure subscription ID"
}

variable "client_id" {
  type        = string
  sensitive   = true
  description = "Azure client ID"
}

variable "client_secret" {
  type        = string
  sensitive   = true
  description = "Azure client secret"
}

variable "tenant_id" {
  type        = string
  sensitive   = true
  description = "Azure tenant ID"
}


variable "environment" {
  description = "Deployment environment (dev or prod)"
  type        = string

  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "environment must be either 'dev' or 'prod'."
  }
}
