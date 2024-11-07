# File orgInfra/modules/policies/main.tf

# Custom CloudWatch Log Policy
resource "aws_iam_policy" "custom_cloudwatch_log_policy" {
  name = "custom_CloudWatch_Log_Policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ],
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

# Custom CloudWatch Metrics Policy
resource "aws_iam_policy" "custom_cloudwatch_metrics_policy" {
  name = "custom_CloudWatch_Metrics_Policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "cloudwatch:PutMetricData",
          "cloudwatch:GetMetricStatistics",
          "cloudwatch:ListMetrics"
        ],
        Resource = "*"
      }
    ]
  })
}

# Custom S3 Policy
resource "aws_iam_policy" "custom_ec2user_s3_policy" {
  name = "custom_ec2User_S3_Policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ],
        "Resource" : [
          "arn:aws:s3:::${var.bucket_name}",
          "arn:aws:s3:::${var.bucket_name}/*"
        ]
      }
    ]
  })
}
