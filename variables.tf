variable "aws_region" {
  description = "AWS region to deploy into."
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name (used for the Environment tag)."
  type        = string
}

variable "project_name" {
  description = "Project name used as a resource name prefix."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets."
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets."
  type        = list(string)
}

variable "bucket_name" {
  description = "Globally unique name for the application S3 bucket."
  type        = string
}

variable "bucket_force_destroy" {
  description = "Allow destroying the application bucket while it contains objects."
  type        = bool
  default     = false
}
