variable "server_port" {
  description = "The port the web server will be listening"
  type        = number
  default     = 8080
}

variable "elb_port" {
  description = "The port the elb will be listening"
  type        = number
  default     = 80
}

variable "cluster_name" {
  description = "The name to use for all the cluster resources"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 Instances to run (e.g. t2.micro)"
  type        = string
}

variable "min_size" {
  description = "The minimum number of EC2 Instances in the ASG"
  type        = number
}

variable "max_size" {
  description = "The maximum number of EC2 Instances in the ASG"
  type        = number
}

variable "desired_capacity" {
  description = "The desired number of EC2 Instances in the ASG"
  type        = number
}

variable "image_id" {
  description = "The ami ID of the image (e.g. ami-07ebfd5b3428b)"
  type        = string
}

variable "enable_new_ami_creation" {
  description = "new ami is needed or not"
  type        = bool
  default     = false
}

variable "instance_id" {
  description = "instance ID for the instance to create AMI from"
  type        = string
}

variable "availability_zone" {
  description = "instance ID for the instance to create AMI from"
  type        = list
}
