vpc_name = "karim-vpc"
vpc_cidr = "10.0.0.0/16"
public_subnets = {
  subnet-1 = {
    name = "subnet-1"
    cidr = "10.0.0.0/24"
    az   = "eu-west-3a"
  },
  subnet-2 ={
    name = "subnet-2"
    cidr = "10.0.1.0/24"
    az   = "eu-west-3b"
  }
}
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