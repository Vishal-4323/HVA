output "vpc_id" {
  value = module.aws_vpc.vpc_id
}

output "vpc_ipv6_cidr_block" {
  value = module.aws_vpc.vpc_ipv6_cidr_block
}

output "internet_gateway_id" {
  value = module.aws_internet_gateway.internet_gateway_id
}

output "route_table_id" {
  value = module.aws_route_table.route_table_id
}