resource "aws_lb" "myalb" {
    name = "my-alb"
    internal = var.internal
    load_balancer_type = var.load_balancer_type
    subnets = var.subnets
}