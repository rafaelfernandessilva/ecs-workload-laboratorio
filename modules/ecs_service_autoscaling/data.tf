data "aws_lb" "this" {
  count = var.enable_requests_autoscaling ? 1 : 0
  name  = var.load_balancer_name
}

data "aws_lb_target_group" "this" {
  count = var.enable_requests_autoscaling ? 1 : 0
  name  = var.target_group_name
}