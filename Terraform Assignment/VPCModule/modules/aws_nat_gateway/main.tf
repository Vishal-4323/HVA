resource "aws_nat_gateway" "my_nat" {
  connectivity_type = var.connectivity_type
  subnet_id = var.subnet_id
}