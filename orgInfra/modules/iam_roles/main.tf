# File orgInfra/modules/iam_roles/main.tf

resource "aws_iam_role" "this" {
  name = var.iam_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = { Service = "ec2.amazonaws.com" },
        Action    = "sts:AssumeRole"
      },
      {
        Effect    = "Allow",
        Principal = { AWS = var.trusted_aws_principal },
        Action    = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  for_each = {
    AmazonSSMManagedInstanceCore     = var.iam_policy_arn_AmazonSSMManagedInstanceCore
    CloudWatchAgentServerPolicy      = var.iam_policy_arn_CloudWatchAgentServerPolicy
    customCloudWatchLogPolicy        = var.iam_policy_arn_customCloudWatchLogPolicy
    customCloudWatchMetricsPolicy    = var.iam_policy_arn_customCloudWatchMetricsPolicy
    customEc2UserS3Policy            = var.iam_policy_arn_customEc2UserS3Policy
    customEc2UserSNSPolicy           = var.iam_policy_arn_customEc2UserSNSPolicy
    customEc2SUserecretManagerPolicy = var.iam_policy_arn_customEc2SecretManagerAccessPolicy
  }

  role       = aws_iam_role.this.name
  policy_arn = each.value
}

resource "aws_iam_instance_profile" "this" {
  name = "${var.iam_role_name}_profile"
  role = aws_iam_role.this.name
}

resource "aws_iam_role" "lambda_execution_role" {
  name = var.iam_lambda_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "rds_policy_attachment" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = var.iam_policy_arn_customLambdaRDSAccessPolicy
}

resource "aws_iam_role_policy_attachment" "sns_policy_attachment" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = var.iam_policy_arn_customLambdaSNSAccessPolicy
}

resource "aws_iam_role_policy_attachment" "basic_execution_attachment" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = var.iam_policy_arn_AWSLambdaVPCAccessExecutionRole
}
