data "aws_lb" "this" {
  name = "${var.project_name}-ingress"
}

data "aws_security_group" "lb" {
  filter {
    name   = "tag:Name"
    values = ["${var.project_name}-load-balancer"]
  }
  filter {
    name   = "vpc-id"
    values = [data.aws_ssm_parameter.vpc_id.value]
  }
}

data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}/vpc/vpc_id"
}

data "aws_lb_listener" "this" {
  load_balancer_arn = data.aws_lb.this.arn
  port              = 80
}


data "aws_ssm_parameter" "subnet_private_1a" {
  name = "/${var.project_name}/vpc/private_1a"
}

data "aws_ssm_parameter" "subnet_private_1b" {
  name = "/${var.project_name}/vpc/private_1b"
}

data "aws_ssm_parameter" "subnet_private_1c" {
  name = "/${var.project_name}/vpc/private_1c"
}

data "aws_region" "current" {}