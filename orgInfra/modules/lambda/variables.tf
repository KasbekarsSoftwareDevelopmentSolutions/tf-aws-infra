# File orgInfra/modules/lambda/variables.tf

variable "lambda_function_name" {
  description = "The of the AWS Lambda Function."
  type        = string
}

variable "lambda_function_handler" {
  description = "The name od the AWS Lambda Handler file."
  type        = string
}

variable "lambda_function_runtime_env" {
  description = "The AWS Lambda runtime. On which programming language the lamdba function will run the give binary file."
  type        = string
}

variable "lambda_architecture" {
  description = "The architecture for the Lambda function. Supported values are x86_64 or arm64."
  type        = string
}

variable "rds_security_group_id" {
  description = "The RDS Database security group's id."
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "iam_lambda_role_arn" {
  description = "The ARN of the IAM Lambda role, to be attached to the function."
  type        = string
}

variable "s3_lambda_bin_bucket_name" {
  description = "The name of the s3 bucket where the service binaries are stored."
  type        = string
}

variable "s3_lambda_bin_key" {
  description = "The key of the s3 bucket where the service binaries are stored."
  type        = string
}

# variable "mailgun_api_key" {
#   description = "The MailGun account API Key."
#   type        = string
# }

variable "mailgun_domain" {
  description = "The mailgun domain to be used by the service, to send emails."
  type        = string
}

variable "base_url" {
  description = "The base URL for the application."
  type        = string
}

variable "lambda_email_credentials_secret_arn" {
  description = "Secrets Manager ARN for Lambda email credentials"
  type        = string
}
