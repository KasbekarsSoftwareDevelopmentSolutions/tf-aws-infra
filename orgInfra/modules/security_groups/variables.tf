# File orgInfra/modules/security_groups/variables.tf

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "app_securitygroup_name" {
  description = "Name of the Application Security Group"
  type        = string
}

variable "app_securitygroup_description" {
  description = "Description of the Application Security Group"
  type        = string
  default     = "Security group for the web application instances"
}

# variable "ingress_cidrs" {
#   description = "List of CIDR blocks for ingress rules"
#   type        = list(string)
#   default     = ["0.0.0.0/0"] # Allow traffic from anywhere by default
# }

variable "lb_securitygroup_id" {
  description = "ID of the Load Balancer Security Group"
  type        = string
}

variable "ssh_port" {
  description = "Mention the ssh access port number. Usually it is 22."
  type        = number
}

variable "application_port" {
  description = "Mention the port on which the application will be accepting traffic."
  type        = number
}
