variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "sql_server_name" {
  type = string
}

variable "sql_server_version" {
  type = string
}

variable "tags" {
  type = map(any)
}

variable "keyvaut_id" {
  type = string
}

variable "storage_primary_blob_endpoint" {
  type = string
}

variable "storage_primary_access_key" {
  type = string
}

variable "sql_retention_in_days" {
  type = string
}