provider "aws" {
  region = var.region_name
}

module "aws_vpc" {
  source = "./modules/aws_vpc"
  cidr_block = var.cidr_block
  assign_generated_ipv6_cidr_block = var.assign_generated_ipv6_cidr_block
}

module "aws_subnet" {
  source = "./modules/aws_subnet"
  vpc_id = module.aws_vpc.vpc_id
  cidr_block = var.cidr_block
  ipv6_cidr_block = module.aws_vpc.vpc_ipv6_cidr_block
}

module "aws_internet_gateway" {
  source = "./modules/aws_internet_gateway"
  vpc_id = module.aws_vpc.vpc_id
}

/*module "aws_internet_gateway_attachment" {
  source = "./modules/aws_internet_gateway_attachment"
  vpc_id = module.aws_vpc.vpc_id
  internet_gateway_id = module.aws_internet_gateway.internet_gateway_id
}*/

module "aws_route_table" {
  source = "./modules/aws_route_table"
  vpc_id = module.aws_vpc.vpc_id
  route = []
}

module "aws_route" {
  source = "./modules/aws_route"
  route_table_id = module.aws_route_table.route_table_id
  destination_cidr_block = "0.0.0.0/16"
  gateway_id = module.aws_internet_gateway.internet_gateway_id
}

module "aws_main_route_table_association" {
  source = "./modules/aws_main_route_table_association"
  route_table_id = module.aws_route_table.route_table_id
  vpc_id = module.aws_vpc.vpc_id
}