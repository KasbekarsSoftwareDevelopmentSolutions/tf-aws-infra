output "rds_security_group_id" {
  description = "The ID of the RDS security group"
  value       = aws_security_group.rds_security_group.id
}
