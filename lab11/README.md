# 1. Deploy nginx server

1.1 Go to AWS and create a key pair with your name. In my case, I have created a key pair called "karim"

1.2 Download "karim.pem" key pair and put in the root directory of the project

1.3 Replace the value of the tag Name of the resource aws_security_group to "${var.sg_name}-${local.env}"

1.4 Replace the value of the tag Name of the resource aws_instance to "${var.instance_name}-${local.env}"

1.5 Run the following command
```
terraform apply -var-file="dev.tfvars"
```
1.6 Type "yes"

1.7 Run the following command to delete the resources
```
terraform destroy -var-file="dev.tfvars"
```
1.8 Type "yes"