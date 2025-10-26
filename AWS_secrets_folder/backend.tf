#backend configuration
terraform {
  backend "s3" {
    bucket         = "unique-name"
    key            = "path/to/my/terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}

