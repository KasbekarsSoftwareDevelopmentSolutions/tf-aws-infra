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
variable "security_group_name" {
  description = "The name of the application security group"
  type        = string # Name for the security group that will be created
}

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
