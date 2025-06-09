# 1. Import resource created outside Terraform 
1.1 Create an EC2 instance in the default VPC without a key pair in AWS console

1.2 Open **main.tf** in the root project and add the following code
```
resource "aws_instance" "instance_import" {
  ami           = "ami_id"
  instance_type = "instance_type"
  tags = {
    Name = "instance-import"
  }
}
```

Replace **ami_id** with the ami id of the running instance
Replace **instance_type** with the instance type of the running instance

1.3 Import resource (method 1)

1.3.1 Run the following command
```
terraform import aws_instance.instance_import instance_id
```

1.3.2 Run the following command
```
terraform state rm aws_instance.instance_import 
```

1.4 Import resource (method 2)

1.4.1 Open **main.tf** and update it with the following code
```
import {
  to = aws_instance.instance_import
  id = "instance_id"
}
```
Note: Replace **instance_id** with the id of the running instance

1.4.2 Run the following command
```
terraform apply
```
1.4.3 Type **yes**

1.4.4 Delete the import bloc

1.4.5 Destroy all resources
```
terraform destroy
```
1.4.6 Type **yes**