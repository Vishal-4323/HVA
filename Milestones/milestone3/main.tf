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
}