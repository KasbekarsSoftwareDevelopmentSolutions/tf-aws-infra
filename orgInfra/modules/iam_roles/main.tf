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
    AmazonSSMManagedInstanceCore  = var.iam_policy_arn_AmazonSSMManagedInstanceCore
    CloudWatchAgentServerPolicy   = var.iam_policy_arn_CloudWatchAgentServerPolicy
    customCloudWatchLogPolicy     = var.iam_policy_arn_customCloudWatchLogPolicy
    customCloudWatchMetricsPolicy = var.iam_policy_arn_customCloudWatchMetricsPolicy
    customEc2UserS3Policy         = var.iam_policy_arn_customEc2UserS3Policy
  }

  role       = aws_iam_role.this.name
  policy_arn = each.value
}

resource "aws_iam_instance_profile" "this" {
  name = "${var.iam_role_name}_profile"
  role = aws_iam_role.this.name
}
