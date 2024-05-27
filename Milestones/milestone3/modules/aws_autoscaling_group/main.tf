resource "aws_autoscaling_group" "asg" {
  availability_zones = var.availability_zones
  max_size = var.max_size
  min_size = var.min_size
  desired_capacity = var.desired_capacity
  launch_template {
    id = var.id
  }
}