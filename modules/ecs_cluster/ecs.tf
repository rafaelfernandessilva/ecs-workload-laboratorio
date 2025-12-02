resource "aws_ecs_cluster" "main" {
  name = var.project_name
  setting {
    name  = "containerInsights"
    value = "enhanced"
  }
}

resource "aws_ecs_cluster_capacity_providers" "main" {
  cluster_name = aws_ecs_cluster.main.name
  capacity_providers = flatten([
    [aws_ecs_capacity_provider.on_demand.name],
    var.enable_spot ? [aws_ecs_capacity_provider.spots[0].name] : []
  ])

  default_capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.on_demand.name
    weight            = 100
    base              = 0
  }
}