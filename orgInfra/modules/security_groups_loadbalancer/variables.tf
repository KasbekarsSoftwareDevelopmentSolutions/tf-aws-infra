# File orgInfra/modules/security_groups_loadbalancer/variables.tf
variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "lb_securitygroup_name" {
  description = "Name of the Load Balancer Security Group"
  type        = string
}

variable "lb_securitygroup_description" {
  description = "Description of the Load Balancer Security Group"
  type        = string
  default     = "Security group for the Load Balancer"
}
