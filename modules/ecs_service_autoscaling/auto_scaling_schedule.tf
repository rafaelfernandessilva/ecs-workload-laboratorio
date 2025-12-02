resource "aws_appautoscaling_scheduled_action" "scale_up" {
  count              = var.enable_schedule ? 1 : 0
  name               = "up_schedule-up"
  service_namespace  = aws_appautoscaling_target.this[0].service_namespace
  resource_id        = aws_appautoscaling_target.this[0].resource_id
  scalable_dimension = aws_appautoscaling_target.this[0].scalable_dimension
  schedule = "cron(${var.minute_schedule_up} ${var.hour_schedule_up} ? * MON-FRI)"
  timezone = "America/Sao_Paulo"

  scalable_target_action {
    min_capacity = var.min_capacity_schedule_up
    max_capacity = var.max_capacity_schedule_up
  }
}

resource "aws_appautoscaling_scheduled_action" "scale_down" {
  count              = var.enable_schedule ? 1 : 0
  name               = "up_schedule-down"
  service_namespace  = aws_appautoscaling_target.this[0].service_namespace
  resource_id        = aws_appautoscaling_target.this[0].resource_id
  scalable_dimension = aws_appautoscaling_target.this[0].scalable_dimension
  schedule = "cron(${var.minute_schedule_down} ${var.hour_schedule_down} ? * MON-FRI)"
  timezone = "America/Sao_Paulo"

  scalable_target_action {
    min_capacity = var.min_capacity_schedule_down
    max_capacity = var.max_capacity_schedule_down
  }
}