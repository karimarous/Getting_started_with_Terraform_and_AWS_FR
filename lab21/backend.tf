terraform {
  backend "s3" {
    bucket         = "your-s3-bucket"
    key            = "karim/terraform.tfstate"
    region         = "eu-west-3"
    use_lockfile   = "true"
    encrypt        = true
  }
}