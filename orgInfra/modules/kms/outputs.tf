# File orgInfra/modules/kms/outputs.tf

output "rds_credentials_secret_arn" {
  description = "Secrets Manager ARN for RDS credentials"
  value       = aws_secretsmanager_secret.rds_credentials.arn
}

output "s3_bucket_name_secret_arn" {
  description = "Secrets Manager ARN for S3 Bucket Name"
  value       = aws_secretsmanager_secret.s3_bucket_name.arn
}

output "ec2_credentials_secret_arn" {
  description = "Secrets Manager ARN for EC2 credentials"
  value       = aws_secretsmanager_secret.ec2_credentials.arn
}

output "lambda_email_credentials_secret_arn" {
  description = "Secrets Manager ARN for Lambda Email Service Credentials"
  value       = aws_secretsmanager_secret.lambda_email_credentials.arn
}
