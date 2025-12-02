output "vpc_id" {
  description = "ID do parâmetro SSM que contém o ID da VPC"
  value       = module.vpc.ssm_vpc_id
}

output "ssm_public_subnet_1a_id" {
  description = "ID da subnet pública 1a"
  value       = module.vpc.public_1a
}

output "ssm_public_subnet_1b_id" {
  description = "ID da subnet pública 1b"
  value       = module.vpc.public_1b
}

output "ssm_public_subnet_1c_id" {
  description = "ID da subnet pública 1c"
  value       = module.vpc.public_1c
}

output "ssm_private_subnet_1a_id" {
  description = "ID da subnet privada 1a"
  value       = module.vpc.private_1a
}

output "ssm_private_subnet_1b_id" {
  description = "ID da subnet privada 1b"
  value       = module.vpc.private_1b
}

output "ssm_private_subnet_1c_id" {
  description = "ID da subnet privada 1c"
  value       = module.vpc.private_1c
}

output "dns_name" {
  description = "DNS name do Load Balancer"
  value       = module.ecs_cluster.dns_name
}

output "lb_ssm_arn" {
  description = "ARN do Load Balancer"
  value       = module.ecs_cluster.lb_ssm_arn
}

output "lb_ssm_listener" {
  description = "ARN do listener do Load Balancer"
  value       = module.ecs_cluster.lb_ssm_listerner
}

output "cluster_name" {
  description = "Nome do cluster ECS"
  value       = module.ecs_cluster.cluster_name
}

output "ami" {
  description = "AMI ID usada nas instâncias do cluster"
  value       = module.ecs_cluster.ami
}

output "capacity_spot_name" {
  value = module.ecs_cluster.capacity_spot_name
}

output "capacity_on_demand_name" {
  value = module.ecs_cluster.capacity_on_demand_name
}