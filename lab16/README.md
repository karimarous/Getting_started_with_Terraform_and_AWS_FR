# 1. Provision an AWS VPC and 2 public subnets with for_each

1.1 Replace the code that exist in main.tf with the following code
```
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.vpc_name}-${local.env}"
  }
}

resource "aws_subnet" "public" {
  for_each   = var.public_subnets
  vpc_id     = aws_vpc.vpc.id
  cidr_block = each.value.cidr
  map_public_ip_on_launch = true
  availability_zone = each.value.az
  tags = {
    Name = "${each.value.name}-${local.env}"
  }
}
```

1.2 Replace the code that exist in variables.tf with the following code
```
variable "vpc_name" {
  type = string
  }

variable "vpc_cidr" {
  type = string
}

variable "public_subnets" {
  type = map
}
```

1.3 Replace the code that exist in dev.tfvars with the following code
```
vpc_name = "karim-vpc"
vpc_cidr = "10.0.0.0/16"
public_subnets = {
  subnet-1 = {
    name = "subnet-1"
    cidr = "10.0.0.0/24"
    az   = "eu-west-3a"
  },
  subnet-2 ={
    name = "subnet-2"
    cidr = "10.0.1.0/24"
    az   = "eu-west-3b"
  } 
}
```

1.4 Replace the code that exist in outputs.tf with the following code
```
output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_ids" {
  value = [for subnet in aws_subnet.public : subnet.id]
}
```

1.5 Run the following command
```
terraform apply -var-file="dev.tfvars"
```
1.6 Type "yes"

1.7 Run the following command to destroy the resources
```
terraform destroy -var-file="dev.tfvars"
```
1.8 Type "yes"