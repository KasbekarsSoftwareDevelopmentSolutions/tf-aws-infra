# File orgInfra/modules/acm/outputs.tf

output "acm_certificate_arn" {
  value = aws_acm_certificate.imported.arn
}
