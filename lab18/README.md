# 1. Terraform format

1.1 Go to main.tf and replace the bloc data aws_ami with the following code
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
```

1.2 Run the following command
```
terraform fmt
```
# 2. Terraform validate
2.1 Go to main.tf and replace the block resource aws_instance with the following code
```
resource "aws_instance" "ec2" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = values(aws_subnet.subnet)[0].id
  vpc_security_group_ids = [aws_security_group.security_group.id]
  uqtsyg
  tags = {
    Name = "${var.instance_name}-${local.env}"
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