# 1. Create a github repository

1.1 Go to your Github profile

1.2 Click on Repositories

1.3 Click on New

1.4 In Create a new repository page put test_ci as Repository name, check Add a README file and finally click on Create repository

1.5 Go to your PC and create a folder named test in you home desktop

1.6 Open this folder then click on the right button of your mouse and choose "Ouvrir dans le terminal"

1.7 Go back to the created Github repo and click "Code"

1.8 Choose HTTPS and copy the url provided

1.9 Go to the terminal and type "git clone" then paste the URL 

The command should looks like this
```
git clone copied_url
```

1.10 Just press "Enter" button 

1.11 Access the cloned repo
```
cd test_ci
``` 

1.12 Type the following command and run it
```
code .
``` 
# 2 Add code and run pipeline
2.1 Create a folder named .github

2.2 Create a folder inside .github named workflows 

2.3 Create file named test.yml under workflows folder and copy the following code
```
name: Terraform Security Scan with tfsec

on:
  workflow_dispatch:

jobs:
  tfsec:
    name: Run tfsec
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Run tfsec
        uses: aquasecurity/tfsec-action@v1.0.0

```


2.4 In the root directory, create a file named main.tf and copy the following code
```
resource "aws_security_group" "ssh" {
  name_prefix = "test security"
  description = "test security"

  ingress {
    description = "allow inboud traffic"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "test_security"
  }
}

```
2.5 Push the code to the created Github repo use the following commands

```
git add .
```
```
git commit -m "test security in ci"
```
```
git push origin main
```
2.6 Go to the created repo and click on Actions

2.7 In the left panel click on Terraform Security Scan with tfsec

2.8 Click on Run workflow. Ensure your using the main branch then click on Run workflow

2.9 Reload the page

2.10 Open the workflow that has been started and take a look at Run tfsec step

# 3. Fix the issue

3.1 Go back to VSCode and open main.tf

3.2 Replace the value of cidr_blocks "0.0.0.0/0" by this value "10.0.0.0/24"

3.3 Push the code to the created Github repo use the following commands
```
git add .
```
```
git commit -m "test security in ci"
```
```
git push origin main
```
3.4 Click on Actions

3.5 In the left panel click on Terraform Security Scan with tfsec

3.6 Click on Run workflow. Ensure your using the main branch then click on Run workflow

3.7 Reload the page

3.8 Open the workflow that has been started and take a look at Run tfsec step

3.9 Delete the created repo if you want to do a cleanup