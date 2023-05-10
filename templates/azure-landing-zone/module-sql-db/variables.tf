variable "sql_database_name" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "sql_server_name" {
  type = string
}

variable "edition" {
  type = string
  default = "Standard"
}

variable "requested_service_objective_name" {
  type = string
  default = "S3"
}

variable "tags" {
  type = map(any)
}
