variable "storage_account_name" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "storage_account_tier" {
  type = string
}

variable "enable_https_traffic_only" {
  type = bool
}

variable "storage_account_replication_type" {
  type = string
}

variable "tags" {
  type = map(any)
}
