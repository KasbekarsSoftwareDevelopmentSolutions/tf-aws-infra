# File orgInfra/modules/load_balancer/main.tf
resource "aws_lb" "app_load_balancer" {
  name               = var.load_balancer_name
  internal           = false
  load_balancer_type = var.loadbalancer_type
  security_groups    = var.security_group_ids
  subnets            = var.subnet_ids

  tags = {
    Name = var.load_balancer_name
  }
}

resource "aws_lb_target_group" "app_target_group" {
  name        = var.app_targetgroup_name
  port        = var.app_targetgroup_port
  protocol    = var.app_targetgroup_protocol
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/healthz"
    protocol            = var.app_targetgroup_protocol
    matcher             = "200"
    interval            = var.app_healthcheck_interval
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 5
    port                = var.app_targetgroup_port
  }

  tags = {
    Name = var.app_targetgroup_name
  }
}

resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_load_balancer.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_target_group.arn
  }
}
