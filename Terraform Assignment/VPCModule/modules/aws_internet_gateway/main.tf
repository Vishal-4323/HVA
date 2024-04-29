resource "aws_internet_gateway" "my_gw" {
  vpc_id = var.vpc_id
}