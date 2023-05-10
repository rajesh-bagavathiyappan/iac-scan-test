variable "aws_service_access_principals" {
  type        = list(string)
  description = "Services which are to be implemented for SCP."
}

variable "enabled_policy_types" {
  type        = list(string)
  description = "The policies which are enabled for organization. For eg : SERVICE_CONTROL_POLICY or Tag Policies"
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
  description = "Core foundational OUs for organization. If create is true then allow creation of ou"
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
  description = "Workloads or non foundational OUs for organization. If create is true then allow creation of ou"
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

variable "management_email" {
  type        = string
  description = "Email used for management account"
}

variable "create_environment_ous" {
  type        = bool
  description = "TODO: Create Environment OUs for any required core or non core ous. "
}

variable "create_accounts" {
  type        = bool
  description = "Create Account if this is true."
}

variable "admin_user_arn" {
  type        = string
  description = "Administrator user ARN for managing the policies."
}
