output "vpc_id" {
  value = aws_vpc.myvpc.id
}

output "vpc_ipv6_cidr_block" {
  value = aws_vpc.myvpc.ipv6_cidr_block
}