provider "aws" {
  region = "ap-south-1"
}

module "aws_ami_from_instance" {
  source = "./modules/aws_ami_from_instance"
  name = var.name
  source_instance_id = var.source_instance_id
}