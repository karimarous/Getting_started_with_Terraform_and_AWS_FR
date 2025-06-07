# 1. Terraform format

1.1 Open main.tf and replace the resource aws_vpc with the following code
```
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
        enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.vpc_name}-${local.env}"
  }
}
```

1.2 Run the following command
```
terraform fmt
```
# 2. Terraform validate
2.1 Go to main.tf and replace the resource aws_subnet with the following code
```
resource "aws_subnet" "public" {
  for_each                = var.public_subnets
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr
  map_public_ip_on_launch = true
  availability_zone       = each.value.az
  fhjghjk
  tags = {
    Name = "${each.value.name}-${local.env}"
  }
}

```

2.2 Run th following command
```
terraform validate
```

2.3 Go to main.tf and replace the block resource aws_subnet with the following code
```
resource "aws_subnet" "public" {
  for_each                = var.public_subnets
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr
  map_public_ip_on_launch = true
  availability_zone       = each.value.az
  tags = {
    Name = "${each.value.name}-${local.env}"
  }
}
```

2.4 Run the following command
```
terraform validate
```