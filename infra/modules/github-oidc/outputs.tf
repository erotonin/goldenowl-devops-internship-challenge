output "provider_arn" {
  description = "ARN of the GitHub Actions OIDC provider."
  value       = aws_iam_openid_connect_provider.github.arn
}

output "provider_url" {
  description = "URL of the GitHub Actions OIDC provider."
  value       = aws_iam_openid_connect_provider.github.url
}