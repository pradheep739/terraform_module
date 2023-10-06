module "vpc" {
  source        = "./VPC"
  vpc_cidr      = "10.0.0.0/16"
  
}

module "subnet1" {
    source      =   "./Subnet"
    cidr_block  = "10.0.1.0/26"
    vpc_id      = module.vpc.testvpc_id
    avl_zone    = "us-east-1a"
}

module "subnet2" {
    source      =   "./Subnet"
    cidr_block  = "10.0.2.0/26"
    vpc_id      = module.vpc.testvpc_id
    avl_zone    = "us-east-1b"
}


resource "aws_key_pair" "pubkey" {
  key_name   = var.ec2_key_name
  public_key = var.aws_secret_pubkey
}

module "ec2-lb" {
    source                      =   "./Ec2"
    aws_account_id              =   "290191426851"
    default_cooldown            =   "300"
    health_check_grace_period   =   "300"
    ami_id                      =   "ami-067d1e60475437da2"
    alb_listener_port           =   "80"
    alb_listener_protocol       =   "HTTP"
    key_name                    =   aws_key_pair.pubkey.key_name
    zoneidentifier              =   module.subnet1.subnet_ids
}