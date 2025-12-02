variable "cluster_name" {
  type        = string
  description = "Nome do cluster ECS"
  default     = "devops-test"
}

variable "project_name" {
  type        = string
  description = "Nome do projeto usado para construir os nomes dos capacity providers"
  default     = "devops-test"
}

variable "service_name" {
  type        = string
  description = "Nome do serviço ECS"
  default     = "app-test"

}

variable "cpu" {
  type        = number
  description = "CPU container da task definition"
  default     = 128
}

variable "memory" {
  type        = number
  description = "Memória container da task definition"
  default     = 256
}

variable "container_image" {
  type        = string
  description = "URI da imagem do container"
  default     = "504254871558.dkr.ecr.us-east-1.amazonaws.com/devops-test:latest"
}

variable "container_port" {
  type        = number
  description = "Porta do container"
  default     = 3000

}

variable "health_check_path" {
  type        = string
  description = "health check"
  default     = "health"
}

variable "namespace_private_dns_id" {
  type        = string
  description = "ID do namespace Private DNS"
}

variable "namespace_http_arn" {
  type        = string
  description = "ARN do namespace HTTP"
}

variable "domain_name" {
  type        = string
  description = "Nome do domínio"
}

variable "desired_count" {
  type        = number
  description = "Desired count"
  default     = 0
}

variable "capacity_on_demand_name" {
  type = string
}

variable "capacity_spot_name" {
  type     = string
  nullable = true
  default  = null
}