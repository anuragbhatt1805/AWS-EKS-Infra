output "public_zone_id" {
  value = var.private_hosted_zone ? null : try(aws_route53_zone.public.zone_id, null)
}

output "private_zone_id" {
  value = var.private_hosted_zone ? try(aws_route53_zone.private.zone_id, null) : null
}