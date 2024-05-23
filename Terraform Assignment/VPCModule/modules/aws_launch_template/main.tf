resource "aws_launch_template" "mytemplate" {
  image_id = var.image_id
  instance_type = var.instance_type
  monitoring {
    enabled = var.enabled
  }
}