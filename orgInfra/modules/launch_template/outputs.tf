# File orgInfra/modules/launch_template/outputs.tf

output "launch_template_id" {
  description = "ID of the Launch Template"
  value       = aws_launch_template.app_launch_template.id
}
