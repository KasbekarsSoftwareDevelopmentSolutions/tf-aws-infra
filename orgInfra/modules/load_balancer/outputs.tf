# File orgInfra/modules/load_balancer/outputs.tf
output "load_balancer_arn" {
  description = "ARN of the Load Balancer"
  value       = aws_lb.app_load_balancer.arn
}

output "load_balancer_dns_name" {
  description = "DNS name of the Load Balancer"
  value       = aws_lb.app_load_balancer.dns_name
}

output "target_group_arn" {
  description = "ARN of the Target Group"
  value       = aws_lb_target_group.app_target_group.arn
}

output "load_balancer_zone_id" {
  description = "Zone Id of teh Load Balancer"
  value       = aws_lb.app_load_balancer.zone_id
}
