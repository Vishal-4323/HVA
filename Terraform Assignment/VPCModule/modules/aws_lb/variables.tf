variable "load_balancer_type" {
  default = "application"
}

variable "internal" {
  default = false
}

variable "subnets" {
  default = ["us-east-2a", "us-east-2b"]
}