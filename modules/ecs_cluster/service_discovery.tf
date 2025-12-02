resource "aws_service_discovery_private_dns_namespace" "this" {
  name        = "lab-test-ns"
  description = "Namespace Private DNS..."
  vpc         = data.aws_ssm_parameter.vpc.value

  lifecycle {
    ignore_changes = [vpc]
  }
}


resource "aws_service_discovery_http_namespace" "this" {
  name        = "lab-test-http-ns"
  description = "Namespace HTTP..."


}