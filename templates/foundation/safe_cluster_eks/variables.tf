#########
# Project Metadata
#########
variable "aws_access_key" {
  type    = string
  default = "AKIASDPJUEZWODVCWJPY"
}
variable "aws_secret_key" {
  type    = string
  default = "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"
}
variable "region" {
  type    = string
  default = "us-east-2"
}
variable "aws_account" {
  type    = number
  default = "144908232300"
}
variable "k8s_prefix" {
  type    = string
  default = "sceks"
}

locals {
  zone         = ["${var.region}a", "${var.region}b", "${var.region}c"]
  network_name = "${var.k8s_prefix}-vpc"
  cluster_name = "${var.k8s_prefix}-k8s"
  map_users = [
    {
      userarn  = "arn:aws:iam::${var.aws_account}:user/testcmops"
      username = "testcmops"
      groups   = ["system:masters"]
    }
  ]
}
