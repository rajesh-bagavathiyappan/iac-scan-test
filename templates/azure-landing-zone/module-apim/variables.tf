variable "apim_name" {
  type = string
}

variable "location" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "publisher_name" {
  type = string
}

variable "publisher_email" {
  type = string
}

variable "apim_sku_name" {
  type = string
}

variable "apim_subnet_id" {
  type = string
}

variable "tags" {
  type = map(any)
}