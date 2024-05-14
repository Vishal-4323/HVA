variable "cidr_block" {
  //default = "10.0.0.0/16"
}

variable "region_name" {
  default = "us-east-2"
}

variable "ip_addr" {
  type = string
  //default = "ipv6"
  description = "type ipv4 or ipv6"
}

variable "ip_public_or_private" {
  type = bool
  description = "If you select public ip give true else give false in the value"
}
