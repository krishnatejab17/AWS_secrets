variable "secrets" {
  type = list(object({
    name        = string
    description = string
    value       = string
  }))
}


resource "aws_secretsmanager_secret" "secrets" {
  count       = length(var.secrets)
  name        = var.secrets[count.index].name
  description = var.secrets[count.index].description
}

resource "aws_secretsmanager_secret_version" "secrets" {
  count         = length(var.secrets)
  secret_id     = aws_secretsmanager_secret.secrets[count.index].id
  secret_string = var.secrets[count.index].value
}

locals {
  secrets = [
    {
      name        = "db_password"
      description = "The password for the database"
      value       = "password"
    },
    {
      name        = "api_key"
      description = "The API key for external service"
      value       = "apikey123"
    },
    {
      name        = "admin_password"
      description = "The admin password for the application"
      value       = "adminpass"
    },
    {
      name        = "admin_token"
      description = "The admin token for the application"
      value       = "admintoken"
    },
    {
      name        = "smtp_password"
      description = "The SMTP password for email service"
      value       = "smtppass"
    }
  ]
}