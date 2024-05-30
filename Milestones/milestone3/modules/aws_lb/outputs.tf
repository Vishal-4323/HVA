output "load_balancer_arn" {
  value = aws_lb.my_lb.arn
}

output "lb_name" {
  value = aws_lb.my_lb.name
}