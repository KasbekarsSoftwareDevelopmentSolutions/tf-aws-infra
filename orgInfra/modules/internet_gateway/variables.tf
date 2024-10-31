# File orgInfra/modules/internet_gateway/variables.tf

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "my_vpc"
}
