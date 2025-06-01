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