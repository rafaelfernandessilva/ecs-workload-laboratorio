resource "aws_autoscaling_group" "spots" {
  count       = var.enable_spot ? 1 : 0
  name_prefix = "${var.project_name}-spots"
  vpc_zone_identifier = [
    data.aws_ssm_parameter.subnet_private_1a.value,
    data.aws_ssm_parameter.subnet_private_1b.value,
    data.aws_ssm_parameter.subnet_private_1c.value
  ]

  desired_capacity = var.cluster_spots_desired_size
  max_size         = var.cluster_spots_max_size
  min_size         = var.cluster_spots_min_size

  launch_template {
    id      = aws_launch_template.spots[0].id
    version = "$Latest"
  }

  depends_on = [
    aws_launch_template.spots[0],
    aws_iam_instance_profile.this
  ]

  tag {
    key                 = "Name"
    value               = "${var.project_name}-spots"
    propagate_at_launch = true
  }

  tag {
    key                 = "AmazonECSManager"
    value               = true
    propagate_at_launch = true
  }
}


resource "aws_ecs_capacity_provider" "spots" {
  count = var.enable_spot ? 1 : 0
  name  = "${var.project_name}-spots"

  auto_scaling_group_provider {
    auto_scaling_group_arn = aws_autoscaling_group.spots[0].arn
    managed_scaling {
      maximum_scaling_step_size = 3
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 90

    }
  }

}


resource "aws_autoscaling_lifecycle_hook" "spots" {
  name                   = "${var.project_name}-spots"
  autoscaling_group_name = aws_autoscaling_group.spots[0].name
  default_result         = "CONTINUE"
  heartbeat_timeout      = 120
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_TERMINATING"

}