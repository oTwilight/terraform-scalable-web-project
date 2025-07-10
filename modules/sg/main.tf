resource "aws_security_group" "web_sg" {
  name        = var.sg_name
  description = "Allow HTTP and HTTPS"
  vpc_id      = var.vpc_id


  tags = {
    Name = var.sg_name
  }
}
# Public HTTP rule (for ALB SG)
resource "aws_vpc_security_group_ingress_rule" "http_public" {
  count             = var.rule_type == "public" ? 1 : 0
  security_group_id = aws_security_group.web_sg.id
  cidr_ipv4         = var.zero_cidr
  from_port         = var.network_settings.port.http
  to_port           = var.network_settings.port.http
  ip_protocol       = var.network_settings.protocol.tcp
}
resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  count             = var.rule_type == "public" ? 1 : 0
  security_group_id = aws_security_group.web_sg.id
  cidr_ipv4         = var.zero_cidr
  from_port         = var.network_settings.port.https
  ip_protocol       = var.network_settings.protocol.tcp
  to_port           = var.network_settings.port.https
}
# Internal ALB -> EC2 rule
resource "aws_vpc_security_group_ingress_rule" "http_internal" {
  count                        = var.rule_type == "internal" ? 1 : 0
  security_group_id            = aws_security_group.web_sg.id
  referenced_security_group_id = var.alb_sg_id
  from_port                    = var.network_settings.port.http
  to_port                      = var.network_settings.port.http
  ip_protocol                  = var.network_settings.protocol.tcp

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_security_group.web_sg]
}

resource "aws_vpc_security_group_egress_rule" "allow_engress" {
  security_group_id = aws_security_group.web_sg.id
  cidr_ipv4         = var.zero_cidr
  ip_protocol       = var.network_settings.protocol.all
}