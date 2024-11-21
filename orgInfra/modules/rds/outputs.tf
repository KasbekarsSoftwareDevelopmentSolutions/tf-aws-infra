# File orgInfra/modules/rds/outputs.tf

output "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.rds_instance.endpoint
}

output "rds_port" {
  description = "The port on which the RDS instance is listening"
  value       = aws_db_instance.rds_instance.port
}

output "db_name" {
  description = "The name of the database"
  value       = aws_db_instance.rds_instance.db_name
}

output "rds_master_username" {
  description = "The master username for the RDS instance"
  value       = aws_db_instance.rds_instance.username
}

output "rds_arn" {
  description = "The ARN of the RDS database."
  value       = aws_db_instance.rds_instance.arn
}
