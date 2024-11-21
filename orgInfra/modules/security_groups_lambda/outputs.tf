# File orgInfra/modules/security_groups_lambda/outputs.tf

output "lambda_security_group_arn" {
  description = "The Lambda Security Group ARN"
  value       = aws_security_group.lambda_security_group.arn
}

output "lambda_security_group_id" {
  description = "The Lambda Security Group ID"
  value       = aws_security_group.lambda_security_group.id
}

output "lambda_security_group_name" {
  description = "The Lambda Security Group Name"
  value       = aws_security_group.lambda_security_group.name
}
