# File orgInfra/modules/sns/main.tf

resource "aws_sns_topic" "app_sns_topic" {
  name = var.sns_topic_name
  tags = {
    Environment = "Development"
  }
}
