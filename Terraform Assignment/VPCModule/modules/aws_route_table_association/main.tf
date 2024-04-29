resource "aws_route_table_association" "rt_assoc" {
  gateway_id = var.gateway_id
  route_table_id = var.route_table_id
}