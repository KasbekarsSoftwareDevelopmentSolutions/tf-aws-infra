# File orgInfra/modules/iam_roles/variables.tf

variable "iam_role_name" {
  description = "The name of the IAM role"
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
  description = "IAM policy CloudWatchAgentServerPolicy ARN to attach to the role"
  type        = string
}
