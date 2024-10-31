# File orgInfra/modules/s3_bucket/variables.tf

variable "bucket_prefix" {
  description = "Prefix for the S3 bucket name"
  type        = string
}

variable "enable_force_destroy" {
  description = "Force destroy S3 bucket even if not empty"
  type        = bool
}
