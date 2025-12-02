resource "aws_security_group" "main" {
  name_prefix = "${var.cluster_name}-${var.service_name}-"

  vpc_id = data.aws_ssm_parameter.vpc_id.value

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.cluster_name}-${var.service_name}"
  }
}

#resource "aws_vpc_security_group_ingress_rule" "from_lb" {
#  security_group_id            = aws_security_group.main.id
#  referenced_security_group_id = data.aws_security_group.lb.id
#  from_port                    = var.container_port
#  to_port                      = var.container_port
#  ip_protocol                  = "tcp"
#
#}


resource "aws_vpc_security_group_ingress_rule" "this" {
  security_group_id = aws_security_group.main.id
  cidr_ipv4         = "10.0.0.0/16"
  from_port         = var.container_port
  to_port           = var.container_port
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "main" {
  security_group_id = aws_security_group.main.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

}