# File orgInfra/modules/lambda/outputs.tf

output "verification_service_lambda_arn" {
  value = aws_lambda_function.verification_service_lambda.arn
}
