# File orgInfra/modules/autoscaling/outputs.tf

output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.app_asg.name
}
