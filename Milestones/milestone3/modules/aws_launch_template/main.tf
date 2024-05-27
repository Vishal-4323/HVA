resource "aws_launch_template" "mytemplate" {
  image_id = var.image_id
  monitoring {
    enabled = var.enabled
  }
}