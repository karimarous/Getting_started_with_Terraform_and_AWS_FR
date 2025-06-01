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