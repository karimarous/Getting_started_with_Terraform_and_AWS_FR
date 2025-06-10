resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.vpc_name}-${local.env}"
  }
}

resource "aws_subnet" "subnet" {
  for_each   = var.public_subnets
  vpc_id     = aws_vpc.vpc.id
  cidr_block = each.value.cidr
  map_public_ip_on_launch = true
  availability_zone = each.value.az
  tags = {
    Name = "${each.value.name}-${local.env}"
  }
}

resource "aws_security_group" "security_group" {
  name        = "${var.sg_name}-${local.env}"
  description = "Security group with dynamic rules"
  vpc_id      = aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = var.sg_ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
  dynamic "egress" {
    for_each = var.sg_egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
  tags = {
    Name = "${var.sg_name}-${local.env}"
  }
}