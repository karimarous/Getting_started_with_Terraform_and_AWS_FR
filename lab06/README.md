# 1. Add an empty variable named env

Copy the following code and update variables.tf
```
variable "env" {
  type = string
}
```

# 2. Update the main.tf with the variable env

2.1 Copy the following code and add it in main.tf as a tag to the resource aws_security_group 
```
env = var.env
```
2.2 Copy the following code and add it in main.tf as a tag to the resource aws_instance 
```
env = var.env
```
# 3. Pass the value of the variable using cli
3.1 Run the following command
```
terraform apply -var 'env=dev'
```
3.2 Type "yes"