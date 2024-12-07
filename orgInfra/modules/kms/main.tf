# File orgInfra/modules/kms/main.tf

# KMS Keys for Each Resource with 90-Day Rotation
resource "aws_kms_key" "ec2_kms_key" {
  description             = "KMS key for EC2 Access Key & Secret Key"
  enable_key_rotation     = true
  deletion_window_in_days = 10
}

resource "aws_kms_key" "rds_kms_key" {
  description             = "KMS key for RDS Credentials"
  enable_key_rotation     = true
  deletion_window_in_days = 10
}

resource "aws_kms_key" "s3_kms_key" {
  description             = "KMS key for S3 Bucket Name"
  enable_key_rotation     = true
  deletion_window_in_days = 10
}

resource "aws_kms_key" "lambda_kms_key" {
  description             = "KMS key for Lambda Email Service Credentials"
  enable_key_rotation     = true
  deletion_window_in_days = 10
}

# Aliases for KMS Keys
resource "aws_kms_alias" "ec2_kms_alias" {
  name          = "alias/ec2-kms-key"
  target_key_id = aws_kms_key.ec2_kms_key.key_id
}

resource "aws_kms_alias" "rds_kms_alias" {
  name          = "alias/rds-kms-key"
  target_key_id = aws_kms_key.rds_kms_key.key_id
}

resource "aws_kms_alias" "s3_kms_alias" {
  name          = "alias/s3-kms-key"
  target_key_id = aws_kms_key.s3_kms_key.key_id
}

resource "aws_kms_alias" "lambda_kms_alias" {
  name          = "alias/lambda-kms-key"
  target_key_id = aws_kms_key.lambda_kms_key.key_id
}

# Random Password Generation for RDS
resource "random_password" "rds_password" {
  length  = 16
  special = true
}

# Store RDS Credentials in Secrets Manager with RDS KMS Key
resource "aws_secretsmanager_secret" "rds_credentials" {
  name                    = "rds/credentials"
  kms_key_id              = aws_kms_key.rds_kms_key.arn
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "rds_credentials_version" {
  secret_id = aws_secretsmanager_secret.rds_credentials.id
  secret_string = jsonencode({
    db_name  = var.db_name
    username = var.rds_master_username
    password = random_password.rds_password.result
  })
}

# Store S3 Bucket Name in Secrets Manager with S3 KMS Key
resource "aws_secretsmanager_secret" "s3_bucket_name" {
  name                    = "s3/bucket-name"
  kms_key_id              = aws_kms_key.s3_kms_key.arn
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "s3_bucket_name_version" {
  secret_id     = aws_secretsmanager_secret.s3_bucket_name.id
  secret_string = var.bucket_name
}

# Store EC2 Access & Secret Keys in Secrets Manager with EC2 KMS Key
resource "aws_secretsmanager_secret" "ec2_credentials" {
  name                    = "ec2/credentials"
  kms_key_id              = aws_kms_key.ec2_kms_key.arn
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "ec2_credentials_version" {
  secret_id = aws_secretsmanager_secret.ec2_credentials.id
  secret_string = jsonencode({
    access_key = var.ec2_access_key
    secret_key = var.ec2_secret_key
  })
}

# Store Email Service Credentials for Lambda with Lambda KMS Key
resource "aws_secretsmanager_secret" "lambda_email_credentials" {
  name                    = "lambda/email-credentials"
  kms_key_id              = aws_kms_key.lambda_kms_key.arn
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "lambda_email_credentials_version" {
  secret_id = aws_secretsmanager_secret.lambda_email_credentials.id
  secret_string = jsonencode({
    email_service_api_key = var.mailgun_api_key
  })
}
