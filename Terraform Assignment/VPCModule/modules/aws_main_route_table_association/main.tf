resource "aws_main_route_table_association" "mrt_assoc" {
  vpc_id = var.vpc_id
  route_table_id = var.route_table_id
}