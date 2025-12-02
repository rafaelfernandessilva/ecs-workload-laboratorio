resource "aws_appautoscaling_policy" "memory_up" {
  count              = var.enable_memory_autoscaling ? 1 : 0
  resource_id        = aws_appautoscaling_target.this[0].resource_id
  service_namespace  = aws_appautoscaling_target.this[0].service_namespace
  scalable_dimension = aws_appautoscaling_target.this[0].scalable_dimension

  name = "${var.service_name}-memory-scale-up"

  policy_type = "StepScaling"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.memory_scale_up_cooldown
    metric_aggregation_type = "Average"
    dynamic "step_adjustment" {
      for_each = length(var.memory_scale_up_steps) > 0 ? var.memory_scale_up_steps : [{
        lower_bound        = 0
        upper_bound        = null
        scaling_adjustment = var.memory_scale_up_adjustment
      }]
      content {
        metric_interval_lower_bound = step_adjustment.value.lower_bound
        metric_interval_upper_bound = step_adjustment.value.upper_bound
        scaling_adjustment          = step_adjustment.value.scaling_adjustment
      }
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "memory_up" {
  count               = var.enable_memory_autoscaling ? 1 : 0
  alarm_name          = "${var.service_name}-memory-scale-up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  statistic           = "Average"
  period              = var.memory_evaluation_period
  evaluation_periods  = var.memory_evaluation_periods
  threshold           = var.memory_scale_up_threshold

  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = var.service_name
  }

  alarm_actions = [
    aws_appautoscaling_policy.memory_up[count.index].arn
  ]
}

resource "aws_appautoscaling_policy" "memory_down" {
  count              = var.enable_memory_autoscaling ? 1 : 0
  resource_id        = aws_appautoscaling_target.this[0].resource_id
  service_namespace  = aws_appautoscaling_target.this[0].service_namespace
  scalable_dimension = aws_appautoscaling_target.this[0].scalable_dimension

  name = "${var.service_name}-memory-scale-down"

  policy_type = "StepScaling"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.memory_scale_down_cooldown
    metric_aggregation_type = "Average"

    dynamic "step_adjustment" {
      for_each = length(var.memory_scale_down_steps) > 0 ? var.memory_scale_down_steps : [{
        lower_bound        = 0
        upper_bound        = null
        scaling_adjustment = var.memory_scale_down_adjustment
      }]
      content {
        metric_interval_lower_bound = step_adjustment.value.lower_bound
        metric_interval_upper_bound = step_adjustment.value.upper_bound
        scaling_adjustment          = step_adjustment.value.scaling_adjustment
      }
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "memory_down" {
  count               = var.enable_memory_autoscaling ? 1 : 0
  alarm_name          = "${var.service_name}-memory-scale-down"
  comparison_operator = "LessThanOrEqualToThreshold"
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  statistic           = "Average"
  period              = var.memory_evaluation_period
  evaluation_periods  = var.memory_evaluation_periods
  threshold           = var.memory_scale_down_threshold

  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = var.service_name
  }

  alarm_actions = [
    aws_appautoscaling_policy.memory_down[count.index].arn
  ]
}