# File orgInfra/modules/route_tables/variables.tf

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "my_vpc"
}
