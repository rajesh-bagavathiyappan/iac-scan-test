
variable "region" {
  type = string
  #default     = "us-east-1"
  description = "(optional) describe your variable"
}

variable "backend_bucket" {
  type        = string
  description = "(optional) describe your variable"
}

variable "management_email" {
  type        = string
  description = "(optional) describe your variable"
}

variable "aws_service_access_principals" {
  type        = list(string)
  description = "(optional) describe your variable"
}

variable "enabled_policy_types" {
  type        = list(string)
  description = "(optional) describe your variable"
}

variable "core_ous" {
  type = list(object({
    create = bool,
    name   = string
    accounts = list(object({
      create = bool,
      name   = string
    }))
  }))
  description = "Core foundational OUs for organization"
}

variable "custom_ous" {
  type = list(object({
    create = bool,
    name   = string
    accounts = list(object({
      create = bool,
      name   = string
    }))
  }))
  description = "Core foundational OUs for organization"
}

variable "create_environment_ous" {
  type        = bool
  description = "(optional) describe your variable"
}

variable "create_accounts" {
  type        = string
  description = "(optional) describe your variable"
}

variable "environment_ous" {
  type = list(object({
    name = string
    accounts = list(object({
      create = bool,
      name   = string
    }))
  }))
  description = "Environment for Each foundational and Non Core OUs for organization"
}

variable "admin_user" {
  type        = string
  description = "Root account administrator user. This is used for further federated account switching using the account roles."
  default     = "cloudmatos-test"
}
