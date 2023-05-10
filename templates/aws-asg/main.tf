module "webservers" {
  source                  = "./modules/webservers"
  cluster_name            = var.cluster_name
  image_id                = var.image_id
  instance_type           = var.instance_type
  min_size                = var.min_size
  max_size                = var.max_size
  desired_capacity        = var.desired_capacity
  enable_new_ami_creation = var.enable_new_ami_creation
  instance_id             = var.instance_id
}

###########################
## Elastic Load Balancer ##
###########################
# to make sure default subnet exists
resource "aws_default_subnet" "default_az1" {
  for_each = setunion(var.availability_zone)
  availability_zone = each.value

  tags = {
    Name = "Default subnet for current region"
  }
}