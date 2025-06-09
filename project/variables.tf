variable "region" {
  description = "The AWS region"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type = string
}

variable "cidr_vpc" {
  type = string
}

variable "env_subnets_caracteristics" {
  description = "The subnets caracteristics"
  type = map(map(list(object({
    name = string
    cidr = string
    az = string
  }))))
}

