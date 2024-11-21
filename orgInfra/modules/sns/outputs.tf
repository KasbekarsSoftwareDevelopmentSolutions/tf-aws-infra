# File orgInfra/modules/sns/outputs.tf

output "sns_topic_arn" {
  description = "The ARN of the SNS topic for the web app."
  value       = aws_sns_topic.app_sns_topic.arn
}
