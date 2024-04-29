variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "region_name" {
  default = "us-east-2"
}

variable "ip_addr" {
  default = "ipv4"
  description = "choose ipv4 or ipv6"
}