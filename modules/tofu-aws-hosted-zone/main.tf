locals {
  hosted_zone_name = trimsuffix(var.hosted_zone_name, ".")

  domain_parts = split(".", local.hosted_zone_name)

  main_domain = join(
    ".",
    slice(
      local.domain_parts,
      length(local.domain_parts) - 2,
      length(local.domain_parts)
    )
  )
}

data "aws_region" "current" {}

data "cloudflare_zone" "public" {
  filter = {
    name = local.main_domain
  }
}

resource "aws_route53_zone" "public" {
  name = var.hosted_zone_name

  lifecycle {
    enabled = !var.private_hosted_zone
  }
}

resource "aws_route53_zone" "private" {
  name = var.hosted_zone_name

  vpc {
    vpc_id = var.vpc_id
  }

  lifecycle {
    enabled = var.private_hosted_zone
  }
}

resource "cloudflare_record" "public" {
  for_each = toset(aws_route53_zone.public.name_servers)

  zone_id = data.cloudflare_zone.public.id
  name    = var.hosted_zone_name
  value   = each.value
  type    = "NS"
  ttl     = 300

  lifecycle {
    enabled = var.enable_cloudflare && !var.private_hosted_zone
  }
}