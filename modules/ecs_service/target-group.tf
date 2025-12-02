resource "aws_lb_target_group" "this" {
  name_prefix = "${var.service_name}-"
  port        = var.container_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = data.aws_ssm_parameter.vpc_id.value

  health_check {
    path                = "/${var.health_check_path}"
    port                = "traffic-port"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 10
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.service_name}-lb-tg"
  }
}

resource "aws_lb_listener_rule" "this" {
  listener_arn = data.aws_lb_listener.this.arn
  #priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
  condition {
    host_header {
      values = [var.domain_name]
    }
  }
}