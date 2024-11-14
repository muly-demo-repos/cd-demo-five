resource "random_password" "vikoosh_secret_password" {
  length  = 20
  special = false
}

resource "aws_secretsmanager_secret" "secrets_vikoosh" {
  name = "vikoosh_secrets"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_secretsmanager_secret_version" "secrets_version_vikoosh" {
  secret_id     = aws_secretsmanager_secret.secrets_vikoosh.id
  secret_string = jsonencode({
    BCRYPT_SALT       = "10"
    JWT_EXPIRATION    = "2d"
    JWT_SECRET_KEY    = random_password.vikoosh_secret_password.result
    DB_URL            = "postgres://${module.rds_vikoosh.db_instance_username}:${random_password.vikoosh_database_password.result}@${module.rds_vikoosh.db_instance_address}:5432/${module.rds_vikoosh.db_instance_name}"
  })
}
