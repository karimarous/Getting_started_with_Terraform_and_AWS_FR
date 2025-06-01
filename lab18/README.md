# 1. Create workspaces and deploy module on each env

1.1 Replace the code that exist in locals.tf with the following code
```
locals {
   env = terraform.workspace
}
```
1.2 Run the following commands
```
terraform workspace new dev
terraform apply -auto-approve
```

1.3 Run the following command
```
terraform workspace new prod
terraform apply -auto-approve
```

1.4 Run the following commands to destroy resources in prod
```
terraform workspace select prod
terraform destroy -auto-approve
```

1. Go back to dev workspace
Run the following command
```
terraform workspace select dev
```