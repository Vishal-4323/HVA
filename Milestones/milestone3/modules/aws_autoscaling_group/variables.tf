variable "max_size" {
  default = 4
}

variable "min_size" {
  default = 1
}

variable "desired_capacity" {
  default = 1
}

variable "vpc_zone_identifier" {
  default = []
}

variable "id" {
  default = ""
}

variable "target_group_arns" {
  default = []
}