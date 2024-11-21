# File orgInfra/modules/security_groups_lambda/main.tf

resource "aws_security_group" "lambda_security_group" {
  name        = var.lambda_security_group_name
  description = "Allow Lambda to communicate with RDS"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
