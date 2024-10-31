# File orgInfra/modules/s3_bucket/main.tf

resource "random_id" "s3_bucket_uuid" {
  byte_length = 8
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket        = "${var.bucket_prefix}-${random_id.s3_bucket_uuid.hex}"
  force_destroy = var.enable_force_destroy
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encrypt" {
  bucket = aws_s3_bucket.s3_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "my_private_bucket" {
  bucket                  = aws_s3_bucket.s3_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
