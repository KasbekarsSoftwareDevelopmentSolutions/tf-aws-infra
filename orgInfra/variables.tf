# AWS Provider Configuration
variable "aws_profile" {
  description = "The AWS CLI profile to use"
  type        = string
  default     = "aadityaDevelopmentUser" # Default profile for AWS CLI authentication
}

variable "aws_region" {
  description = "The AWS region to create the VPC and its resources in"
  type        = string
  default     = "us-east-1" # Default AWS region for resource deployment
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

# Security Group Configuration
variable "security_group_description" {
  description = "A description for the application security group"
  type        = string
  default     = "Application Security Group for web applications" # Default description for the security group
}

variable "ingress_cidrs" {
  description = "List of CIDR blocks for ingress rules of the security group"
  type        = list(string)
  default     = ["0.0.0.0/0"] # Default to allow traffic from anywhere; adjust as necessary for security
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
