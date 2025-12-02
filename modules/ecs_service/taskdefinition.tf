resource "aws_ecs_task_definition" "service" {
  family             = var.service_name
  network_mode       = "awsvpc"
  execution_role_arn = aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = var.service_name
      image     = var.container_image
      cpu       = var.cpu
      memory    = var.memory
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          protocol      = "tcp"
          name          = var.service_name
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/${var.service_name}"
          "awslogs-region"        = data.aws_region.current.region
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }

  ])

  skip_destroy = true
}
