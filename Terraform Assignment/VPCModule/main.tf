provider "aws" {
  region = var.region_name
}

module "aws_vpc" {
  source = "./modules/aws_vpc"
  cidr_block = var.cidr_block
  assign_generated_ipv6_cidr_block = var.ip_addr=="ipv6" ? true : false
}

module "aws_subnet" {
  source = "./modules/aws_subnet"
  vpc_id = module.aws_vpc.vpc_id
  count = 2
  cidr_block = cidrsubnet(var.cidr_block, 4, count.index)
  ipv6_cidr_block = var.ip_addr=="ipv6" ?cidrsubnet(module.aws_vpc.vpc_ipv6_cidr_block, 4, count.index) : null
  availability_zone = "${var.region_name}${count.index%2==0 ? "a" : "b"}"
  //ipv6_cidr_block = var.ip_addr=="ipv6" ? module.aws_vpc.vpc_ipv6_cidr_block : false 
}

module "aws_nat_gateway" {
  count = var.ip_public_or_private ? 0 : 1
  source = "./modules/aws_nat_gateway"
  subnet_id = tolist(module.aws_subnet)[0].id
  //subnet_id = module.aws_subnet[0].subnet_id
}

module "aws_internet_gateway" {
  source = "./modules/aws_internet_gateway"
  vpc_id = module.aws_vpc.vpc_id
}


module "aws_route_table" {
  source = "./modules/aws_route_table"
  vpc_id = module.aws_vpc.vpc_id
  route = []
}

module "aws_route" {
  source = "./modules/aws_route"
  route_table_id = module.aws_route_table.route_table_id
  destination_cidr_block = var.ip_addr=="ipv4" ? "0.0.0.0/16" : null
  destination_ipv6_cidr_block = var.ip_addr=="ipv6" ? "::/56" : null
  nat_gateway_id = var.ip_public_or_private ? null : module.aws_nat_gateway[0].nat_gateway_id
  gateway_id = var.ip_public_or_private ? module.aws_internet_gateway.internet_gateway_id : null
}

module "aws_main_route_table_association" {
  source = "./modules/aws_main_route_table_association"
  route_table_id = module.aws_route_table.route_table_id
  vpc_id = module.aws_vpc.vpc_id
}

module "aws_launch_template" {
  source = "./modules/aws_launch_template"
  instance_type = "t2.micro"
}

module "aws_autoscaling_group" {
  source = "./modules/aws_autoscaling_group"
  min_size = 1
  max_size = 4
  desired_capacity = 1
  id = module.aws_launch_template.lt_id
}

module "aws_lb" {
  source = "./modules/aws_lb"
  internal = false
  load_balancer_type = "application"
  subnets = [for subnet in module.aws_subnet : subnet.id]
}

/*module "aws_internet_gateway_attachment" {
  source = "./modules/aws_internet_gateway_attachment"
  vpc_id = module.aws_vpc.vpc_id
  internet_gateway_id = module.aws_internet_gateway.internet_gateway_id
}*/