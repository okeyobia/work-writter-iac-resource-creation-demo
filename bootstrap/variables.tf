variable "aws_region" {
  description = "AWS region for the state bucket."
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name (used for the Environment tag)."
  type        = string
  default     = "shared"
}

variable "state_bucket_name" {
  description = "Globally unique name of the Terraform state bucket."
  type        = string
}
