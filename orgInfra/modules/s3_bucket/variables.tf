# File orgInfra/modules/s3_bucket/variables.tf

variable "bucket_prefix" {
  description = "Prefix for the S3 bucket name"
  type        = string
}

variable "enable_force_destroy" {
  description = "Force destroy S3 bucket even if not empty"
  type        = bool
}

variable "service_file_path" {
  description = "The file path to the binaries of the service to be deployed using AWS Lambda Function."
  type        = string
}

variable "java_binaries_key" {
  description = "The Key in the s3 bucket where the service jar binaries are present."
  type        = string
}
