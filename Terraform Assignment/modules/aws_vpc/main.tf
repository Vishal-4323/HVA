provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "test" {
  cidr_block = var.cidr_block_value
}