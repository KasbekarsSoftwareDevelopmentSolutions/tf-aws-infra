# File orgInfra/modules/subscriptions_permissions/main.tf

resource "aws_sns_topic_subscription" "lambda_trigger" {
  topic_arn = var.sns_topic_arn
  protocol  = "lambda"
  endpoint  = var.lambda_function_arn
}

# Grant SNS Permission to Invoke Lambda
resource "aws_lambda_permission" "allow_sns_to_invoke_lambda" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_arn
  principal     = "sns.amazonaws.com"
  source_arn    = var.sns_topic_arn
}
