# File orgInfra/modules/s3_bucket_lifecyclepolicy/variables.tf

variable "bucket_id" {
  description = "ID of the S3 bucket to attach the lifecycle policy to"
  type        = string
}

variable "transition_days" {
  description = "Number of days before transitioning to STANDARD_IA storage class"
  type        = number
}
