variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "Default Region for AWS Provider Setup"
}

### Github OIDC Connect
variable "oidc_provider_url" {
  type        = string
  default     = "token.actions.githubusercontent.com"
  description = "Github Default OIDC Provider URL"
}

variable "oidc_provider_audience" {
  type        = list(string)
  default     = ["sts.amazonaws.com"]
  description = "Github Default OIDC Provider Audience"
}

variable "infra_repo" {
  type        = string
  default     = "anuragbhatt1805/AWS-EKS-Infra"
  description = "Github Infra URL Repo"
}