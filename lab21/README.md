# 1. Create a github repository

1.1 Go to your Github profile

1.2 Click on Repositories

1.3 Click on New

1.4 In Create a new repository page put test_ci as Repository name, check Add a README file and finally click on Create repository

1.5 Go to your PC and create a folder named test in you home desktop

1.6 Open this folder then click on the right button of your mouse and choose "Ouvrir dans le terminal"

1.7 Go back to the created Github repo and click "Code"

1.8 Choose HTTPS and copy the url provided

1.9 Go to the terminal and type "git clone" then paste the URL 

The command should looks like this
```
git clone copied_url
```

1.10 Just press "Enter" button 

1.11 Access the cloned repo
```
cd test_ci
``` 

1.12 Type the following command and run it
```
code .
``` 

1.13 Create a folder named .github

1.14 Create a folder inside .github named workflows 

1.14 Create file named test.yml under workflows folder and copy the following code
```
name: Terraform Security Scan with tfsec

on:
  workflow_dispatch:

jobs:
  tfsec:
    name: Run tfsec
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Run tfsec
        uses: aquasecurity/tfsec-action@v1.0.0

```


1.17 Create a file named main.tf and copy the following code
```
resource "aws_security_group" "ssh" {
  name_prefix = "test security"
  description = "test security"

  egress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = test_security"
  }
}

```

1.4 Push the code to the created Github repo
1.4.1 Run the following
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

variable "env" {
  type    = string
}
```

1.5 Create a file named outputs.tf under ec2 folder and copy the following code
```
output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.instance.id
}
```
1.6 In the root project, go to main.tf and replace the existing content with the following code
```
module "ec2" {
  source = "./modules/ec2"
  env = local.env
  sg_name = var.sg_name
  sg_description = var.sg_description
  sg_ingress_rules = var.sg_ingress_rules
  sg_egress_rules = var.sg_egress_rules
  ami_owner = var.ami_owner
  ami_name = var.ami_name
  ami_virtualization_type = var.ami_virtualization_type
  instance_type = var.instance_type
  instance_name = var.instance_name
}
```

1.7 In the root project, go to variables.tf and replace the existing content with the following code
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
```

1.8 In the root project rename the file "dev.tfvars" to "terraform.tfvars" and replace the existing content with the following code
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
```
1.9 Delete outputs.tf that exist in the root directory

1.10 Run the following command initalize the initialize the module
```
terraform init 
```
1.11 Run the following command to provision the resources
```
terraform apply -auto-approve
```
1.12 Run the following command to destroy the resources
```
terraform destroy -auto-approve
```


# 2. Publish the code to the repository
1.1 Create a folder named modules

1.2 Under the modules folder create another folder named ec2

# 3. Run workflow
1.1 Create a folder named modules

1.2 Under the modules folder create another folder named ec2