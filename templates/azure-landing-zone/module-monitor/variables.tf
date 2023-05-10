variable "location" {
  type = string
}

variable "rg_name" {
  type = string
}

#variable "network_watcher_name" {
#  type = string
#}
#
#variable "flowlog_nsg_id" {
#  type = string
#}
#
#variable "flowlog_storage_id" {
#  type = string
#}

variable "log_analytics_workspace_name" {
  type = string
}

variable "log_retention_in_days" {
  type = string
}

variable "tags" {
  type = map(any)
}

variable "email_receiver_email1" {
  type    = string
  default = "Avinash.Veesam@xoriant.com"
}

variable "email_receiver_name1" {
  type    = string
  default = "Avinash Veesam"
}

variable "email_receiver_email2" {
  type    = string
  default = "subrata.mukherjee@Xoriant.Com"
}

variable "email_receiver_name2" {
  type    = string
  default = "subrata mukherjee"
}