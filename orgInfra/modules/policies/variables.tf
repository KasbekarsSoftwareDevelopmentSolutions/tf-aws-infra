# File orgInfra/modules/policies/variables.tf

variable "bucket_name" {
  description = "Name of the S3 Bucket to be attached to Custom S3 Access Policy."
  type        = string
}

variable "sns_topic_arn" {
  description = "The ARN of the SNS Topic."
  type        = string
}

variable "rds_arn" {
  description = "The ARN of the AWS database RDS."
  type        = string
}
