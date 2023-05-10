variable "creds_file" {
  default = "cloudmatos-demoblog-904b756a20fd.json"
}
variable "project" {
  default = "cloudmatos-demoblog"
}
variable "region" {
  default = "us-west3"
}
variable "zone" {
  default = "us-west3-a"
}

// VPC, subnet and firewall
variable "vpc" {}
variable "subnet" {}
variable "firewall" {}
