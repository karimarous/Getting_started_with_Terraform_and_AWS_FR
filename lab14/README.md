# 1. Use count and count.index 

1.1 Go to main.tf and replace to block resource aws_instance with the following code
```
resource "aws_instance" "instance" {
  count = 2
  ami   = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  tags = {
    Name = "${var.instance_name}-${local.env}-${count.index + 1}"
  }
}
```
1.2 Create outputs.tf file and copy the following code
```
output "instance_id" {
  value = aws_instance.instance.*.id
}
```
1.3 Run the following command
```
terraform apply -var-file="dev.tfvars"
```
1.4 Type "yes"

1.5 Run the following command to destroy the resources
```
terraform destroy -var-file="dev.tfvars"
```
1.6 Type "yes"