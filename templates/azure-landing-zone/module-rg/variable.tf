variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "rg_offset" {
  type    = number
  default = 0
}

variable "tags" {
  type = map(any)
}