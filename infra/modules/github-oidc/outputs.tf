output "provider_arn" {
  description = "ARN of the GitHub Actions OIDC provider."
  value       = try(aws_iam_openid_connect_provider.github[0].arn, null)
}

output "provider_url" {
  description = "URL of the GitHub Actions OIDC provider."
  value       = try(aws_iam_openid_connect_provider.github[0].url, null)
}

output "staging_role_arn" {
  description = "Staging deployment role ARN."
  value       = try(aws_iam_role.deploy["staging"].arn, null)
}

output "production_role_arn" {
  description = "Production deployment role ARN."
  value       = try(aws_iam_role.deploy["production"].arn, null)
}
