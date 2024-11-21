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

output "custom_ec2user_sns_publish_policy_arn" {
  description = "ARN of the custom SNS policy for EC2 user"
  value       = aws_iam_policy.custom_ec2user_sns_publish_policy.arn
}

output "custom_lambda_rds_access_policy_arn" {
  description = "ARN of the custom RDS Access policy for AWS Lambda Function"
  value       = aws_iam_policy.custom_lambda_rds_access_policy.arn
}

output "custom_lambda_sns_access_policy_arn" {
  description = "ARN od teh custom SNS Access policy for the AWS Lambda Function"
  value       = aws_iam_policy.custom_lambda_sns_access_policy.arn
}
