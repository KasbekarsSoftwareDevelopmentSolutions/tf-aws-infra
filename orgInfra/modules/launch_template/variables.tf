# File orgInfra/modules/launch_template/variables.tf

variable "launch_template_name" {
  description = "Name of the Launch Template"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instances"
  type        = string
}

variable "key_pair_name" {
  description = "Key pair name for the EC2 instances"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs for the EC2 instances"
  type        = list(string)
}

variable "iam_instance_profile" {
  description = "IAM instance profile for the EC2 instances"
  type        = string
}

variable "rds_endpoint" {
  description = "RDS endpoint for database connection"
  type        = string
}

# variable "rds_master_username" {
#   description = "Master username for the RDS instance"
#   type        = string
# }

# variable "rds_master_password" {
#   description = "Master password for the RDS instance"
#   type        = string
# }

# variable "db_name" {
#   description = "Database name"
#   type        = string
# }

# variable "bucket_name" {
#   description = "Name of the S3 bucket"
#   type        = string
# }

# variable "access_key" {
#   description = "AWS access key"
#   type        = string
# }

# variable "secret_access_key" {
#   description = "AWS secret access key"
#   type        = string
# }

variable "cloud_sns_topic_arn" {
  description = "The ARN of the SNS Topic on which messages are to be published."
  type        = string
}

variable "ec2_credentials_secret_arn" {
  description = "THE ARN of the EC2 Credentials stored in the Secret Manager"
  type        = string
}

variable "aws_region" {
  description = "The aws region in which the Ec2 is deployed."
  type        = string
}
