# 1. Use local variable

1.1 Create a file named **locals.tf** then copy the following code inside it
```
locals {
   env = "dev"
}
```

1.2 Go to **variables.tf** then remove the block variable env 

1.3 Go to **dev.tfvars** and remove the ligne that start with "env ="

1.4 Go to **main.tf** and replace any **var.env** with **local.env**

1.5 Run the following command
```
terraform apply -var-file="dev.tfvars"
```
1.6 Run the following command to destroy all the resources
```
terraform destroy -var-file="dev.tfvars"
```
1.7 Type **yes**