# 1. Test variable condition max

1.1 Replace the variable **instance_name** bloc with the following code
```
variable "instance_name" {
  type = string
  validation {
    condition = length(var.instance_name) <= 5
    error_message = "The instance name must have at max 5 characters."
  }
}
```

1.2 Run the following command
```
terraform apply -var-file="dev.tfvars"
```

# 2. Test variable condition min
2.1 Replace the variable **instance_name** bloc with the following code
```
variable "instance_name" {
  type = string
  validation {
    condition = length(var.instance_name) >= 5
    error_message = "The instance name must have at min 5 characters."
  }
}
```

2.2 Run the following command
```
terraform apply -var-file="dev.tfvars"
```
2.3 Type **yes**

2.4 Run the following command
```
terraform destroy -var-file="dev.tfvars"
```
2.5 Type **yes**