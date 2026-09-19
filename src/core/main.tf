data "aws_region" "current" {}

module "vpc" {
  source = "../../modules/tofu-aws-vpc"

  aws_region             = var.aws_region
  aws_availability_zones = var.aws_availability_zones
}

module "s3_gateway_endpoint" {
  source = "../../modules/tofu-aws-vpc-endpoint"

  vpc_id            = module.vpc.vpc_id
  service_name      = "s3"
  endpoint_type     = "Gateway"
  route_table_ids   = concat(module.vpc.public_route_table_ids, module.vpc.private_route_table_ids)
}