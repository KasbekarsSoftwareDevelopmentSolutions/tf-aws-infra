# File orgInfra/modules/iam_roles/outputs.tf

output "iam_role_name" {
  value       = aws_iam_role.this.name
  description = "The name of the IAM role created"
}

output "iam_role_arn" {
  value       = aws_iam_role.this.arn
  description = "The ARN of the IAM role created"
}

# Outputs for instance profile
output "iam_instance_profile_name" {
  value       = aws_iam_instance_profile.this.name
  description = "The name of the IAM instance profile created"
}

output "iam_instance_profile_arn" {
  value       = aws_iam_instance_profile.this.arn
  description = "The ARN of the IAM instance profile created"
}

output "iam_lambda_role_name" {
  description = "The name of the Lambda IAM role created"
  value       = aws_iam_role.lambda_execution_role.name
}

output "iam_lambda_role_arn" {
  description = "The ARN of the Lambda IAM role created"
  value       = aws_iam_role.lambda_execution_role.arn
}
