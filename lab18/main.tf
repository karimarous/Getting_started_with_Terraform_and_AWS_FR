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

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = [var.ami_owner] 

  filter {
    name   = "name"
    values = [var.ami_name]
  }
  filter {
    name   = "virtualization-type"
    values = [var.ami_virtualization_type]
  }
}

resource "aws_instance" "ec2" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = values(aws_subnet.subnet)[0].id
  vpc_security_group_ids = [aws_security_group.security_group.id]
  tags = {
    Name = "${var.instance_name}-${local.env}"
  }
}