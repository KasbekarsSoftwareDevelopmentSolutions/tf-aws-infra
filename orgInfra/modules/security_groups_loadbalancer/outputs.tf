#  File orgInfra/modules/security_groups_loadbalancer/outputs.tf
output "lb_security_group_id" {
  description = "ID of the Load Balancer Security Group"
  value       = aws_security_group.lb_security_group.id
}
