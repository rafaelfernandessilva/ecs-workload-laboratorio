output "lb_name" {
  value = data.aws_lb.this.name
}

output "aws_security_group" {
  value = data.aws_security_group.lb.id

}

output "service_name" {
  value = aws_ecs_service.this.name
}