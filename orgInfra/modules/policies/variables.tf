# File orgInfra/modules/policies/variables.tf

variable "bucket_name" {
  description = "Name of the S3 Bucket to be attached to Custom S3 Access Policy."
  type        = string
}
