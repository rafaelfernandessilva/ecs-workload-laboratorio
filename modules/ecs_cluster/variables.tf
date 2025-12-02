variable "project_name" {
  type        = string
  description = "Nome do projeto"
}

variable "ssm_vpc_id" {
  type        = string
  description = "SSM Parameter com o ID da VPC"
}

variable "ssm_public_subnet_1a" {
  type        = string
  description = "SSM Parameter com o ID da subnet pública na zona de disponibilidade 1a"
}

variable "ssm_public_subnet_1b" {
  type        = string
  description = "SSM Parameter com o ID da subnet pública na zona de disponibilidade 1b"
}

variable "ssm_public_subnet_1c" {
  type        = string
  description = "SSM Parameter com o ID da subnet pública na zona de disponibilidade 1c"
}

variable "ssm_private_subnet_1a" {
  type        = string
  description = "SSM Parameter com o ID da subnet privada na zona de disponibilidade 1a"
}

variable "ssm_private_subnet_1b" {
  type        = string
  description = "SSM Parameter com o ID da subnet privada na zona de disponibilidade 1b"
}

variable "ssm_private_subnet_1c" {
  type        = string
  description = "SSM Parameter com o ID da subnet privada na zona de disponibilidade 1c"
}

variable "load_balancer_internal" {
  type        = bool
  description = "Se o Load Balancer será interno (true) ou público (false)"
  default     = false
}

variable "load_balancer_type" {
  type        = string
  description = "Tipo de Load Balancer (application, network ou gateway)"
  default     = "application"
}

variable "instance_type" {
  type        = string
  description = "Tipo de instância EC2"
}

variable "volume_size" {
  type        = number
  description = "Tamanho do volume EBS"
}

variable "volume_type" {
  type        = string
  description = "Tipo de EBS"
  default     = "gp3"
}

variable "cluster_ondemand_min_size" {
  type        = number
  description = "Número mínimo de instâncias"
}

variable "cluster_ondemand_max_size" {
  type        = number
  description = "Número máximo de instâncias"
}

variable "cluster_ondemand_desired_size" {
  type        = number
  description = "Número desejado de instâncias"
}

variable "cluster_spots_min_size" {
  type        = number
  description = "Número mínimo de instâncias"
  default     = 1
}

variable "cluster_spots_max_size" {
  type        = number
  description = "Número máximo de instâncias"
  default     = 2
}

variable "cluster_spots_desired_size" {
  type        = number
  description = "Número desejado de instâncias Spot"
  default     = 2
}

variable "ami" {
  type        = string
  description = "AMI ID para as instâncias do cluster"
  default     = ""
}

variable "enable_spot" {
  type        = bool
  description = "Habilitar instâncias Spot"
  default     = false
}

variable "price_spot" {
  type        = string
  description = "Preço máximo para instâncias Spot"
  default     = "0.10"

}