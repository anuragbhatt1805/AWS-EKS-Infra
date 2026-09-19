data "aws_region" "current" {}

module "vpc" {
  source = "../../modules/tofu-aws-vpc"

  aws_region             = var.aws_region
  aws_availability_zones = var.aws_availability_zones
}

module "s3_gateway_endpoint" {
  source = "../../modules/tofu-aws-vpc-endpoint"

  vpc_id          = module.vpc.vpc_id
  service_name    = "s3"
  endpoint_type   = "Gateway"
  route_table_ids = concat(module.vpc.public_route_table_ids, module.vpc.private_route_table_ids)
}

module "public_hosted_zone" {
  source = "../../modules/tofu-aws-hosted-zone"

  hosted_zone_name     = var.public_hosted_zone_name
  enable_cloudflare    = true
}

module "private_hosted_zone" {
  source = "../../modules/tofu-aws-hosted-zone"

  hosted_zone_name     = var.private_hosted_zone_name
  private_hosted_zone  = true
  vpc_id               = module.vpc.vpc_id
}