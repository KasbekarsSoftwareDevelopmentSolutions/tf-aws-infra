# File orgInfra/modules/acm/main.tf

resource "aws_acm_certificate" "imported" {
  private_key       = var.private_key
  certificate_body  = var.certificate_body
  certificate_chain = var.certificate_chain
}
