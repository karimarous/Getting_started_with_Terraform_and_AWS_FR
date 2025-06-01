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