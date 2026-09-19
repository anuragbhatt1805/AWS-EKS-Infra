variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "Default Region for AWS Provider Setup"
}

variable "aws_availability_zones" {
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
  description = "Default Availability Zones for AWS Provider Setup"
}

variable "cloudflare_api_token" {
  description = "Cloudflare API token"
  type        = string
  sensitive   = true
}

variable "public_hosted_zone_name" {
  type        = string
  description = "The name of the public hosted zone"
  default     = null
}

variable "private_hosted_zone_name" {
  type        = string
  description = "The name of the private hosted zone"
  default     = null
}