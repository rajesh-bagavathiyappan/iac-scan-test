variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet_offset" {
  type    = number
  default = 0
}

variable "vnet_addressspace" {
  type = list(any)
}

variable "vnet_name" {
  type = string
}

variable "tags" {
  type = map(any)
}