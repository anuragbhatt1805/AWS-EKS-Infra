variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
}

variable "service_name" {
  type        = string
  description = "The name of the service for which the VPC endpoint is being created"
}

variable "endpoint_type" {
  type        = string
  description = "The type of VPC endpoint (Interface or Gateway)"
  default     = "Interface"
}

variable "route_table_ids" {
  type        = list(string)
  description = "A list of route table IDs for the VPC endpoint"
  default     = []
}