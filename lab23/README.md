# 1. Provison some infrastructure
1.1 Create a file named **provider.tf** and copy the following code
```

terraform {
  required_version = ">= 1.12.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.98.0"
    }
  }
}

provider "aws" {
  region = "eu-west-3"
}
```

1.2 Create a file named **main.tf** and copy the following code
```
resource "aws_security_group" "security_group" {
  name        = "karim-security-group"
  description = "karim security group"
  tags = {
    Name = "karim-security-group"
  }
}

resource "aws_instance" "instance" {
  ami           = "ami-0ff71843f814379b3"
  instance_type = "t3.micro"
  tags = {
    Name = "karim-instance"
  }
}
```
1.3 Run the following command
```
terraform init
```
1.4 Run the following command
```
terraform apply -auto-approve
```

# 2. List content state file 
2.1 Using state file in the remote backend

2.1.1 Go to **AWS S3 bucket console** used in the remote backend and download the file that exist under **karim** folder

2.1.2 Open the file downloaded

2.2 Using Terraform CLI
Run following command
```
terraform state list
```

# 3. Show resource
3.1 Show the resource created in the state file downloaded

3.2 Show the resource created using Terraform CLI
Run the following command
```
terraform state show aws_security_group.security_group
```

# 4. Rename terraform resource
4.1 Using Terraform CLI 

4.1.1 Go to **main.tf** and replace **security_group** with **security_group1**

4.1.2 Run the following command   
```
terraform state mv aws_security_group.security_group aws_security_group.security_group1
```
4.1.3 Run tho following command
```
terraform state list
```

4.2 Using block moved and Terraform CLI (new approch)

4.2.1 Go to **main.tf** and replace **security_group1** with **security_group2**

4.2.2 Go to **main.tf** and copy the following code
```
moved {
   from = aws_security_group.security_group1
   to = aws_security_group.security_group2
}
```

4.2.3 Run the following command
```
terraform apply
```
4.2.4 Type **yes**

4.2.5 Run tho following command
```
# list of created resources
terraform state list
```
4.2.6 Remove the entire moved block

# 5. Refresh state file
Run the following command
```
terraform refresh
```

# 6. Fix main.tf file
6.1 Go to **main.tf** and replace **security_group2** with **security_group**

6.2 Run the following command   
```
# Rename terraform resource
terraform state mv aws_security_group.security_group2 aws_security_group.security_group
```