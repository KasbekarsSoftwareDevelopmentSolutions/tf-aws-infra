# File orgInfra/modules/route_53/main.tf

resource "aws_route53_record" "www" {
  zone_id = var.zone_id
  name    = var.zone_name
  type    = "A"

  alias {
    name                   = var.load_balancer_dns_name
    zone_id                = var.load_balancer_zone_id
    evaluate_target_health = true
  }
}
