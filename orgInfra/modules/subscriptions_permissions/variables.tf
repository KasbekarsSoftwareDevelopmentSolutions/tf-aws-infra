# File orgInfra/modules/subscriptions_permissions/variables.tf

variable "sns_topic_arn" {
  description = "Name of the AWS Sns topic."
  type        = string
}

variable "lambda_function_arn" {
  description = "The Lambda Function ARN to subscribe the SNS topic."
  type        = string
}
