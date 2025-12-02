module "vpc" {
  source = "./modules/vpc"

  project_name = local.project_name

  region = local.region
}

module "ecs_cluster" {
  source = "./modules/ecs_cluster"

  project_name = local.project_name

  ssm_vpc_id           = module.vpc.ssm_vpc_id
  ssm_public_subnet_1a = module.vpc.public_1a
  ssm_public_subnet_1b = module.vpc.public_1b
  ssm_public_subnet_1c = module.vpc.public_1c

  ssm_private_subnet_1a = module.vpc.private_1a
  ssm_private_subnet_1b = module.vpc.private_1b
  ssm_private_subnet_1c = module.vpc.private_1c

  ami           = local.ami
  instance_type = local.instance_type
  volume_size   = local.volume_size
  volume_type   = local.volume_type

  cluster_ondemand_min_size     = 1
  cluster_ondemand_max_size     = 1
  cluster_ondemand_desired_size = 1

  enable_spot                = true
  cluster_spots_min_size     = 1
  cluster_spots_max_size     = 1
  cluster_spots_desired_size = 1
  price_spot                 = "0.12" #fique ligado no valor definido para o spot caso não consiga subir a instancia pode ser devido ao valor do momento

  load_balancer_internal = false
  load_balancer_type     = "application"
  depends_on             = [module.vpc]
}

module "app_a" {
  source                   = "./modules/ecs_service"
  cluster_name             = module.ecs_cluster.cluster_name
  project_name             = local.project_name
  capacity_on_demand_name  = module.ecs_cluster.capacity_on_demand_name
  capacity_spot_name       = module.ecs_cluster.capacity_spot_name
  service_name             = "app-a"
  desired_count            = 1
  cpu                      = 128
  memory                   = 256
  container_image          = "1234567890.dkr.ecr.us-east-1.amazonaws.com/ecr:latest"
  container_port           = 8080
  health_check_path        = "healthcheck"
  namespace_private_dns_id = module.ecs_cluster.namespace_private_dns_id
  namespace_http_arn       = module.ecs_cluster.namespace_http_arn
  domain_name              = "meuapp-a.rafael.bhz.br"
  depends_on               = [module.ecs_cluster]
}

module "app_b" {
  source                   = "./modules/ecs_service"
  cluster_name             = module.ecs_cluster.cluster_name
  project_name             = local.project_name
  capacity_on_demand_name  = module.ecs_cluster.capacity_on_demand_name
  capacity_spot_name       = module.ecs_cluster.capacity_spot_name
  service_name             = "app-b"
  desired_count            = 1
  cpu                      = 128
  memory                   = 256
  container_image          = "1234567890.dkr.ecr.us-east-1.amazonaws.com/ecr:latest"
  container_port           = 8080
  health_check_path        = "healthcheck"
  namespace_private_dns_id = module.ecs_cluster.namespace_private_dns_id
  namespace_http_arn       = module.ecs_cluster.namespace_http_arn
  domain_name              = "meuapp-b.rafael.bhz.br"
  depends_on               = [module.ecs_cluster]

}

module "autoscaling_app_a" {
    source       = "./modules/ecs_service_autoscaling"
    service_name = module.app_a.service_name
    cluster_name = module.ecs_cluster.cluster_name

    enable_cpu_autoscaling = true
    cpu_scale_up_threshold = 50   
    min_capacity           = 1
    max_capacity           = 5
    cpu_scale_up_adjustment = 2
    cpu_scale_down_adjustment = -1
    cpu_scale_up_cooldown  = 60     
    cpu_scale_down_cooldown = 60   
    cpu_evaluation_period = 30  
    cpu_evaluation_periods = 2

}