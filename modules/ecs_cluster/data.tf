data "aws_ssm_parameter" "vpc" {
  name = var.ssm_vpc_id
}

data "aws_ssm_parameter" "subnet_public_1a" {
  name = var.ssm_public_subnet_1a
}

data "aws_ssm_parameter" "subnet_public_1b" {
  name = var.ssm_public_subnet_1b
}

data "aws_ssm_parameter" "subnet_public_1c" {
  name = var.ssm_public_subnet_1c
}

data "aws_ssm_parameter" "subnet_private_1a" {
  name = var.ssm_private_subnet_1a
}

data "aws_ssm_parameter" "subnet_private_1b" {
  name = var.ssm_private_subnet_1b
}

data "aws_ssm_parameter" "subnet_private_1c" {
  name = var.ssm_private_subnet_1c
}

data "aws_ami" "this" {
  most_recent = true
  name_regex  = "amzn2-ami-ecs-hvm-2.0.*-x86_64-ebs"
  owners      = ["amazon"]
}