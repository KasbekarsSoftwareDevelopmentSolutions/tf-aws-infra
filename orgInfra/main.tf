# File orgInfra/main.tf To check if the workflow setup works.
terraform {
  required_version = ">= 1.5.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

data "aws_route53_zone" "selected" {
  name = var.domain_name
}

# Call the VPC module
module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
}

# Call the subnets module
module "subnets" {
  source               = "./modules/subnets"
  vpc_id               = module.vpc.vpc_id
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  vpc_name             = var.vpc_name

  depends_on = [module.vpc]
}

# Call the Internet Gateway module
module "internet_gateway" {
  source   = "./modules/internet_gateway"
  vpc_id   = module.vpc.vpc_id
  vpc_name = var.vpc_name

  depends_on = [module.vpc]
}

# Call the route tables module
module "route_tables" {
  source              = "./modules/route_tables"
  vpc_id              = module.vpc.vpc_id
  public_subnets      = module.subnets.public_subnet_ids
  private_subnets     = module.subnets.private_subnet_ids
  internet_gateway_id = module.internet_gateway.igw_id
  vpc_name            = var.vpc_name

  depends_on = [module.vpc, module.subnets, module.internet_gateway]
}

# IAM Roles Configuration
module "iam_roles" {
  source                = "./modules/iam_roles"
  iam_role_name         = var.iam_role_name
  iam_policy_arns       = var.iam_policy_arns
  trusted_aws_principal = var.trusted_aws_principal
}

# Call the Security Group module
module "security_group" {
  source                     = "./modules/security_groups"
  vpc_id                     = module.vpc.vpc_id # Reference the VPC ID from the VPC module
  security_group_name        = "${var.vpc_name}-app-sg"
  security_group_description = "Application Security Group for web applications"
  ingress_cidrs              = ["0.0.0.0/0"] # Adjust CIDR blocks as necessary

  depends_on = [module.vpc]
}

module "rds_security_group" {
  source                  = "./modules/security_groups_rds"
  vpc_id                  = module.vpc.vpc_id
  rds_security_group_name = "${var.vpc_name}-rds-sg"
  security_group_id       = module.security_group.security_group_id

  depends_on = [module.vpc]
}

module "s3_bucket" {
  source               = "./modules/s3_bucket"
  bucket_prefix        = var.bucket_prefix
  enable_force_destroy = var.enable_force_destroy
}

module "s3_bucket_lifecycle" {
  source          = "./modules/s3_bucket_lifecyclepolicy"
  bucket_id       = module.s3_bucket.bucket_id
  transition_days = var.transition_days

  depends_on = [module.s3_bucket]
}

module "rds" {
  source                 = "./modules/rds"
  rds_master_username    = var.rds_master_username
  rds_master_password    = var.rds_master_password
  private_subnet_ids     = module.subnets.private_subnet_ids
  rds_allocated_storage  = var.rds_allocated_storage
  rds_storage_type       = var.rds_storage_type
  rds_instance_class     = var.rds_instance_class
  publicly_accessible    = var.publicly_accessible
  multi_az               = var.multi_az
  db_name                = var.db_name
  db_instance_identifier = var.db_instance_identifier
  rds_subnet_group_name  = var.rds_subnet_group_name
  rds_param_group_name   = var.rds_param_group_name
  rds_param_group_family = var.rds_param_group_family
  db_param_name          = var.db_param_name
  db_param_value         = var.db_param_value
  rds_security_group_ids = [module.rds_security_group.rds_security_group_id]

  depends_on = [module.subnets, module.rds_security_group]
}

# Call the EC2 module
module "ec2" {
  source             = "./modules/ec2"
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  subnet_id          = module.subnets.public_subnet_ids[0]
  instance_name      = "${var.vpc_name}-instance"
  security_group_ids = [module.security_group.security_group_id]
  key_pair_name      = var.key_pair_name

  iam_instance_profile = module.iam_roles.iam_instance_profile_name

  # Pass the RDS outputs
  rds_endpoint        = module.rds.rds_endpoint
  rds_port            = module.rds.rds_port
  db_name             = module.rds.db_name
  rds_master_username = module.rds.rds_master_username
  rds_master_password = var.rds_master_password
  bucket_name         = module.s3_bucket.bucket_name
  access_key          = var.ec2_user_access_key
  secret_access_key   = var.ec2_user_secret_access_key

  depends_on = [module.subnets, module.rds, module.s3_bucket]
}

module "route_53" {
  source        = "./modules/route_53"
  zone_id       = data.aws_route53_zone.selected.zone_id
  zone_name     = data.aws_route53_zone.selected.name
  ec2_public_ip = module.ec2.public_ip
}
