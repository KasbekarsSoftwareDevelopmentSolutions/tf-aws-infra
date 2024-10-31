# File orgInfra/modules/s3_bucket_lifecyclepolicy/main.tf

resource "aws_s3_bucket_lifecycle_configuration" "my_bucket_lifecycle" {
  bucket = var.bucket_id

  rule {
    id     = "transition-to-standard-ia"
    status = "Enabled"
    transition {
      days          = var.transition_days
      storage_class = "STANDARD_IA"
    }
  }
}
