# File orgInfra/modules/nat/variables.tf

variable "public_subnet_id" {
  description = "The ID of the public subnet od the VPC"
  type        = string
}

variable "nat_gateway_name" {
  description = "The name of the network access gateway"
  type        = string
}

variable "eip_name" {
  description = "The name of the elatic IP"
  type        = string
}

variable "private_route_table_id" {
  description = "The ID of the private route table of the VPC."
  type        = string
}
