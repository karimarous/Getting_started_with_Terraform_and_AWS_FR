# 1. Pass the variable env value using a file

1.1 Create file named dev.tfvars

1.2 Copy the following into dev.tfvars
```
env = "dev"
```

1.3 Run the following command

```
terraform apply -var-file="dev.tfvars"
```