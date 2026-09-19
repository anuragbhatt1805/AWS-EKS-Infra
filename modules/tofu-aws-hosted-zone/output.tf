output "public_zone_id" {
  value = var.private_hosted_zone ? null : aws_route53_zone.public.zone_id
}

output "private_zone_id" {
  value = var.private_hosted_zone ? aws_route53_zone.private.zone_id : null
}