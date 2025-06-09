# 1. Configure expression

1.1 Replace the **value** of the tag **Name** of the resource **aws_security_groupaws_security_group** with the following code
```
"${var.sg_name}-${local.env}"
```
1.2 Replace the **value** of the tag **Name** of the **resource aws_instance** with the following code
```
"${var.instance_name}-${local.env}"
```
1.3 Run the following command
```
terraform apply -var-file="dev.tfvars"
```
1.4 Type "yes"

1.5 Run the following command to delete the resources
```
terraform destroy -var-file="dev.tfvars"
```
1.6 Type "yes"