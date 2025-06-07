resource "aws_security_group" "security_group" {
  name        = "${var.security_group_name}-${local.env}"
  description = "${var.security_group_description}-${local.env}"
  tags = {
    Name = "${var.security_group_name}-${local.env}"
  }
}

resource "aws_instance" "instance" {
  count = 2
  ami           = var.ami
  instance_type = var.instance_type
  tags = {
    Name = "${var.instance_name}-${local.env}-${count.index + 1}"
  }
}