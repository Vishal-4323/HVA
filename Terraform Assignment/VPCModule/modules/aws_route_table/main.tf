resource "aws_route_table" "my_rt" {
  vpc_id = var.vpc_id
  route = var.route
}