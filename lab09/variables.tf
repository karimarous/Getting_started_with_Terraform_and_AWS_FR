variable "vpc_name" {
  type    = string
}

variable "vpc_cidr" {
  type    = string
}

variable "public_subnets" {
  type = map
}

variable "sg_name" {
  type    = string
}

variable "sg_ingress_rules" {
  type = list(object({
           from_port   = number
           to_port     = number
           protocol    = string
           cidr_blocks = list(string)
         }))
}

variable "sg_egress_rules" {
  type = list(object({
           from_port   = number
           to_port     = number
           protocol    = string
           cidr_blocks = list(string)
         }))
}
variable "ami_owner" {
  type    = string
}

variable "ami_name" {
  type    = string
}

variable "ami_virtualization_type" {
  type    = string
}

variable "instance_type" {
  type    = string
}

variable "instance_name" {
  type    = string
}