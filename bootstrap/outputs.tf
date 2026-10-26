output "state_bucket_name" {
  description = "Name of the state bucket; use as `bucket` in the root backend block."
  value       = aws_s3_bucket.state.id
}

output "state_bucket_arn" {
  description = "ARN of the state bucket."
  value       = aws_s3_bucket.state.arn
}

output "backend_init_command" {
  description = "Command to initialise the root module against this bucket."
  value       = "terraform init -backend-config=\"bucket=${aws_s3_bucket.state.id}\" -backend-config=\"region=${var.aws_region}\""
}
