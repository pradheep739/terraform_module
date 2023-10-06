resource "aws_iam_role" "ec2iam_role" {
  name = "ec2iam_role"

   assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          AWS = "*"
        },
        Condition = {
          StringEquals = {
            "aws:Requester" = "${var.aws_account_id}"
          }
        }
      }
    ]
  })
}

# ASG creation
resource "aws_autoscaling_group" "asg" {
  name                      = "asg"
  vpc_zone_identifier       = var.zoneidentifier
  launch_configuration      = aws_launch_configuration.enctest_lc.name
  min_size                  = 2
  max_size                  = 4
  desired_capacity          = 2
  default_cooldown          = var.default_cooldown
  health_check_type         = "EC2"
  health_check_grace_period = var.health_check_grace_period
  termination_policies      = ["OldestLaunchConfiguration", "Default"]

  tag {
    key                 = "Name"
    value               = "ASG1"
    propagate_at_launch = true
  }
}

# Launch configuration
resource "aws_launch_configuration" "enctest_lc" {
  name_prefix              = "enctest_lc"
  image_id                 = var.ami_id
  instance_type            = "t2.micro"
  key_name                 = var.key_name
  security_groups          = [aws_security_group.encsg.id]
  iam_instance_profile     = aws_iam_instance_profile.role.name
  associate_public_ip_address = true

  lifecycle {
    create_before_destroy = true
  }
}

# attach iam role to ec2
resource "aws_iam_instance_profile" "role" {
  name = "instance-profile"
  role = aws_iam_role.ec2iam_role.name
}

# ALB
resource "aws_lb" "alb" {
  name                             = "alb"
  internal                         = false
  load_balancer_type               = "application"
  subnets                          = var.zoneidentifier
  enable_deletion_protection       = false
  enable_http2                     = true
  enable_cross_zone_load_balancing = "true"
}

# ALB listener
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.alb_listener_port
  protocol          = var.alb_listener_protocol

  default_action {
    type             = "fixed-response"
    fixed_response {
      content_type    = "text/plain"
      status_code     = "200"
    }
  }
}

# SG
resource "aws_security_group" "encsg" {
  name        = "encsg"
  description = "Example security group for EC2 instances"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}