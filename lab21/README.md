# 1. Configure remote backend

1.1. Create a file named backend.tf

1.2 Copy the following code into backend.tf
```
terraform {
  backend "s3" {
    bucket         = "your-s3-bucket"
    key            = "karim/terraform.tfstate"
    region         = "us-east-1" # your s3 bucket region
    use_lockfile   = "true"
    encrypt        = true
  }
} 
```
Modify your-s3-bucket with the bucket that you want to use

1.3 In the backend.tf file, replace "karim" with "your_name" 

# 2. Migrate state file to remote backend

Run the following command

```
terraform init
```
