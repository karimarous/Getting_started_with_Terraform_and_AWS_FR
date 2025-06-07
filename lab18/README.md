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
2.1 Go to main.tf and replace the block resource aws_instance with the following code
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

2.3 Go to main.tf and replace the block resource aws_instance with the following code
```
resource "aws_instance" "ec2" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = values(aws_subnet.subnet)[0].id
  vpc_security_group_ids = [aws_security_group.security_group.id]
  tags = {
    Name = "${var.instance_name}-${local.env}"
  }
}
```

2.4 Run th following command
```
terraform validate
```