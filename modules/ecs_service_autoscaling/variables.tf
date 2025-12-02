variable "service_name" {
  description = "Nome do serviço ECS para autoscaling"
  type        = string

  validation {
    condition     = length(var.service_name) > 0
    error_message = "O nome do serviço não pode estar vazio."
  }
}

variable "cluster_name" {
  description = "Nome do cluster ECS"
  type        = string

  validation {
    condition     = length(var.cluster_name) > 0
    error_message = "O nome do cluster não pode estar vazio."
  }
}

variable "enable_autoscaling" {
  description = "Habilita o autoscaling para o serviço"
  type        = bool
  default     = true
}

variable "enable_cpu_autoscaling" {
  description = "Habilita autoscaling baseado em CPU"
  type        = bool
  default     = false
}

variable "enable_requests_autoscaling" {
  description = "Habilita autoscaling baseado em requests"
  type        = bool
  default     = false
}

variable "min_capacity" {
  description = "Número mínimo de tasks"
  type        = number
  default     = 1

  validation {
    condition     = var.min_capacity >= 0
    error_message = "A capacidade mínima deve ser maior ou igual a 0."
  }
}

variable "max_capacity" {
  description = "Número máximo de tasks"
  type        = number
  default     = 5

  validation {
    condition     = var.max_capacity > 0
    error_message = "A capacidade máxima deve ser maior que 0."
  }
}

variable "cpu_scale_up_threshold" {
  description = "Threshold para scale up baseado em CPU (%)"
  type        = number
  default     = 50

  validation {
    condition     = var.cpu_scale_up_threshold > 0 && var.cpu_scale_up_threshold <= 100
    error_message = "O threshold de CPU para scale up deve estar entre 1 e 100."
  }
}

variable "cpu_scale_down_threshold" {
  description = "Threshold para scale down baseado em CPU (%)"
  type        = number
  default     = 35

  validation {
    condition     = var.cpu_scale_down_threshold >= 0 && var.cpu_scale_down_threshold < 100
    error_message = "O threshold de CPU para scale down deve estar entre 0 e 99."
  }
}

variable "cpu_scale_up_adjustment" {
  description = "Número de tasks para adicionar no scale up"
  type        = number
  default     = 2

  validation {
    condition     = var.cpu_scale_up_adjustment > 0
    error_message = "O ajuste de CPU para scale up deve ser maior que 0."
  }
}

variable "cpu_scale_down_adjustment" {
  description = "Número de tasks para remover no scale down"
  type        = number
  default     = -1

  validation {
    condition     = var.cpu_scale_down_adjustment < 0
    error_message = "O ajuste de CPU para scale down deve ser menor que 0."
  }
}

variable "cpu_scale_up_cooldown" {
  description = "Cooldown em segundos para scale up"
  type        = number
  default     = 60

  validation {
    condition     = var.cpu_scale_up_cooldown >= 0
    error_message = "O cooldown de CPU para scale up deve ser maior ou igual a 0."
  }
}

variable "cpu_scale_down_cooldown" {
  description = "Cooldown em segundos para scale down"
  type        = number
  default     = 60
}

variable "cpu_evaluation_period" {
  description = "Período de avaliação em segundos para métricas de CPU"
  type        = number
  default     = 60
}

variable "cpu_evaluation_periods" {
  description = "Número de períodos para avaliação de CPU"
  type        = number
  default     = 2
}


variable "enable_memory_autoscaling" {
  description = "Habilita autoscaling baseado em memória"
  type        = bool
  default     = false
}


variable "memory_scale_up_threshold" {
  description = "Threshold para scale up baseado em memória (%)"
  type        = number
  default     = 50
}

variable "memory_scale_down_threshold" {
  description = "Threshold para scale down baseado em memória (%)"
  type        = number
  default     = 35
}

variable "memory_scale_up_adjustment" {
  description = "Número de tasks para adicionar no scale up"
  type        = number
  default     = 2
}

variable "memory_scale_down_adjustment" {
  description = "Número de tasks para remover no scale down"
  type        = number
  default     = -1
}

variable "memory_scale_up_cooldown" {
  description = "Cooldown em segundos para scale up"
  type        = number
  default     = 60
}

variable "memory_scale_down_cooldown" {
  description = "Cooldown em segundos para scale down"
  type        = number
  default     = 60
}

variable "memory_evaluation_periods" {
  description = "Número de períodos para avaliação de memória"
  type        = number
  default     = 2
}

variable "memory_evaluation_period" {
  description = "Período de avaliação em segundos para métricas de memória"
  type        = number
  default     = 60
}


variable "requests_target_value" {
  description = "Valor alvo de requests por target"
  type        = number
  default     = 10
}

variable "requests_threshold" {
  description = "Threshold para alarme de requests"
  type        = number
  default     = 10
}

variable "requests_scale_in_cooldown" {
  description = "Cooldown em segundos para scale in baseado em requests"
  type        = number
  default     = 60
}

variable "requests_scale_out_cooldown" {
  description = "Cooldown em segundos para scale out baseado em requests"
  type        = number
  default     = 60
}

variable "requests_evaluation_period" {
  description = "Período de avaliação em segundos para métricas de requests"
  type        = number
  default     = 30
}

variable "requests_evaluation_periods" {
  description = "Número de períodos para avaliação de requests"
  type        = number
  default     = 2
}


variable "target_group_name" {
  description = "Nome do target group"
  type        = string
  default     = ""
}

variable "load_balancer_name" {
  description = "Nome do load balancer"
  type        = string
  default     = ""
}

variable "min_capacity_schedule_up" {
  description = "Número mínimo de tasks para scale up programado"
  type        = number
  default     = 1
}

variable "max_capacity_schedule_up" {
  description = "Número máximo de tasks para scale up programado"
  type        = number
  default     = 5
}

variable "min_capacity_schedule_down" {
  description = "Número mínimo de tasks para scale down programado"
  type        = number
  default     = 1
}

variable "max_capacity_schedule_down" {
  description = "Número máximo de tasks para scale down programado"
  type        = number
  default     = 5
}

variable "minute_schedule_up" {
  description = "Minuto para scale up programado"
  type        = number
  default     = 0
}

variable "hour_schedule_up" {
  description = "Hora para scale up programado"
  type        = number
  default     = 0
}

variable "minute_schedule_down" {
  description = "Minuto para scale down programado"
  type        = number
  default     = 0
}

variable "hour_schedule_down" {
  description = "Hora para scale down programado"
  type        = number
  default     = 0
}


variable "enable_schedule" {
  description = "Habilita scale  programado"
  type        = bool
  default     = false
}


variable "cpu_scale_up_steps" {
  description = "Lista de steps para política de scale up baseado em CPU"
  type = list(object({
    lower_bound        = optional(number)
    upper_bound        = optional(number)
    scaling_adjustment = number
  }))
  default = []

  validation {
    condition = alltrue([
      for step in var.cpu_scale_up_steps : step.scaling_adjustment != 0
    ])
    error_message = "O scaling_adjustment não pode ser zero."
  }
}

variable "cpu_scale_down_steps" {
  description = "Lista de steps para política de scale down baseado em CPU"
  type = list(object({
    lower_bound        = optional(number)
    upper_bound        = optional(number)
    scaling_adjustment = number
  }))
  default = []

  validation {
    condition = alltrue([
      for step in var.cpu_scale_down_steps : step.scaling_adjustment != 0
    ])
    error_message = "O scaling_adjustment não pode ser zero."
  }
}

variable "memory_scale_up_steps" {
  description = "Lista de steps para política de scale up baseado em memória"
  type = list(object({
    lower_bound        = optional(number)
    upper_bound        = optional(number)
    scaling_adjustment = number
  }))
  default = []

  validation {
    condition = alltrue([
      for step in var.memory_scale_up_steps : step.scaling_adjustment != 0
    ])
    error_message = "O scaling_adjustment não pode ser zero."
  }
}

variable "memory_scale_down_steps" {
  description = "Lista de steps para política de scale down baseado em memória"
  type = list(object({
    lower_bound        = optional(number)
    upper_bound        = optional(number)
    scaling_adjustment = number
  }))
  default = []

  validation {
    condition = alltrue([
      for step in var.memory_scale_down_steps : step.scaling_adjustment != 0
    ])
    error_message = "O scaling_adjustment não pode ser zero."
  }
}