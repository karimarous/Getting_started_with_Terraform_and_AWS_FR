# 1. Add an empty variable named env

Copy the following code and update variables.tf
```
variable "env" {
  type = string
}
```

# 2. Update the main.tf with the variable env

Copy the following code and update variables.tf
```
resource "aws_security_group" "security_group" {
  name        = "${var.security_group_name}-${var.env}"
  description = "${var.security_group_description}-${var.env}"
  tags = {
    Name = "${var.security_group_name}-${var.env}"
  }
}

resource "aws_instance" "instance" {
  ami           = var.ami
  instance_type = var.instance_type
  tags = {
    Name = "${var.instance_name}-${var.env}"
  }
}
```
# 3. Pass the value of the variable using cli
Run the following command
```
terraform apply -var 'env=dev'
```