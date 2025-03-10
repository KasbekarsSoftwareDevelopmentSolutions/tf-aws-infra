# File orgInfra/modules/security_groups/outputs.tf

output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.app_security_group.id
}

output "security_group_name" {
  description = "The name of the security group"
  value       = aws_security_group.app_security_group.name
}
