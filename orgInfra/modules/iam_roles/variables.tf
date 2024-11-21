# File orgInfra/modules/iam_roles/variables.tf

variable "iam_role_name" {
  description = "The name of the IAM role"
  type        = string
}

variable "iam_lambda_role_name" {
  description = "The name of the Lambda IAM role"
  type        = string
}

variable "trusted_aws_principal" {
  description = "The AWS principal (user or service) allowed to assume this IAM role"
  type        = string
}

variable "iam_policy_arn_AmazonSSMManagedInstanceCore" {
  description = "IAM policy AmazonSSMManagedInstanceCore ARN to attach to the role"
  type        = string
}

variable "iam_policy_arn_CloudWatchAgentServerPolicy" {
  description = "IAM policy CloudWatchAgentServerPolicy ARN to attach to the role"
  type        = string
}

variable "iam_policy_arn_customCloudWatchLogPolicy" {
  description = "IAM policy CloudWatchAgentServerPolicy ARN to attach to the role"
  type        = string
}

variable "iam_policy_arn_customCloudWatchMetricsPolicy" {
  description = "IAM policy CloudWatchAgentServerPolicy ARN to attach to the role"
  type        = string
}

variable "iam_policy_arn_customEc2UserS3Policy" {
  description = "IAM policy custom S3 ARN to attach to the role"
  type        = string
}

variable "iam_policy_arn_customEc2UserSNSPolicy" {
  description = "ARN SNS IAM custom policy for the EC2 user to attach to the role"
  type        = string
}

variable "iam_policy_arn_customLambdaRDSAccessPolicy" {
  description = "ARN Lambda IAM custom policy for the AWS Lambda Function to access RDS to attach to the role"
  type        = string
}

variable "iam_policy_arn_customLambdaSNSAccessPolicy" {
  description = "ARN Lambda IAM custom policy for the AWS Lambda Function to access SNS to attach to the role"
  type        = string
}

variable "iam_policy_arn_AWSLambdaVPCAccessExecutionRole" {
  description = "Provides minimum permissions for a Lambda function to execute while accessing a resource within a VPC - create, describe, delete network interfaces and write permissions to CloudWatch Logs."
  type        = string
}
