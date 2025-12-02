resource "aws_appautoscaling_target" "this" {
  count              = var.enable_autoscaling ? 1 : 0
  min_capacity       = var.min_capacity
  max_capacity       = var.max_capacity
  resource_id        = "service/${var.cluster_name}/${var.service_name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
} 