# File orgInfra/modules/iam_roles/variables.tf

variable "iam_role_name" {
  description = "The name of the IAM role"
  type        = string
}

variable "iam_policy_arns" {
  description = "List of policy ARNs to attach to the IAM role"
  type        = list(string)
}

variable "trusted_aws_principal" {
  description = "The AWS principal (user or service) allowed to assume this IAM role"
  type        = string
}
