# File orgInfra/modules/kms/variables.tf

variable "db_name" {
  description = "Name of the RDS database"
  type        = string
}

variable "rds_master_username" {
  description = "Master username for the RDS instance"
  type        = string
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "ec2_access_key" {
  description = "Access key for EC2 CLI operations"
  type        = string
}

variable "ec2_secret_key" {
  description = "Secret key for EC2 CLI operations"
  type        = string
}

variable "mailgun_api_key" {
  description = "API key for the Mailgun email service"
  type        = string
}
