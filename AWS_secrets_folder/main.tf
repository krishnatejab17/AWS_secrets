terraform {
  required_version = "1.13.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.15.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "unique-name"
  acl    = "private"
  versioning {
    enabled = true
  }
}
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
resource "aws_secretsmanager_secret" "secrets" {
  for_each    = var.secrets
  name        = each.key
  description = each.value.description
}

resource "aws_secretsmanager_secret_version" "secrets" {
  for_each      = var.secrets
  secret_id     = aws_secretsmanager_secret.secrets[each.key].id
  secret_string = each.value.value
}

