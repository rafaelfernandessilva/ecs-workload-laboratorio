resource "aws_ssm_parameter" "lb_arn" {
  name  = "/ecs/lb/arn"
  value = aws_lb.main.arn
  type  = "String"
}


resource "aws_ssm_parameter" "lb_listerner" {
  name  = "/ecs/lb/listerner"
  value = aws_lb_listener.http.arn
  type  = "String"
}

