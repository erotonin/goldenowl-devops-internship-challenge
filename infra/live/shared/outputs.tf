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

output "private_subnet_ids" {
  description = "Private subnet IDs used by ECS tasks."
  value       = module.network.private_subnet_ids
}

output "vpc_endpoint_security_group_id" {
  description = "Security group attached to interface endpoints."
  value       = module.network.vpc_endpoint_security_group_id
}

output "ecr_vpc_endpoint_ids" {
  description = "ECR interface endpoint IDs."
  value       = module.network.ecr_vpc_endpoint_ids
}

output "s3_vpc_endpoint_id" {
  description = "S3 gateway endpoint ID."
  value       = module.network.s3_vpc_endpoint_id
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