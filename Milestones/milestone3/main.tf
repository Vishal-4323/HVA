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
  depends_on = [ module.aws_ami_from_instance ]
  image_id = module.aws_ami_from_instance.image_id
  key_name = "bora"
  vpc_security_group_ids = ["sg-094f163bdf56467fd"]
  instance_type = "t2.micro"
}

module "aws_lb_target_group" {
  source = "./modules/aws_lb_target_group"
  depends_on = [ module.aws_lb ]
  name = "lb-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = "vpc-0e79b79a54cff993e"
  path = "/"
}

module "aws_lb" {
  source = "./modules/aws_lb"
  depends_on = [ module.aws_launch_template ]
  name = "my-lb-tf"
  internal = false
  load_balancer_type = "application"
  subnets = var.vpc_zone_identifier
  security_groups = ["sg-094f163bdf56467fd"]
}

module "aws_lb_listener" {
  source = "./modules/aws_lb_listener"
  depends_on = [ module.aws_lb, module.aws_lb_target_group ]
  load_balancer_arn = module.aws_lb.load_balancer_arn
  port = 80
  protocol = "HTTP"
  target_group_arn = module.aws_lb_target_group.target_group_arn
  type = "forward"
}

module "aws_autoscaling_group" {
  source = "./modules/aws_autoscaling_group"
  depends_on = [ 
    module.aws_launch_template,
    module.aws_lb_target_group
   ]
  id = module.aws_launch_template.lt_id
  target_group_arns = [module.aws_lb_target_group.target_group_arn]
  vpc_zone_identifier = var.vpc_zone_identifier
  max_size = 5
  min_size = 1
  desired_capacity = 1
}

module "aws_autoscaling_attachment" {
  source = "./modules/aws_autoscaling_attachment"
  depends_on = [ 
    module.aws_autoscaling_group,
    module.aws_lb
   ]
  autoscaling_group_name = module.aws_autoscaling_group.asg-name
  elb = module.aws_lb.lb_name
}