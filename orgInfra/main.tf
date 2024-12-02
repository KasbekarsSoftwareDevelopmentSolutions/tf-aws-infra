# File orgInfra/main.tf
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
  vpc_name = var.vpc_name
}

# Call the Subnets module
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

# Call the Route Tables module
module "route_tables" {
  source              = "./modules/route_tables"
  vpc_id              = module.vpc.vpc_id
  public_subnets      = module.subnets.public_subnet_ids
  private_subnets     = module.subnets.private_subnet_ids
  internet_gateway_id = module.internet_gateway.igw_id
  vpc_name            = var.vpc_name

  depends_on = [module.vpc, module.subnets, module.internet_gateway]
}

# Call the Network Access Gateway module
module "nat" {
  source                 = "./modules/nat"
  nat_gateway_name       = "${var.vpc_name}-nat"
  public_subnet_id       = module.subnets.public_subnet_ids[0]
  eip_name               = "${var.vpc_name}-eip"
  private_route_table_id = module.route_tables.private_route_table_id

  depends_on = [module.subnets, module.route_tables]
}

# Call the S3 Bucket module
module "s3_bucket" {
  source               = "./modules/s3_bucket"
  bucket_prefix        = var.bucket_prefix
  enable_force_destroy = var.enable_force_destroy
  service_file_path    = var.verification_service_bin_path
  java_binaries_key    = var.verification_service_java_bin_key
}

# Call the S3 Bucket Lifecycle module
module "s3_bucket_lifecycle" {
  source          = "./modules/s3_bucket_lifecyclepolicy"
  bucket_id       = module.s3_bucket.bucket_id
  transition_days = var.transition_days

  depends_on = [module.s3_bucket]
}

# Call the IAM Policies Configuration module
module "policies" {
  source        = "./modules/policies"
  bucket_name   = module.s3_bucket.bucket_name
  sns_topic_arn = module.sns.sns_topic_arn
  rds_arn       = module.rds.rds_arn

  depends_on = [module.s3_bucket, module.sns, module.rds]
}

# Call the IAM Roles Configuration module
module "iam_roles" {
  source                                         = "./modules/iam_roles"
  iam_role_name                                  = var.iam_role_name
  iam_lambda_role_name                           = var.iam_lambda_role_name
  iam_policy_arn_AmazonSSMManagedInstanceCore    = var.iam_policy_AmazonSSMManagedInstanceCore_arn
  iam_policy_arn_CloudWatchAgentServerPolicy     = var.iam_policy_CloudWatchAgentServerPolicy_arn
  iam_policy_arn_customCloudWatchLogPolicy       = module.policies.custom_cloudwatch_log_policy_arn
  iam_policy_arn_customCloudWatchMetricsPolicy   = module.policies.custom_cloudwatch_metrics_policy_arn
  iam_policy_arn_customEc2UserS3Policy           = module.policies.custom_ec2user_s3_policy_arn
  iam_policy_arn_customEc2UserSNSPolicy          = module.policies.custom_ec2user_sns_publish_policy_arn
  iam_policy_arn_customLambdaRDSAccessPolicy     = module.policies.custom_lambda_rds_access_policy_arn
  iam_policy_arn_customLambdaSNSAccessPolicy     = module.policies.custom_lambda_sns_access_policy_arn
  iam_policy_arn_AWSLambdaVPCAccessExecutionRole = var.iam_policy_AWSLambdaVPCAccessExecutionRole_arn
  trusted_aws_principal                          = var.trusted_aws_principal

  depends_on = [module.policies]
}

# Call the Load Balancer Security Group module
module "load_balancer_security_group" {
  source                       = "./modules/security_groups_loadbalancer"
  vpc_id                       = module.vpc.vpc_id
  lb_securitygroup_name        = "${var.vpc_name}-lb-sg"
  lb_securitygroup_description = "Load Balancer Security Group."

  depends_on = [module.vpc]
}

# Call the Application Security Group module
# module "security_group" {
#   source                        = "./modules/security_groups"
#   vpc_id                        = module.vpc.vpc_id # Reference the VPC ID from the VPC module
#   app_securitygroup_name        = "${var.vpc_name}-app-sg"
#   app_securitygroup_description = "Application Security Group for web applications"
#   ingress_cidrs                 = ["0.0.0.0/0"]

#   depends_on = [module.vpc]
# }
module "security_group" {
  source                        = "./modules/security_groups"
  vpc_id                        = module.vpc.vpc_id
  app_securitygroup_name        = "${var.vpc_name}-app-sg"
  app_securitygroup_description = var.app_securitygroup_description
  ssh_port                      = var.ssh_port
  application_port              = var.application_port
  lb_securitygroup_id           = module.load_balancer_security_group.lb_security_group_id

  depends_on = [module.vpc, module.load_balancer_security_group]
}

# Call the RDS Security Group module
module "rds_security_group" {
  source                  = "./modules/security_groups_rds"
  vpc_id                  = module.vpc.vpc_id
  rds_security_group_name = "${var.vpc_name}-rds-sg"
  security_group_id       = module.security_group.security_group_id

  depends_on = [module.vpc, module.security_group]
}

# Call the RDS module
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
# Call the Load Balancer module
module "load_balancer" {
  source                   = "./modules/load_balancer"
  load_balancer_name       = "${var.vpc_name}-app-lb"
  loadbalancer_type        = "application"
  security_group_ids       = [module.load_balancer_security_group.lb_security_group_id]
  subnet_ids               = module.subnets.public_subnet_ids
  vpc_id                   = module.vpc.vpc_id
  app_targetgroup_name     = "${var.vpc_name}-tg"
  app_targetgroup_port     = var.application_port
  app_targetgroup_protocol = "HTTP"
  listener_port            = var.listener_port_lb
  listener_protocol        = "HTTP"
  app_healthcheck_interval = var.healthcheck_interval

  depends_on = [module.vpc, module.subnets, module.load_balancer_security_group]
}

# Call the Aws Lambda Security Group Module
module "security_groups_lambda" {
  source                     = "./modules/security_groups_lambda"
  lambda_security_group_name = "${var.vpc_name}-lambda-sg"
  vpc_id                     = module.vpc.vpc_id

  depends_on = [module.vpc]
}

# Call the Aws SNS module
module "sns" {
  source         = "./modules/sns"
  sns_topic_name = var.name_of_sns_topic
}

# Call the Aws Lambda Function Module
module "lambda" {
  source                      = "./modules/lambda"
  lambda_function_name        = var.lambda_function_name
  lambda_function_handler     = var.lambda_function_handler
  lambda_function_runtime_env = var.lambda_function_runtime_env
  lambda_architecture         = var.lambda_function_architecture
  iam_lambda_role_arn         = module.iam_roles.iam_lambda_role_arn
  rds_security_group_id       = module.rds_security_group.rds_security_group_id
  s3_lambda_bin_bucket_name   = module.s3_bucket.bucket_name
  s3_lambda_bin_key           = module.s3_bucket.java_binaries_key
  mailgun_api_key             = var.mailgun_api_key
  mailgun_domain              = var.mailgun_domain
  private_subnet_ids          = module.subnets.private_subnet_ids
  base_url                    = var.base_url

  depends_on = [module.iam_roles, module.rds_security_group, module.s3_bucket, module.subnets]
}

module "subscriptions_permissions" {
  source              = "./modules/subscriptions_permissions"
  lambda_function_arn = module.lambda.verification_service_lambda_arn
  sns_topic_arn       = module.sns.sns_topic_arn

  depends_on = [module.lambda, module.sns]
}

# Call the EC2 module
# module "ec2" {
#   source             = "./modules/ec2"
#   ami_id             = var.ami_id
#   instance_type      = var.instance_type
#   subnet_id          = module.subnets.public_subnet_ids[0]
#   instance_name      = "${var.vpc_name}-instance"
#   security_group_ids = [module.security_group.security_group_id]
#   key_pair_name      = var.key_pair_name

#   iam_instance_profile = module.iam_roles.iam_instance_profile_name

#   # Pass the RDS outputs
#   rds_endpoint        = module.rds.rds_endpoint
#   rds_port            = module.rds.rds_port
#   db_name             = module.rds.db_name
#   rds_master_username = module.rds.rds_master_username
#   rds_master_password = var.rds_master_password
#   bucket_name         = module.s3_bucket.bucket_name
#   access_key          = var.ec2_user_access_key
#   secret_access_key   = var.ec2_user_secret_access_key

#   depends_on = [module.subnets, module.rds, module.s3_bucket]
# }

# Call the EC2 Launch Template
module "launch_template" {
  source               = "./modules/launch_template"
  launch_template_name = "csye6225_asg"
  ami_id               = var.ami_id
  instance_type        = var.instance_type
  key_pair_name        = var.key_pair_name
  security_group_ids   = [module.security_group.security_group_id]
  iam_instance_profile = module.iam_roles.iam_instance_profile_name
  rds_endpoint         = module.rds.rds_endpoint
  rds_master_username  = module.rds.rds_master_username
  rds_master_password  = var.rds_master_password
  db_name              = module.rds.db_name
  bucket_name          = module.s3_bucket.bucket_name
  cloud_sns_topic_arn  = module.sns.sns_topic_arn
  access_key           = var.ec2_user_access_key
  secret_access_key    = var.ec2_user_secret_access_key

  depends_on = [module.security_group, module.iam_roles, module.rds, module.s3_bucket]
}

# Call the Auto Sacling Module
module "autoscaling" {
  source                            = "./modules/autoscaling"
  launch_template_id                = module.launch_template.launch_template_id
  subnet_ids                        = module.subnets.public_subnet_ids
  instance_name                     = "${var.vpc_name}-app-instance"
  min_size                          = var.inst_min_size
  max_size                          = var.inst_max_size
  desired_capacity                  = var.inst_desired_capacity
  target_group_arns                 = [module.load_balancer.target_group_arn]
  environment                       = var.inst_environment
  cooldown                          = var.inst_cooldown_period
  upscale_cpu_utilization_percent   = var.upscale_cpu_utilization_percent
  downscale_cpu_utilization_percent = var.downscale_cpu_utilization_percent

  depends_on = [module.launch_template, module.subnets, module.load_balancer]
}

# Call the Route53 Module
# module "route_53" {
#   source        = "./modules/route_53"
#   zone_id       = data.aws_route53_zone.selected.zone_id
#   zone_name     = data.aws_route53_zone.selected.name
#   ec2_public_ip = module.ec2.public_ip
# }

# Call the Route 53 module
module "route_53" {
  source                 = "./modules/route_53"
  zone_id                = data.aws_route53_zone.selected.zone_id
  zone_name              = data.aws_route53_zone.selected.name
  load_balancer_dns_name = module.load_balancer.load_balancer_dns_name
  load_balancer_zone_id  = module.load_balancer.load_balancer_zone_id

  depends_on = [module.load_balancer]
}
