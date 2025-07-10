resource "aws_lb" "alb" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = var.lb_type
  subnets            = var.subnets
  security_groups    = [var.security_group_id]
  tags = {
    Name = var.lb_name
  }
}

resource "aws_lb_target_group" "tg" {
  name     = var.tg_name
  port     = var.network_settings.port.http
  protocol = var.network_settings.protocol.http
  vpc_id   = var.vpc_id
  health_check {
    path                = "/"
    protocol            = var.network_settings.protocol.http
    port                = var.network_settings.protocol.traffic_port
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }

}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.network_settings.port.http
  protocol          = var.network_settings.protocol.http

  default_action {
    type             = var.default_action_type
    target_group_arn = aws_lb_target_group.tg.arn
  }
}