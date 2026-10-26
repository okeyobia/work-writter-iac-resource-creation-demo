variable "name" {
  description = "Name prefix applied to VPC resources."
  type        = string
}

variable "environment" {
  description = "Environment name used for the Environment tag."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets, one per availability zone."
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets, one per availability zone."
  type        = list(string)
}

variable "tags" {
  description = "Additional tags applied to all resources."
  type        = map(string)
  default     = {}
}
