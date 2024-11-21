# File orgInfra/modules/security_groups_lambda/variables.tf

variable "lambda_security_group_name" {
  description = "Name for the Security Group of Aws Lambda Function."
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}
