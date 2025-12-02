# ECS-Workload-Lab
Nesse repositório temos um laboratório prático para criação de workloads no AWS ECS utilizando Terraform.

Iremos fazer o CI/CD de uma aplicação simples em Go, subir ela no ECS.

Repositório com módulos Terraform para criar uma VPC, um cluster ECS com ASG/Launch Templates (suportando Spot) e serviços ECS, e algumas configurações de rede para comunicação interna da aplicação.

**LEMBRANDO NOVAMENTE, ESSE É UM LABORATÓRIO PRÁTICO, MAS NÃO É RECOMENDADO PARA PRODUÇÃO, ANALISE ANTES A NECESSIDADE DO SEU PRODUTO E FAÇA AS DEVIDAS ADAPTAÇÕES.**

## Estrutura principal

- **modules/**
  - **vpc/** — sub-redes, gateways e NAT
  - **ecs_cluster/** — cluster ECS, ASG, launch templates, service discovery
  - **ecs_service/** — task definition, service, target group, security groups
  - **ecs_service_autoscaling/** — políticas/alarms para autoscaling (CPU, memória, requests, schedule)
- **app/** — código da aplicação (Dockerfile, Go app)
- **provider.tf, main.tf, locals.tf, output.tf** — root Terraform e orquestração
- **.github/workflows** — CI/CD e release

## Pré-requisitos

- **Terraform 1.0+**
- **AWS CLI** configurado com credenciais com permissão para criar recursos
- Recomendações de provider: o repo inclui versões 6.18.0 / 6.20.0 do provider aws — usar compatível com Terraform local
- **Docker**

## pipilene de CI/CD local
Execute o  pipeline.sh para buildar a imagem Docker, subir para o ECR e aplicar o Terraform localmente, na pasta do app.
```bash
bash pipeline.sh
```
Execute pipeline.sh para rodar o fluxo para o terraform localmente:
```bash
bash pipeline/pipeline.sh
```

## workflow de CI/CD

Nesse repositório há um workflow de GitHub Actions que realiza:

- Validação do código Terraform (fmt, validate)
- Build e push da imagem Docker para o ECR 
- Aplicação do Terraform (plan/apply) — opcional, ativado via manual trigger

Para usar o workflow, ajuste as secrets no repositório do GitHub com a role e suas devidas permissões.

## Validando a aplicação

Após subir a aplicação com terraform, você pode validar se o container está rodando corretamente acessando o endpoint de healthcheck via curl (ajuste o Host conforme o domínio configurado no módulo ecs_service):

```bash
curl -H "Host: meuapp-a.rafael.bhz.br" DNS-DO-SEU-LOAD-BALANCER/healthcheck
```

Você receberá a resposta do container rodando no ECS.

É possível também acessar o container e validar a comunicação entre eles e a configuração de service discovery:

```bash
curl app-a:8080/version
```

## Exemplo de uso (baseado em main.tf)

Abaixo está um exemplo mínimo inspirado no `main.tf` deste repositório. Copie/cole no seu root `main.tf` se quiser replicar a mesma chamada dos módulos:

```terraform
module "vpc" {
  source       = "./modules/vpc"
  project_name = local.project_name
  region       = local.region
}

module "ecs_cluster" {
  source = "./modules/ecs_cluster"

  project_name = local.project_name

  # subnets / SSM inputs
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

  # On-demand ASG
  cluster_ondemand_min_size     = 1
  cluster_ondemand_max_size     = 1
  cluster_ondemand_desired_size = 1

  # Spot ASG (ativa)
  enable_spot                = true
  cluster_spots_min_size     = 1
  cluster_spots_max_size     = 1
  cluster_spots_desired_size = 1
  price_spot                 = "0.12"

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
  container_image          = "YOUR_ECR_IMAGE_URI"
  container_port           = 8080
  health_check_path        = "healthcheck"
  namespace_private_dns_id = module.ecs_cluster.namespace_private_dns_id
  namespace_http_arn       = module.ecs_cluster.namespace_http_arn
  domain_name              = "meuapp-a.exemplo.com"
  depends_on               = [module.ecs_cluster]
}

module "autoscaling_app_a" {
  source       = "./modules/ecs_service_autoscaling"
  service_name = module.app_a.service_name
  cluster_name = module.ecs_cluster.cluster_name

  enable_cpu_autoscaling    = true
  cpu_target_utilization    = 50 
  min_capacity              = 1
  max_capacity              = 5

  # ajustes e cooldowns 
  cpu_scale_up_adjustment   = 2
  cpu_scale_down_adjustment = -1
  cpu_scale_up_cooldown     = 60
  cpu_scale_down_cooldown   = 60
  cpu_evaluation_period     = 30
  cpu_evaluation_periods    = 2
}
```



