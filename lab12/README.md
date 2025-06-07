# 1. Test variable condition max

1.1 Replace the variable instance_name bloc with the following code
```
variable "instance_name" {
  type = string
  validation {
    condition = length(var.instance_name) =< 5
    error_message = "The instance name must have at max 5 characters."
  }
}
```

1.2 Run the following command
```
terraform apply -var-file="dev.tfvars"
```

# 1. Test variable condition min
1.1 Replace the variable instance_name bloc with the following code
```
variable "instance_name" {
  type = string
  validation {
    condition = length(var.instance_name) >= 5
    error_message = "The instance name must have at min 5 characters."
  }
}
```

1.2 Run the following command
```
terraform apply -var-file="dev.tfvars"
```
Type "yes"

1.3 Run the following command
```
terraform destroy -var-file="dev.tfvars"
```
Type "yes"