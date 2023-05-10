variable "creds_file" {
  default = "cloudmatos-demoblog-904b756a20fd.json"
}
variable "project" {
  default = "cloudmatos-demoblog"
}
variable "region" {
  default = "us-west1"
}
variable "zone" {
  default = "us-west1-b"
}

// VPC, subnet and firewall
variable "vpc" {}
variable "subnet" {}
variable "firewall" {}

// Wordpress specific details
variable "wpdbvm" {}
variable "wpdb" {}
variable "wpdb_user" {}
variable "wpdb_userpass" {}

// Cluster details
variable "gke" {}
variable "gkenodepool" {}

// Deployment Details
variable "wpdep" {}
variable "wppod" {}
