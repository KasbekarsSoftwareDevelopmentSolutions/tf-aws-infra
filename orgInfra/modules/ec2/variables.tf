# File orgInfra/modules/ec2/variables.tf

variable "ami_id" {
  description = "The AMI ID for the custom image"
  type        = string
  default     = "ami-0a3cbb029b27bb2c4"
}

variable "instance_type" {
  description = "The type of instance to create"
  type        = string
  default     = "t2.small" # Default instance type, adjust as necessary
}

variable "subnet_id" {
  description = "The ID of the subnet to launch the instance in"
  type        = string
}

variable "instance_name" {
  description = "The name of the EC2 instance"
  type        = string
}

variable "security_group_ids" {
  description = "The security group IDs to associate with the instance"
  type        = list(string)
}

variable "key_pair_name" {
  description = "The name of the key pair to use for SSH access"
  type        = string
}

variable "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  type        = string
}

variable "rds_port" {
  description = "The port on which the RDS instance is listening"
  type        = number
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "rds_master_username" {
  description = "The master username for the RDS instance"
  type        = string
}

variable "rds_master_password" {
  description = "The master password for the RDS instance"
  type        = string
}

variable "bucket_name" {
  description = "S3 Bucket name."
  type        = string
}

variable "access_key" {
  description = "Access Key for the ec2_user."
  type        = string
}

variable "secret_access_key" {
  description = "Secret access key for the ec2_user."
  type        = string
}
