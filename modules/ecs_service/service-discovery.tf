resource "aws_service_discovery_service" "this" {
  name = var.service_name

  dns_config {
    namespace_id = var.namespace_private_dns_id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }


}