# File orgInfra/modules/security_groups_rds/variables.tf

variable "vpc_id" {
  description = "The ID of the VPC where the security group will be created"
  type        = string
}

variable "rds_security_group_name" {
  description = "The name of the security group"
  type        = string
}

variable "security_group_id" {
  description = "The ID of the RDS security group"
  type        = string
}

# variable "allowed_cidr_blocks" {
#   description = "List of CIDR blocks that can access the RDS instance"
#   type        = list(string)
#   default     = ["10.0.0.0/16"] # Replace with your private network range
# }
