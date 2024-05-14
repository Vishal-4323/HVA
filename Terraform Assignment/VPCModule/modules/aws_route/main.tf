resource "aws_route" "my_r" {
  route_table_id = var.route_table_id
  destination_cidr_block = var.destination_cidr_block
  gateway_id = var.gateway_id
  nat_gateway_id = var.nat_gateway_id
 // destination_ipv6_cidr_block = var.destination_ipv6_cidr_block
}

resource "aws_route" "my_ipv6_r" {
  route_table_id = var.route_table_id
  destination_ipv6_cidr_block = var.destination_ipv6_cidr_block
  gateway_id = var.gateway_id
  nat_gateway_id = var.nat_gateway_id
}