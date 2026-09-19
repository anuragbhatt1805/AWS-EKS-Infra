terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project    = "AWS-EKS"
      ManagedVia = "Github"
      Owner      = "Anurag Bhatt"
      Module     = "Core"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}