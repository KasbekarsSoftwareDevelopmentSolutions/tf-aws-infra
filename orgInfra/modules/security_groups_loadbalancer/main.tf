# File orgInfra/modules/security_groups_loadbalancer/main.tf
resource "aws_security_group" "lb_security_group" {
  name        = var.lb_securitygroup_name
  description = var.lb_securitygroup_description
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.lb_securitygroup_name
  }
}
