variable "policylist" {
  type = list(any)
}

variable "policyscope" {
  type = string
}

variable "SQL_resourceName" {
  type = string
  default = null
}


variable "SQL_resourceId" {
  type = string
  default = null
}


variable "location" {
  type = string
}


variable "azure_monitor_action_group_name" {
  type = string
  default = null
}


variable "azure_monitor_action_group_rg_name" {
  type = string
  default = null
}

variable "logAnalyticsWorkspaceId" {
  type = string
  default = null
}