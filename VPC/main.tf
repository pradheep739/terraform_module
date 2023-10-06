# Create a VPC
resource "aws_vpc" "test1" {
  cidr_block = var.vpc_cidr
}

output "testvpc_id"{
  value = aws_vpc.test1.id
}