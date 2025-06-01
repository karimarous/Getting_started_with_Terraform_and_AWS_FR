# 1. Deploy nginx server

1.1 Go to AWS and create a key pair with your name. In my case, I have created a key pair called "karim"

1.2 Download "karim.pem" key pair and put in the root directory of the project

1.3 Go to main.tf and override it with the following code
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
    Name = "${var.sg_name}-${local.env}"
  }
}

resource "aws_instance" "instance" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  security_groups        = [aws_security_group.ssh.name]
  key_name               = var.key_name # Replace with your key pair name

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.private_key_path) 
      host        = self.public_ip
    }
  }

  tags = {
    Name = "${var.instance_name}-${local.env}"
  }
}
```

1.4 Replace "karim" with "your_name"

1.5 Go to variables.tf and override it with the following code
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

variable "key_name" {
  type    = string
}
variable "private_key_path" {
  type    = string 
}
```

1.6 Go to dev.tfvars and override it with the following code
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
key_name      = "karim"
private_key_path = "./karim.pem" # Path to your private key
```

1.7 Delete outputs.tf 

1.8 Run the following command
```
terraform apply -var-file="dev.tfvars"
```
Type "yes"

1.9 Delete resources
Run the following command
```
terraform destroy -var-file="dev.tfvars"
```
Type "yes"