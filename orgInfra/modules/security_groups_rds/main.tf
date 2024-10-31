# File orgInfra/modules/security_groups_rds/main.tf

resource "aws_security_group" "rds_security_group" {
  name        = var.rds_security_group_name
  description = "Security group for the RDS instance"
  vpc_id      = var.vpc_id

  # Inbound access for MySQL (default port 3306)
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.rds_security_group_name
  }
}
