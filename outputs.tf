output "vpc_id" {
  description = "ID of the VPC."
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets."
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the private subnets."
  value       = module.vpc.private_subnet_ids
}

output "bucket_arn" {
  description = "ARN of the application S3 bucket."
  value       = module.s3_storage.bucket_arn
}

output "app_role_arn" {
  description = "ARN of the EC2 application IAM role."
  value       = module.iam_app_role.role_arn
}

output "app_instance_profile_name" {
  description = "Instance profile name for the EC2 application role."
  value       = module.iam_app_role.instance_profile_name
}
