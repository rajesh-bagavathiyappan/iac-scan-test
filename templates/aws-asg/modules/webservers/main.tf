data "aws_availability_zones" "all" {}


##########################
## AMI ##
##########################

resource "aws_ami_from_instance" "ami_asg" {
  count              = var.enable_new_ami_creation ? 1 : 0
  name               = "terraform-example"
  source_instance_id = var.instance_id
}


##########################
## Launch Configuration ##
##########################

resource "aws_launch_configuration" "asg-launch-config" {
  image_id        = var.enable_new_ami_creation ? aws_ami_from_instance.ami_asg[0].id : var.image_id
  instance_type   = var.instance_type
  security_groups = [aws_security_group.nodes-sg.id]

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
  }

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, Terraform & AWS ASG" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF
  lifecycle {
    create_before_destroy = true
  }
}


#####################
## Security Groups ##
#####################

resource "aws_security_group" "nodes-sg" {
  name = "${var.cluster_name}-sg"
  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "elb-sg" {
  name = "${var.cluster_name}-elb-sg"
  # Allow all outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Inbound HTTP from anywhere
  ingress {
    from_port   = var.elb_port
    to_port     = var.elb_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


########################
## Auto Scaling Group ##
########################

resource "aws_autoscaling_group" "asg" {
  launch_configuration = aws_launch_configuration.asg-launch-config.id
  availability_zones   = data.aws_availability_zones.all.names
  min_size             = var.min_size
  max_size             = var.max_size
  desired_capacity     = var.desired_capacity

  load_balancers    = [aws_elb.sample.name]
  health_check_type = "ELB"

  tag {
    key                 = "Name"
    value               = "${var.cluster_name}-asg"
    propagate_at_launch = true
  }
}


###########################
## Elastic Load Balancer ##
###########################

resource "aws_elb" "sample" {
  name               = "${var.cluster_name}-asg-elb"
  security_groups    = [aws_security_group.elb-sg.id]
  availability_zones = data.aws_availability_zones.all.names

  health_check {
    target              = "HTTP:${var.server_port}/"
    interval            = 30
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  # Adding a listener for incoming HTTP requests.
  listener {
    lb_port           = var.elb_port
    lb_protocol       = "http"
    instance_port     = var.server_port
    instance_protocol = "http"
  }
}
