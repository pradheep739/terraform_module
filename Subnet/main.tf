# two subnet diff avl zone
resource "aws_subnet" "subnet1" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_block
  availability_zone       = var.avl_zone
  map_public_ip_on_launch = true
}

output "subnet1" {
  value = aws_subnet.subnet1.id
}

resource "aws_subnet" "subnet2" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_block
  availability_zone       = var.avl_zone
  map_public_ip_on_launch = true
}

output "subnet2" {
  value = aws_subnet.subnet2.id
}

output "subnet_ids" {
  value = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
}

resource "aws_route_table" "rt" {
  vpc_id = var.vpc_id
}

resource "aws_route" "custom_route" {
  route_table_id            = aws_route_table.rt.id
  destination_cidr_block    = "0.0.0.0/0"  
  gateway_id                = aws_internet_gateway.igw.id
}

resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id
}