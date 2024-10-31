# File orgInfra/modules/route_53/main.tf

resource "aws_route53_record" "www" {
  zone_id = var.zone_id
  name    = var.zone_name
  type    = "A"
  ttl     = "60"
  records = [var.ec2_public_ip]
}

