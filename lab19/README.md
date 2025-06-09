# 1. Create workspaces and deploy module on each env

1.1 Replace the code that exist in **locals.tf** with the following code
```
locals {
  env = terraform.workspace
}
```
1.2 Rename the file **dev.tfvars** to **terraform.tfvars**

1.2 Run the following command to create a workspace **dev**
```
terraform workspace new dev
```
1.3 the following command list all workspaces
```
terraform workspace list
```
1.4 Run the following command to provision the resources in workspace **dev**
```
terraform apply -auto-approve
```
1.5 Run the following command to destroy the resources in workspace **dev**
```
terraform destroy -auto-approve
```
1.6 Run the following command to create a workspace **prod**
```
terraform workspace new prod
```
1.7 Run the following command to provision the resources in workspace **prod**
```
terraform apply -auto-approve
```
1.8 Run the following command to destroy resources in **prod**
```
terraform destroy -auto-approve
```
1.9 Go back to **dev** workspace
Run the following command
```
terraform workspace select dev
```
1.10 Delete **prod** workspace
```
terraform workspace delete prod
```