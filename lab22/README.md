# 0. Create the folder project3
0.1 Go to your home desktop, open the folder named formation_terraform

0.2 Create a folder named project3. We will use for the rest of labs

0.3 Access the folder project3 then click on the right button of your mouse and choose "Ouvrir dans le terminal"

0.4 Type the following command
```
code .
```
# 2. Configure remote backend

2.1. Create a file named backend.tf

2.2 Copy the following code into backend.tf
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

2.3 In the backend.tf file, replace "karim" with "your_name" 

# 3. Migrate state file to remote backend

Run the following command
```
terraform init
```
