output "image_id" {
  value = module.aws_ami_from_instance.image_id
}

output "lt_id" {
  value = module.aws_launch_template.lt_id
}