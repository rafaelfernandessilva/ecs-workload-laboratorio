provider "aws" {
  region = local.region
  default_tags {
    tags = {
      Name    = local.project_name
      Created = "Terraform"
      Module  = "ecs_cluster"
    }
  }
}