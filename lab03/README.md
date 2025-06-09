# 1. Modify the resource out of terraform
1.1 Modify the EC2 instance name from **karim-instance** to **karim-instance1** in the AWS EC2 console

1.2 Run the following command
```
terraform apply
```
1.3 Type **yes**

1.4 Go to AWS EC2 console and verify the name of the instance

# 2. Modify the resource in the terraform configuration file
2.1 Replace the value of the tag Name of the resource aws_instance in main.tf with "karim-instance1"

Note: Replace **karim** with **your_name**

2.3 Run the following command
```
terrform apply
```
2.4 Type **yes**

# 3. Fix the file main.tf
3.1 Replace the value of the tag Name of the resource aws_instance in **main.tf** file with **karim-instance**

Note: Replace **karim** with **your_name**

3.2 Run the following command
```
terrform apply
```
2.3 Type **yes**