output "vpc_id" {
  description = "ID of the shared VPC."
  value       = module.network.vpc_id
}

output "vpc_cidr" {
  description = "CIDR assigned to the shared VPC."
  value       = module.network.vpc_cidr
}

output "availability_zones" {
  description = "Availability zones used by shared infrastructure."
  value       = module.network.availability_zones
}

output "public_subnet_ids" {
  description = "Public subnet IDs used by load balancers."
  value       = module.network.public_subnet_ids
}

output "ecr_repository_name" {
  description = "Name of the application ECR repository."
  value       = module.ecr.repository_name
}

output "ecr_repository_arn" {
  description = "ARN of the application ECR repository."
  value       = module.ecr.repository_arn
}

output "ecr_repository_url" {
  description = "URL of the application ECR repository."
  value       = module.ecr.repository_url
}

output "ecr_registry_id" {
  description = "AWS account registry ID."
  value       = module.ecr.registry_id
}

output "github_oidc_provider_arn" {
  description = "ARN of the GitHub Actions OIDC provider."
  value       = module.github_oidc.provider_arn
}

output "github_oidc_provider_url" {
  description = "URL of the GitHub Actions OIDC provider."
  value       = module.github_oidc.provider_url
}

output "staging_deploy_role_arn" {
  description = "GitHub Actions staging deployment role ARN when OIDC is enabled."
  value       = module.github_oidc.staging_role_arn
}

output "production_deploy_role_arn" {
  description = "GitHub Actions production deployment role ARN when OIDC is enabled."
  value       = module.github_oidc.production_role_arn
}

output "approved_image_parameter" {
  description = "SSM parameter used for artifact promotion."
  value       = var.approved_image_parameter
}
