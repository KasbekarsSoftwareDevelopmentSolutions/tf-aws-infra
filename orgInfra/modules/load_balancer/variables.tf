# File orgInfra/modules/load_balancer/variables.tf
variable "load_balancer_name" {
  description = "Name of the Load Balancer."
  type        = string
}

variable "loadbalancer_type" {
  description = "Type of Load Balancer to be provisioned."
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to attach to the Load Balancer."
  type        = list(string)
}

variable "subnet_ids" {
  description = "List of Subnet IDs for the Load Balancer."
  type        = list(string)
}

variable "vpc_id" {
  description = "ID of the VPC."
  type        = string
}

variable "app_targetgroup_name" {
  description = "Name of the Target Group."
  type        = string
}

variable "app_targetgroup_port" {
  description = "Port for the Target Group. The port where the traffic will be forwarded."
  type        = number
}

variable "app_targetgroup_protocol" {
  description = "Protocol for the Target Group."
  type        = string
}

variable "listener_port" {
  description = "Port for the Load Balancer Listener. The port on which load balancer listens for traffic."
  type        = number
}

variable "listener_protocol" {
  description = "Protocol for the Load Balancer Listener."
  type        = string
}

variable "app_healthcheck_interval" {
  description = "Interval after which health check is performed by the Load Balancer Taget Group."
  type        = number
}
