region = "eu-west-3"  
vpc_name = "karim-vpc"
cidr_vpc = "10.16.0.0/16"

env_subnets_caracteristics = {
    dev = {
        web  = [
            {
            name = "public-subnet-web-1"
            cidr = "10.16.48.0/20"
            az = "eu-west-3a"
            },
            {
            name = "public-subnet-web-2"
            cidr = "10.16.112.0/20"
            az = "eu-west-3b"
            },
            {
            name = "public-subnet-web-3"
            cidr = "10.16.176.0/20"
            az = "eu-west-3c"
            }
        ]
        app  = [
            {
            name = "private-subnet-app-1"
            cidr = "10.16.32.0/20"
            az = "eu-west-3a"
            },
            {
            name = "private-subnet-app-2"
            cidr = "10.16.96.0/20"
            az = "eu-west-3b"
            },
            {
            name = "private-subnet-app-3"
            cidr = "10.16.160.0/20"
            az = "eu-west-3c"
            }
        ]
        db  = [
            {
            name = "private-subnet-db-1"
            cidr = "10.16.16.0/20"
            az = "eu-west-3a"
            },
            {
            name = "private-subnet-db-2"
            cidr = "10.16.80.0/20"
            az = "eu-west-3b"
            },
            {
            name = "private-subnet-db-3"
            cidr = "10.16.144.0/20"
            az = "eu-west-3c"
            }
        ]
    }
}