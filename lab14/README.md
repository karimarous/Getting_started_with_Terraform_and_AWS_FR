# 1. Use condition in resource

1.1 Go to main.tf and replace to block resource aws_instance with the following code
```
resource "aws_instance" "instance" {
  count = 2
  ami           = var.ami
  instance_type = local.env == "dev" ? var.instance_type : "t3.small"
  tags = {
    Name = "${var.instance_name}-${local.env}-${count.index + 1}"
  }
}
```

1.2 Run th following command
```
terraform apply -var-file="dev.tfvars"
```
