resource "aws_ecs_service" "this" {
  name            = var.service_name
  cluster         = var.cluster_name
  task_definition = aws_ecs_task_definition.service.arn
  desired_count   = var.desired_count

  force_new_deployment = true

  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 50



  network_configuration {
    subnets = [
      data.aws_ssm_parameter.subnet_private_1a.value,
      data.aws_ssm_parameter.subnet_private_1b.value,
      data.aws_ssm_parameter.subnet_private_1c.value
    ]
    security_groups = [aws_security_group.main.id]
  }

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  # deployment_configuration {
  #   strategy             = "CANARY"
  #   bake_time_in_minutes = 15
  #
  #   canary_configuration {
  #     canary_percent              = 10.0
  #     canary_bake_time_in_minutes = 5
  #   }
  # }

  deployment_configuration {
    strategy = "ROLLING"

  }

  service_connect_configuration {
    enabled   = true
    namespace = var.namespace_http_arn
    service {
      client_alias {
        dns_name = var.service_name
        port     = var.container_port
      }
      discovery_name = var.service_name
      port_name      = var.service_name
    }
  }

  #  service_registries {
  #    registry_arn = aws_service_discovery_service.this.arn
  #  }
  #

  capacity_provider_strategy {
    capacity_provider = var.capacity_on_demand_name
    weight            = 100
    base              = 0
  }

  capacity_provider_strategy {
    capacity_provider = var.capacity_spot_name
    weight            = 10
    base              = 0
  }

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = var.service_name
    container_port   = var.container_port

  }

}
