resource "aws_security_group" "security_group" {
  name        = "karim-security-group"
  description = "karim security group"
  tags = {
    Name = "karim-security-group"
  }
}

resource "aws_instance" "instance" {
  ami           = "ami-0ff71843f814379b3"
  instance_type = "t3.micro"
  tags = {
    Name = "karim-instance"
  }
}

resource "aws_instance" "instance_import" {
  ami           = "ami_id"
  instance_type = "instance_type"
  tags = {
    Name = "instance-import"
  }
}