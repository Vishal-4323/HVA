resource "aws_subnet" "mysubnet" {
  vpc_id = var.vpc_id
  cidr_block = var.cidr_block
  ipv6_cidr_block = var.ipv6_cidr_block
  availability_zone = var.availability_zone
}