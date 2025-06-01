# 1. Use count and count.index 

1.1 Go to main.tf and replace to block resource aws_instance with the following code
```
resource "aws_instance" "instance" {
  count = 2
  ami           = var.ami
  instance_type = var.instance_type
  tags = {
    Name = "${var.instance_name}-${local.env}-${count.index + 1}"
  }
}
```

1.2 Go to outputs.tf and replace the block output instance_id with the following code
```
output "instance_id" {
  value = aws_instance.instance.*.id
}
```

1.2 Run th following command
```
terraform apply -var-file="dev.tfvars"
```
Type "yes"