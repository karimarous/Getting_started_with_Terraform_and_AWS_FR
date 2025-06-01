# 1. Create all variables

1.1. Create a file named variables.tf

1.2. Copy the following code into variables.tf
```
variable "security_group_name" {
  type = string
  default = "karim-security-group"
}

variable "security_group_description" {
  type = string
  default = "karim security group"
}

variable "instance_type" {
  type = string
  default = "t3.micro"
}

variable "ami" {
  type = string
  default = "ami-0ff71843f814379b3"
}

variable "instance_name" {
  type = string
  default = "karim-instance"
}
```

1.3. Replace "karim" by "your_name" in variables.tf 

# 2. Update your code with the variables

2.1. Copy the following code into main.tf

```
resource "aws_security_group" "security_group" {
  name        = var.security_group_name
  description = var.security_group_description
  tags = {
    Name = var.security_group_name
  }
}

resource "aws_instance" "instance" {
  ami           = var.ami
  instance_type = var.instance_type
  tags = {
    Name = var.instance_name
  }
}
```
1.3 Run this command
```
terraform apply
```
Type "yes"



