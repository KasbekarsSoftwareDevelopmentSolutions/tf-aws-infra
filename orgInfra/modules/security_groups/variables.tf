variable "vpc_id" {
  description = "The ID of the VPC where the security group will be created"
  type        = string
}

variable "security_group_name" {
  description = "The name of the security group"
  type        = string
}

variable "security_group_description" {
  description = "A description for the security group"
  type        = string
  default     = "Security group for EC2 instances hosting web applications"
}

variable "ingress_cidrs" {
  description = "List of CIDR blocks for ingress rules"
  type        = list(string)
  default     = ["0.0.0.0/0"] # Allow traffic from anywhere by default
}
