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