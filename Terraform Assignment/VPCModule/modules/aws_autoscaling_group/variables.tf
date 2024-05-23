variable "availability_zones" {
  default = ["us-east-2a", "us-east-2b"]
}

variable "min_size" {
  default = 1
}

variable "max_size" {
  default = 4
}

variable "desired_capacity" {
  default = 1
}

variable "id" {
  default = "lt-ami-09040d770ffe2224f"
}