# File orgInfra/modules/security_groups/main.tf
# resource "aws_security_group" "my_security_group" {
#   name        = var.app_securitygroup_name
#   description = var.app_securitygroup_description
#   vpc_id      = var.vpc_id

#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = var.ingress_cidrs
#   }

#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = var.ingress_cidrs
#   }

#   ingress {
#     from_port   = var.ssh_port
#     to_port     = var.ssh_port
#     protocol    = "tcp"
#     cidr_blocks = var.ingress_cidrs
#   }

#   ingress {
#     from_port   = var.application_port
#     to_port     = var.application_port
#     protocol    = "tcp"
#     cidr_blocks = var.ingress_cidrs
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = var.app_securitygroup_name
#   }
# }
resource "aws_security_group" "app_security_group" {
  name        = var.app_securitygroup_name
  description = var.app_securitygroup_description
  vpc_id      = var.vpc_id

  # Allow SSH access only from the Load Balancer Security Group
  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow application traffic only from the Load Balancer Security Group on port 8080
  ingress {
    from_port       = var.application_port
    to_port         = var.application_port
    protocol        = "tcp"
    security_groups = [var.lb_securitygroup_id]
  }

  # Outbound rules allowing all egress traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.app_securitygroup_name
  }
}
