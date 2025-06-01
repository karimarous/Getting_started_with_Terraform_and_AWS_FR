# 1. Configure terraform block

1.1. Create a file named provider.tf

1.2 Copy the following code into provider.tf

```
terraform {
  required_version = "~> 1.12.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.98.0"
    }
  }
}
```

# 2. Configure provider bloc

Update provider.tf file with the following code
```
provider "aws" {
  region = "eu-west-3"
}
```

# 3. Initialize terraform env

Run the following command

```
terraform init
```
