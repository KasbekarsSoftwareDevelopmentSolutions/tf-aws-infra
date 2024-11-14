# File orgInfra/modules/autoscaling/variables.tf

variable "launch_template_id" {
  description = "ID of the Launch Template"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the Auto Scaling Group"
  type        = list(string)
}

variable "instance_name" {
  description = "Tag name for the instances"
  type        = string
}

variable "min_size" {
  description = "Minimum number of instances in the Auto Scaling Group"
  type        = number
}

variable "max_size" {
  description = "Maximum number of instances in the Auto Scaling Group"
  type        = number
}

variable "desired_capacity" {
  description = "Desired number of instances in the Auto Scaling Group"
  type        = number
}

variable "target_group_arns" {
  description = "List of Target Group ARNs to attach to the Auto Scaling Group"
  type        = list(string)
}

variable "cooldown" {
  description = "Cooldown period for scaling actions"
  type        = number
}

variable "environment" {
  description = "Environment tag for the instances"
  type        = string
}

variable "upscale_cpu_utilization_percent" {
  description = "Provide the value of CPU utilization percentage,a above which up scaling of instances will occur."
  type        = number
}

variable "downscale_cpu_utilization_percent" {
  description = "Provide the value of CPU utilization percentage,a below which down scaling of instances will occur."
  type        = number
}
