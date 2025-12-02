output "ssm_vpc_id" {
  description = "Nome do parâmetro SSM que contém o ID da VPC"
  value       = aws_ssm_parameter.vpc.name
}

output "private_1a" {
  description = "Nome do parâmetro SSM que contém o ID da subnet privada 1a"
  value       = aws_ssm_parameter.private_1a.name
}

output "private_1b" {
  description = "Nome do parâmetro SSM que contém o ID da subnet privada 1b"
  value       = aws_ssm_parameter.private_1b.name
}

output "private_1c" {
  description = "Nome do parâmetro SSM que contém o ID da subnet privada 1c"
  value       = aws_ssm_parameter.private_1c.name
}

output "public_1a" {
  description = "Nome do parâmetro SSM que contém o ID da subnet pública 1a"
  value       = aws_ssm_parameter.public_1a.name
}

output "public_1b" {
  description = "Nome do parâmetro SSM que contém o ID da subnet pública 1b"
  value       = aws_ssm_parameter.public_1b.name
}

output "public_1c" {
  description = "Nome do parâmetro SSM que contém o ID da subnet pública 1c"
  value       = aws_ssm_parameter.public_1c.name
}

output "database_subnet_1a" {
  description = "Nome do parâmetro SSM que contém o ID da subnet de banco de dados 1a"
  value       = aws_ssm_parameter.database_subnet_1a.name
}

output "database_subnet_1b" {
  description = "Nome do parâmetro SSM que contém o ID da subnet de banco de dados 1b"
  value       = aws_ssm_parameter.database_subnet_1b.name
}

output "database_subnet_1c" {
  description = "Nome do parâmetro SSM que contém o ID da subnet de banco de dados 1c"
  value       = aws_ssm_parameter.database_subnet_1c.name
}

