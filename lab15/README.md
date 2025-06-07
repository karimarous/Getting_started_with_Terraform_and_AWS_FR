# 1. Use condition in resource

1.1 Go to main.tf and replace to block resource aws_instance with the following code
```
resource "aws_instance" "instance" {
  count = 2
  ami   = data.aws_ami.ubuntu.id
  instance_type = local.env == "dev" ? var.instance_type : "t3.small"
  tags = {
    Name = "${var.instance_name}-${local.env}-${count.index + 1}"
  }
}
```

1.2 Run the following command
```
terraform apply -var-file="dev.tfvars"
```
1.3 Type "yes"

1.2 Run the following command to destroy the resources
```
terraform destroy -var-file="dev.tfvars"
```
1.4 Type "yes"