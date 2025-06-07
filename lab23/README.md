# 1. List content state file 
1.1 Using state file in the remote backend

1.1.1 Go to S3 bucket used in the remote backend and download the file that exist under karim folder

1.1.2 Open the file downloaded

1.2 Using Terraform CLI
Run following command
```
# 1 List content of state file
terraform state list
```

# 2. Show resource
2.1 Show the resource created in the state file downloaded

2.2 Show the resource created using Terraform CLI
Run the following command
```
# 2 Show resources
terraform state show aws_security_group.security_group
```

# 3. Rename terraform resource
3.1 Using Terraform CLI 

3.1.1 Go to main.tf and replace "security_group" with "security_group1"

3.1.2 Run the following command   
```
# Rename terraform resource
terraform state mv aws_security_group.security_group aws_security_group.security_group1
```
3.1.3 Run tho following command
```
# list of created resources
terraform state list
```

3.2 Using block moved and Terraform CLI (new approch)

3.2.1 Go to main.tf and replace "security_group1" with "security_group2"

3.2.2 Go to main.tf and copy the following code
```
moved {
   from = aws_security_group.security_group1
   to = aws_security_group.security_group2
}
```

3.2.3 Run the following command
```
terraform apply
```
3.2.4 Type "yes"

3.2.5 Run tho following command
```
# list of created resources
terraform state list
```

3.2.6 Remove the entire moved block

# 4. Refresh state file
Run the following command
```
terraform refresh
```

# 5. Fix main.tf file
5.1 Go to main.tf and replace "security_group2" with "security_group"

5.2 Run the following command   
```
# Rename terraform resource
terraform state mv aws_security_group.security_group2 aws_security_group.security_group
```