resource "aws_ami_from_instance" "myami" {
  name = var.name
  source_instance_id = var.source_instance_id
}