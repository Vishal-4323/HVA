resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr_block
  assign_generated_ipv6_cidr_block = true
  tags = {
    name = "main"
  }
}