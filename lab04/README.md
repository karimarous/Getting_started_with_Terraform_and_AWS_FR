# 1. Export resources attributes
1.1. Create a file named outputs.tf

1.2. Copy the following code into outputs.tf
```
output "security_group_id" {
  value = aws_security_group.security_group.id
}

output "security_group_name" {
  value = aws_security_group.security_group.name
}

output "instance_id" {
  value = aws_instance.instance.id
}
```

1.3 Run this command

```
terraform apply
```
1.4 Type "yes"

1.5 Run this command

```
terraform output instance_id
```

1.6 Run this command to list all outputs

```
terraform output 
```

