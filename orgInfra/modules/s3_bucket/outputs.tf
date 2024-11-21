# File orgInfra/modules/s3_bucket/outputs.tf

output "bucket_id" {
  value = aws_s3_bucket.s3_bucket.id
}

output "bucket_name" {
  value = aws_s3_bucket.s3_bucket.bucket
}

output "java_binaries_key" {
  value = aws_s3_object.lambda_jar.key
}
