resource "aws_appautoscaling_policy" "requests" {
  count              = var.enable_requests_autoscaling ? 1 : 0
  resource_id        = aws_appautoscaling_target.this[0].resource_id
  service_namespace  = aws_appautoscaling_target.this[0].service_namespace
  scalable_dimension = aws_appautoscaling_target.this[0].scalable_dimension

  name = "${var.service_name}-requests-scale-up"

  policy_type = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    target_value       = var.requests_target_value
    scale_in_cooldown  = var.requests_scale_in_cooldown
    scale_out_cooldown = var.requests_scale_out_cooldown

    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label         = local.resource_label
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "requests_up" {
  count               = var.enable_requests_autoscaling ? 1 : 0
  alarm_name          = "${var.service_name}-requests-scale-up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  metric_name         = "RequestCountPerTarget"
  namespace           = "AWS/ApplicationELB"
  statistic           = "Average"
  period              = var.requests_evaluation_period
  evaluation_periods  = var.requests_evaluation_periods
  threshold           = var.requests_threshold

  dimensions = {
    TargetGroup  = data.aws_lb_target_group.this[0].arn
    LoadBalancer = data.aws_lb.this[0].arn
  }

  alarm_actions = [
    aws_appautoscaling_policy.requests[count.index].arn
  ]
} 