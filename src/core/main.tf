data "aws_region" "current" {}

module "vpc" {
  source = "../../modules/tofu-aws-vpc"

  aws_region             = var.aws_region
  aws_availability_zones = var.aws_availability_zones
}