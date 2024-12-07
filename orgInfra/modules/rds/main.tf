# File orgInfra/modules/rds/main.tf

data "aws_secretsmanager_secret_version" "rds_credentials" {
  secret_id = var.rds_credentials_secret_arn
}

locals {
  rds_credentials = jsondecode(data.aws_secretsmanager_secret_version.rds_credentials.secret_string)
}

resource "aws_db_instance" "rds_instance" {
  allocated_storage      = var.rds_allocated_storage
  storage_type           = var.rds_storage_type
  engine                 = var.db_engine
  instance_class         = var.rds_instance_class
  db_name                = local.rds_credentials["db_name"]
  username               = local.rds_credentials["username"]
  password               = local.rds_credentials["password"]
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = var.rds_security_group_ids
  publicly_accessible    = var.publicly_accessible
  multi_az               = var.multi_az
  identifier             = var.db_instance_identifier
  parameter_group_name   = aws_db_parameter_group.rds_param_group.name

  skip_final_snapshot = true

  tags = {
    Name = "${var.db_instance_identifier}-rds-instance"
  }
}

# Subnet Group for RDS
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = var.rds_subnet_group_name
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = var.rds_subnet_group_name
  }
}

# RDS Parameter Group
resource "aws_db_parameter_group" "rds_param_group" {
  name        = var.rds_param_group_name
  family      = var.rds_param_group_family
  description = "Parameter group for ${var.db_instance_identifier} RDS instance"

  parameter {
    name  = var.db_param_name
    value = var.db_param_value
  }
}
