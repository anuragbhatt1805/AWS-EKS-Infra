data "aws_region" "current" {}

resource "aws_vpc_endpoint" "this" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${data.aws_region.current.region}.${var.service_name}"
  vpc_endpoint_type = var.endpoint_type

  route_table_ids = var.route_table_ids
}