variable "vpc_name" {
  description = "Name of the VPC"
  type = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type = string
}

variable "env_subnets_caracteristics" {
  description = "The subnets caracteristics"
  type = map(list(object({
    name = string
    cidr = string
    az = string
  })))
}

variable "env" {
  description = "The environment"
  type = string
}

variable "sg_ingress_rules" {
  description = "The ingress rules for the web security group"
  type = map(object({
    sg_name = string
    rule_type = string
    protocol = string
    port_range = string
    dst_cidr = string
    dst_sg = string
  }))
}

variable "sg_egress_rules" {
  description = "The ingress rules for the app security group"
  type = map(object({
    sg_name = string
    rule_type = string
    protocol = string
    port_range = string
    dst_cidr = string
    dst_sg = string
  }))  
}
