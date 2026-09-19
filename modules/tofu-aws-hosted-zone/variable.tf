variable "enable_cloudflare" {
  type        = bool
  default     = false
  description = "Add Cloudflare Records for the hosted zone"
}

variable "hosted_zone_name" {
  type        = string
  description = "The name of the hosted zone"
}

variable "private_hosted_zone" {
  type        = bool
  default     = false
  description = "Whether the hosted zone is private or public"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID to associate with the private hosted zone"
  default     = null
}