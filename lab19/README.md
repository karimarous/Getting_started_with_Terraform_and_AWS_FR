# 1. Create a module for AWS instance and AWS Security Group

1.1 Create a folder named modules

1.2 Under the modules folder create another folder named ec2

1.3 Create a file named main.tf under ec2 folder and copy the following code
```
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

resource "aws_security_group" "ssh" {
  name_prefix = "allow_inboud_outboud"
  description = var.sg_description

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
    Name = "${var.sg_name}-${var.env}"
  }
}

resource "aws_instance" "instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  tags = {
    Name = "var.instance_name-${var.env}"
  }
}
```

1.4 Create a file named variables.tf under ec2 folder and copy the following code
```
variable "sg_name" {
  type    = string
}

variable "sg_description" {
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

variable "env" {
  type    = string
}
```

1.5 Create a file named outputs.tf under ec2 folder and copy the following code
```
output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.instance.id
}
```
1.6 In the root project, go to main.tf and override it with the following code
```
module "ec2" {
  source = "./modules/ec2"
  env = local.env
  sg_name = var.sg_name
  sg_description = var.sg_description
  sg_ingress_rules = var.sg_ingress_rules
  sg_egress_rules = var.sg_egress_rules
  ami_owner = var.ami_owner
  ami_name = var.ami_name
  ami_virtualization_type = var.ami_virtualization_type
  instance_type = var.instance_type
  instance_name = var.instance_name
}
```

1.7 In the root project override variables.tf with the following code
```
variable "sg_name" {
  type    = string
}

variable "sg_description" {
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
```

1.8 In the root project rename the file "dev.tfvars" to "terraform.tfvars" and override it with the following code
```
sg_name = "karim-sg"
sg_description = "Security group with dynamic rules"
sg_ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
sg_egress_rules= [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
]
ami_owner = "099720109477" # Canonical  
ami_name = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
ami_virtualization_type = "hvm"
instance_type = "t3.micro"
instance_name = "karim-ec2"
```

1.9 Run the following commands
```
terraform init 
terraform apply 
```
Type "yes"

1.10 Run the following commands
```
terraform destroy
```
Type "yes"