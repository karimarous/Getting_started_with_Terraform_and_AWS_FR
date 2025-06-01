variable "security_group_name" {
  type = string
  default = "karim-security-group"
}

variable "security_group_description" {
  type = string
  default = "karim security group"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "ami" {
  type = string
  default = "ami-0ff71843f814379b3"
}

variable "instance_name" {
  type = string
  default = "karim-instance"
}

variable "env" {
  type = string
}