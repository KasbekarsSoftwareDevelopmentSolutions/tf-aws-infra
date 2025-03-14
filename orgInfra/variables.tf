# File orgInfra/variables.tf

# AWS Provider Configuration
variable "aws_profile" {
  description = "The AWS CLI profile to use"
  type        = string
}

variable "aws_region" {
  description = "The AWS region to create the VPC and its resources in"
  type        = string
}

# VPC Configuration
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string # e.g., "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "cloud-vpc-CSYE6225" # Default name for the VPC
}

# Subnet Configuration
variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for the public subnets"
  type        = list(string) # e.g., ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for the private subnets"
  type        = list(string) # e.g., ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zones" {
  description = "List of availability zones to distribute subnets across"
  type        = list(string) # e.g., ["us-east-1a", "us-east-1b", "us-east-1c"]
}

# EC2 Instance Configuration
variable "ami_id" {
  description = "The AMI ID for the custom image"
  type        = string # The Amazon Machine Image ID for the EC2 instance
}

variable "instance_type" {
  description = "The type of instance to create"
  type        = string
  default     = "t2.micro" # Default instance type; adjust as necessary based on your needs
}

variable "key_pair_name" {
  description = "The name of the key pair to use for SSH access"
  type        = string # Key pair name to allow SSH access to the EC2 instance
}

# Application Security Group Configuration
variable "app_securitygroup_description" {
  description = "A description for the application security group"
  type        = string
  default     = "Application Security Group for web applications" # Default description for the security group
}

# variable "ingress_cidrs" {
#   description = "List of CIDR blocks for ingress rules of the security group"
#   type        = list(string)
#   default     = ["0.0.0.0/0"] # Default to allow traffic from anywhere; adjust as necessary for security
# }

variable "ssh_port" {
  description = "The port on which ssh connection is allowed to instance."
  type        = number
}

variable "application_port" {
  description = "The port on which the application expects and accepts the request traffic"
  type        = number
}


# RDS Configuration
variable "rds_master_username" {
  description = "The master username for the RDS instance"
  type        = string
}

variable "rds_master_password" {
  description = "The master password for the RDS instance"
  type        = string
}

variable "db_engine" {
  description = "The database engine for the RDS instance"
  type        = string
  default     = "mysql" # Change to "mariadb" or "postgres" if needed
}

variable "rds_allocated_storage" {
  description = "Allocated storage for the RDS instance"
  type        = number
  default     = 20
}

variable "rds_storage_type" {
  description = "Storage type for the RDS instance"
  type        = string
  default     = "gp2"
}

variable "rds_instance_class" {
  description = "Instance class for the RDS instance"
  type        = string
  default     = "db.t3.micro"
}

variable "publicly_accessible" {
  description = "Whether the RDS instance is publicly accessible"
  type        = bool
  default     = false
}

variable "multi_az" {
  description = "Whether to deploy the RDS instance in multiple Availability Zones"
  type        = bool
  default     = false
}

variable "db_name" {
  description = "The name of the database to create"
  type        = string
  default     = "csye6225"
}

variable "db_instance_identifier" {
  description = "Identifier for the RDS instance"
  type        = string
  default     = "csye6225"
}

variable "rds_subnet_group_name" {
  description = "Name for the RDS subnet group"
  type        = string
  default     = "csye6225-rds-subnet-group"
}

variable "rds_param_group_name" {
  description = "Name for the RDS parameter group"
  type        = string
  default     = "csye6225-rds-parameter-group"
}

variable "rds_param_group_family" {
  description = "Family of the RDS parameter group"
  type        = string
  default     = "mysql8.0"
}

variable "db_param_name" {
  description = "The name of the database parameter"
  type        = string
  default     = "character_set_server"
}

variable "db_param_value" {
  description = "The value of the database parameter"
  type        = string
  default     = "utf8mb4"
}

# RDS Security Group Configuration
variable "allowed_cidr_blocks" {
  description = "List of allowed CIDR blocks for the RDS security group"
  type        = list(string)
  default     = ["10.0.0.0/16"] # Replace with your VPC CIDR block
}

# S3 Bucket Configuration
variable "bucket_prefix" {
  description = "The name of the S3 bucket, typically a UUID for uniqueness"
  type        = string
}

variable "verification_service_bin_path" {
  description = "The file path to the binaries of the service to be deployed using AWS Lambda Function."
  type        = string
}

variable "verification_service_java_bin_key" {
  description = "The S3 bucket key where the verification serivce binaries will be present."
}

variable "transition_days" {
  description = "Number of days before transitioning to STANDARD_IA storage class"
  type        = number
  default     = 30
}

variable "enable_force_destroy" {
  description = "Force destroy S3 bucket even if not empty"
  type        = bool
  default     = false
}

variable "ec2_user_access_key" {
  description = "Access key of the ec2_user."
  type        = string
}

variable "ec2_user_secret_access_key" {
  description = "Secret access key of the ec2_user."
  type        = string
}

variable "domain_name" {
  description = "My Domain Name"
  type        = string
}

# IAM Roles Configurations
variable "iam_role_name" {
  description = "The name of the IAM role for EC2 CloudWatch Agent setup"
  type        = string
}

variable "iam_lambda_role_name" {
  description = "The name of the IAM role for the AWS Lambda to access the SNS and RDS."
  type        = string
}

variable "iam_policy_AmazonSSMManagedInstanceCore_arn" {
  description = "IAM policy AmazonSSMManagedInstanceCore ARN to attach to the role"
  type        = string
}

variable "iam_policy_CloudWatchAgentServerPolicy_arn" {
  description = "IAM policy CloudWatchAgentServerPolicy ARN to attach to the role"
  type        = string
}

variable "iam_policy_AWSLambdaVPCAccessExecutionRole_arn" {
  description = "Provides minimum permissions for a Lambda function to execute while accessing a resource within a VPC - create, describe, delete network interfaces and write permissions to CloudWatch Logs."
  type        = string
}

variable "trusted_aws_principal" {
  description = "AWS principal allowed to assume this IAM role"
  type        = string
}

# Load Balancer Configurations
variable "application_targetgroup_protocol" {
  description = "Determines how the Load Balancer forwards requests to the backend targets."
  type        = string
}
variable "listener_port_lb" {
  description = "The port on the load balancer will expect traffic."
  type        = number
}

variable "listener_protocol_lb" {
  description = "The protocol on the load balancer will expect traffic."
  type        = string
}

variable "healthcheck_interval" {
  description = "The interval (in seconds) between health checks for the target group."
  type        = number
}

# Auto Scalling Group Configurations
variable "inst_min_size" {
  description = "The minimum number of instances that the Auto Scaling Group should maintain at all times."
  type        = number
}

variable "inst_max_size" {
  description = "The maximum number of instances that the Auto Scaling Group can scale up to."
  type        = number
}

variable "inst_desired_capacity" {
  description = "The initial number of instances the Auto Scaling Group will launch when it is first created or updated."
  type        = number
}

variable "inst_environment" {
  description = "Ec2 Instance Environment to be launched in."
  type        = string
}

variable "inst_cooldown_period" {
  description = "The cooldown field in an Auto Scaling configuration defines the amount of time (in seconds) that the Auto Scaling Group (ASG) waits before taking another scaling action after a previous scaling activity."
  type        = number
}

variable "upscale_cpu_utilization_percent" {
  description = "The ASG will monitor the average CPU utilization of all instances in the group and adjust the number of instances to keep the CPU utilization close to this target value."
  type        = number
}

variable "downscale_cpu_utilization_percent" {
  description = "The ASG will monitor the average CPU utilization of all instances in the group and adjust the number of instances to keep the CPU utilization close to this target value."
  type        = number
}

# SNS Configurations
variable "name_of_sns_topic" {
  description = "The name of the AWS SNS topics."
}

# Aws Lambda Function configurations
variable "lambda_function_name" {
  description = "The of the AWS Lambda Function."
  type        = string
}

variable "lambda_function_handler" {
  description = "The name od the AWS Lambda Handler file."
  type        = string
}

variable "lambda_function_runtime_env" {
  description = "The AWS Lambda runtime. On which programming language the lamdba function will run the give binary file."
  type        = string
}

variable "lambda_function_architecture" {
  description = "The architecture for the Lambda function. Supported values are x86_64 or arm64."
  type        = string
}

variable "mailgun_api_key" {
  description = "The MailGun account API Key."
  type        = string
}

variable "mailgun_domain" {
  description = "The mailgun domain to be used by the service, to send emails."
  type        = string
}

variable "base_url" {
  description = "The base URL for the application."
  type        = string
}

variable "acm_certificate_arn" {
  description = "The ARN od SSL certificate"
  type        = string
}
