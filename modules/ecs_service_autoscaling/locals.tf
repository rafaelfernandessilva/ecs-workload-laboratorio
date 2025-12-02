locals {
  alb_arn          = var.enable_requests_autoscaling ? data.aws_lb.this[0].arn : ""
  target_group_arn = var.enable_requests_autoscaling ? data.aws_lb_target_group.this[0].arn : ""

  alg_resource_get = var.enable_requests_autoscaling ? split("loadbalancer/", local.alb_arn)[1] : ""
  tg_resource_get  = var.enable_requests_autoscaling ? split(":", local.target_group_arn)[5] : ""

  resource_label = var.enable_requests_autoscaling ? "${local.alg_resource_get}/${local.tg_resource_get}" : ""
}