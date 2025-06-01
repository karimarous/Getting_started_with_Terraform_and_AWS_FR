# 1. Modify the resource out of terraform
1.1. Modify the EC2 instance name from "karim-instance" to "karim-instance1" in the AWS EC2 console

1.2. Run the following command
```
terrform apply
```
1.3 Go to AWS EC2 console and verify the name of the instance

# 2. Modify the resource in the terraform configuration file
2.1. Replace the EC2 instance in main.tf with the following code
```
resource "aws_instance" "instance" {
   ami           = "ami-id"
   instance_type = "t3.micro"
   tags = {
   Name = "karim-instance1"
   }
}
```
2.2 Replace "ami-id" with an ami of the EC2 console and Replace "karim" with your name

2.3. Run the following command
```
terrform apply
```
2.4 Type "yes"

# 3. Fix the file main.tf
3.1 Replace the EC2 instance in main.tf with the following code
```
resource "aws_instance" "instance" {
   ami           = "ami-0ff71843f814379b3"
   instance_type = "t3.micro"
   tags = {
   Name = "karim-instance"
   }
}
```
3.2 Replace "karim" with your name

3.3. Run the following command
```
terrform apply
```
2.4 Type "yes"