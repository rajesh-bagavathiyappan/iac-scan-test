
variable "application_name" {
  type = string
}
variable "subnet_range" {
  type = string
}
variable "region" {
  type = string
}
variable "machine_type" {
  type = string
}
variable "source_image" {
  type = string
}
variable "vpc_network" {
  type = string
}
variable "subnet_name" {
  type = string
}

variable "autoscaling_policy" {
  type = map(any)
}