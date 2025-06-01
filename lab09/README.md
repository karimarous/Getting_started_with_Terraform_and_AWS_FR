# 1. Use ami data source and provision an ec2 instance

1.1 Go to main.tf and add the following code
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

resource "aws_instance" "instance" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = values(aws_subnet.subnet)[0].id
  vpc_security_group_ids = [aws_security_group.sg.id]

  tags = {
    Name = "${var.instance_name}-${local.env}"
  }
}
```

1.2 Go to variables.tf and add the following code
```
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


1.3 Go to dev.tfvars and add the following code
```
ami_owner = "099720109477" # Canonical  
ami_name = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
ami_virtualization_type = "hvm"
instance_type = "t3.micro"
instance_name = "karim-ec2"
```
Replace "karim" with "your_name"

1.4 Run th following command
```
terraform apply -var-file="dev.tfvars"
```
Type "yes"