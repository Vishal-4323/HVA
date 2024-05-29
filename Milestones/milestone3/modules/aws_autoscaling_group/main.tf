resource "aws_autoscaling_group" "asg" {
  vpc_zone_identifier = var.vpc_zone_identifier
  max_size = var.max_size
  min_size = var.min_size
  desired_capacity = var.desired_capacity
  target_group_arns = var.target_group_arns
  launch_template {
    id = var.id
  }
}