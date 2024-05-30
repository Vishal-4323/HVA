resource "aws_autoscaling_attachment" "name" {
  autoscaling_group_name = var.autoscaling_group_name
  elb = var.elb
}