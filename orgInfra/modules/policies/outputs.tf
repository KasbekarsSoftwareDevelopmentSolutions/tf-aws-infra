# File orgInfra/modules/policies/outputs.tf

output "custom_cloudwatch_log_policy_arn" {
  description = "ARN of the custom CloudWatch Log policy"
  value       = aws_iam_policy.custom_cloudwatch_log_policy.arn
}

output "custom_cloudwatch_metrics_policy_arn" {
  description = "ARN of the custom CloudWatch Metrics policy"
  value       = aws_iam_policy.custom_cloudwatch_metrics_policy.arn
}

output "custom_ec2user_s3_policy_arn" {
  description = "ARN of the custom S3 policy for EC2 user"
  value       = aws_iam_policy.custom_ec2user_s3_policy.arn
}
