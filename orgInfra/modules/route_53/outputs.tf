# File orgInfra/modules/route_53/outputs.tf

output "route53_record" {
  description = "Route 53 record for the application"
  value       = aws_route53_record.www.fqdn
}
