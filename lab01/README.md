# 0. Create the project folder

0.1 Go to your home desktop and create a folder named ***formation_terraform***

0.2 Access this folder and create a folder named ***project1***. We will use it for the rest of the project

0.3 Open the folder project1 then click on the right button of your mouse and choose "Ouvrir dans le terminal"

0.4 Type the following code
```
code .
```

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
