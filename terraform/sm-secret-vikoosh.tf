resource "random_password" "vikoosh_secret_password" {
  length  = 20
  special = false
}

resource "aws_secretsmanager_secret" "secrets_vikoosh" {
  name = "vikoosh_secrets"
}

resource "aws_secretsmanager_secret_version" "secrets_version_vikoosh" {
  secret_id     = aws_secretsmanager_secret.secrets_vikoosh.id
  secret_string = jsonencode({
    BCRYPT_SALT       = "10"
    JWT_EXPIRATION    = "2d"
    JWT_SECRET_KEY    = random_password.vikoosh_secret_password.result
    DB_URL     = "Server=${module.rds_vikoosh.db_instance_address};Port=5432;Database=${module.rds_vikoosh.db_instance_name};User Id=${module.rds_vikoosh.db_instance_username};Password=${random_password.vikoosh_database_password.result};"
  })
}
