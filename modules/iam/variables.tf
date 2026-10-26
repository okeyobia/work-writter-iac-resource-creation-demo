variable "role_name" {
  description = "Name of the IAM role assumed by EC2."
  type        = string
}

variable "environment" {
  description = "Environment name used for the Environment tag."
  type        = string
}

variable "s3_bucket_arn" {
  description = "ARN of the S3 bucket the role may read from and write to."
  type        = string
}

variable "tags" {
  description = "Additional tags applied to all resources."
  type        = map(string)
  default     = {}
}
