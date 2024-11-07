# File orgInfra/modules/route_53/variables.tf

variable "zone_id" {
  description = "Hosted Zone ID for my sub domain."
  type        = string
}

variable "zone_name" {
  description = "Hosted Zone Name for my sub domain."
  type        = string
}

# variable "ec2_public_ip" {
#   description = "Public of the Ec2 Instance."
#   type        = string
# }

variable "load_balancer_dns_name" {
  description = "DNS name of the load balancer"
  type        = string
}

variable "load_balancer_zone_id" {
  description = "Hosted zone ID of the load balancer"
  type        = string
}
