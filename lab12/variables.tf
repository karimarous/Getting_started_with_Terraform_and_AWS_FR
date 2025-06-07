variable "security_group_name" {
  type = string
}

variable "security_group_description" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "ami" {
  type = string
}

variable "instance_name" {
  type = string
  validation {
    condition = length(var.instance_name) > 5
    error_message = "The instance name must more than 5 letters."
  }
}

variable "env" {
  type = string
}