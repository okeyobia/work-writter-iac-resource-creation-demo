variable "bucket_name" {
  description = "Globally unique name of the S3 bucket."
  type        = string
}

variable "environment" {
  description = "Environment name used for the Environment tag."
  type        = string
}

variable "force_destroy" {
  description = "Allow destroying the bucket even if it contains objects."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags applied to all resources."
  type        = map(string)
  default     = {}
}
