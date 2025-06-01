# 1. Provision an EC2 instance

1.1. Create a file named main.tf

1.2. Copy the following code into main.tf
```
resource "aws_instance" "instance" {
   ami           = "ami-0ff71843f814379b3"
   instance_type = "t3.micro"
   tags = {
      Name = "karim-instance"
   }
}
```
1.3 Replace "karim" with your name

1.4 Run the following commands

1.4.1 Run the following command to see the resources that will be created
```
terraform plan
```

1.4.2 Run the following command to provision the resources

```
terraform apply
```

Type "yes"

# 2. Provision a Security Group
2.1. Update main.tf with the following code

```
resource "aws_security_group" "security_group" {
   name        = "karim-security-group"
   description = "karim security group"
   tags = {
      Name = "karim-security-group"
   }
}
```

2.2 Replace "karim" with "your_name"

2.3 Run the following commands
```
terraform apply
```

2.4 Type "yes"