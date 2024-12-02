# File orgInfra/modules/lambda/main.tf
resource "aws_lambda_function" "verification_service_lambda" {
  function_name = var.lambda_function_name
  handler       = var.lambda_function_handler
  runtime       = var.lambda_function_runtime_env
  architectures = [var.lambda_architecture]
  role          = var.iam_lambda_role_arn

  s3_bucket = var.s3_lambda_bin_bucket_name
  s3_key    = var.s3_lambda_bin_key

  timeout = 30

  environment {
    variables = {
      MAILGUN_API_KEY = var.mailgun_api_key
      MAILGUN_DOMAIN  = var.mailgun_domain
      BASE_URL        = var.base_url
    }
  }

  vpc_config {
    security_group_ids = [var.rds_security_group_id]
    subnet_ids         = var.private_subnet_ids
  }
}
