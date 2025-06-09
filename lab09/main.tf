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
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  tags = {
    Name = var.instance_name
    env = local.env
  }
}