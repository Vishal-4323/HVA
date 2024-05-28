resource "aws_launch_template" "mytemplate" {
  instance_type = var.instance_type
  vpc_security_group_ids = var.vpc_security_group_ids
  key_name =  var.key_name
  image_id = var.image_id
  monitoring {
    enabled = var.enabled
  }
}