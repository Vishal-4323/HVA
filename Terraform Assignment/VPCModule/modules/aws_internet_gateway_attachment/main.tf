resource "aws_internet_gateway_attachment" "my_igw_attach" {
  vpc_id = var.vpc_id
  internet_gateway_id = var.internet_gateway_id
}