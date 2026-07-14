output "aws_account_id" {
  description = "AWS account that owns the Terraform state bucket."
  value       = data.aws_caller_identity.current.account_id
}

output "state_bucket_name" {
  description = "Name of the S3 bucket that stores Terraform state."
  value       = aws_s3_bucket.terraform_state.id
}

output "state_bucket_arn" {
  description = "ARN of the S3 bucket that stores Terraform state."
  value       = aws_s3_bucket.terraform_state.arn
}

output "state_bucket_region" {
  description = "AWS region containing the Terraform state bucket."
  value       = var.aws_region
}

output "backend_configuration" {
  description = "Non-sensitive values required by S3 backend configurations."

  value = {
    bucket       = aws_s3_bucket.terraform_state.id
    region       = var.aws_region
    encrypt      = true
    use_lockfile = true
  }
}