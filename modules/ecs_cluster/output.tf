output "dns_name" {
  value = aws_lb.main.dns_name
}

output "lb_ssm_arn" {
  value = aws_ssm_parameter.lb_arn.id
}

output "lb_ssm_listerner" {
  value = aws_ssm_parameter.lb_listerner.id
}

output "cluster_name" {
  value = aws_ecs_cluster.main.name
}

output "ami" {
  value = data.aws_ami.this.id
}

output "namespace_private_dns_id" {
  value = aws_service_discovery_private_dns_namespace.this.id
}

output "namespace_http_id" {
  value = aws_service_discovery_http_namespace.this.id
}

output "namespace_http_arn" {
  value = aws_service_discovery_http_namespace.this.arn
}

output "capacity_on_demand_name" {
  value = aws_ecs_capacity_provider.on_demand.name
}

output "capacity_spot_name" {
  value = aws_ecs_capacity_provider.spots[0].name
}