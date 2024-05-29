provider "aws" {
  region = "ap-south-1"
}

module "aws_ami_from_instance" {
  source = "./modules/aws_ami_from_instance"
  name = var.name
  source_instance_id = var.source_instance_id
}

module "aws_launch_template" {
  source = "./modules/aws_launch_template"
  image_id = module.aws_ami_from_instance.image_id
  key_name = "bora"
  vpc_security_group_ids = ["sg-094f163bdf56467fd"]
  instance_type = "t2.micro"
}

module "aws_lb_target_group" {
  source = "./modules/aws_lb_target_group"
  name = "lb-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = "vpc-0e79b79a54cff993e"
}

module "aws_autoscaling_group" {
  source = "./modules/aws_autoscaling_group"
  id = module.aws_launch_template.lt_id
  target_group_arns = [module.aws_lb_target_group.target_group_arn]
  vpc_zone_identifier = var.vpc_zone_identifier
  max_size = 5
  min_size = 1
  desired_capacity = 1
}