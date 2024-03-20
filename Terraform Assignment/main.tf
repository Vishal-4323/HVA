provider "aws" {
  region = "us-east-1"
}

module "aws_vpc" {
  source = "./modules/aws_vpc"
  cidr_block_value = "10.0.0.0/16"
}