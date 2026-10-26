output "role_arn" {
  description = "ARN of the IAM role."
  value       = aws_iam_role.this.arn
}

output "role_name" {
  description = "Name of the IAM role."
  value       = aws_iam_role.this.name
}

output "policy_arn" {
  description = "ARN of the S3 access policy."
  value       = aws_iam_policy.s3_access.arn
}

output "instance_profile_name" {
  description = "Name of the EC2 instance profile."
  value       = aws_iam_instance_profile.this.name
}
