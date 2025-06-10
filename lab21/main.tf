resource "aws_security_group" "ssh" {
  name_prefix = "test security"
  description = "test security"

  ingress {
    description = "allow inboud traffic"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "test_security"
  }
}