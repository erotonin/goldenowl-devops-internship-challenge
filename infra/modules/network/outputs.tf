output "vpc_id" {
  description = "ID of the shared VPC."
  value       = aws_vpc.this.id
}

output "vpc_cidr" {
  description = "IPv4 CIDR assigned to the shared VPC."
  value       = aws_vpc.this.cidr_block
}

output "availability_zones" {
  description = "Availability zones used by the VPC."
  value       = var.availability_zones
}

output "public_subnet_ids" {
  description = "Ordered IDs of the public ALB subnets."
  value = [
    for availability_zone in var.availability_zones :
    aws_subnet.public[availability_zone].id
  ]
}

output "private_subnet_ids" {
  description = "Ordered IDs of the private ECS subnets."
  value = [
    for availability_zone in var.availability_zones :
    aws_subnet.private[availability_zone].id
  ]
}

output "private_route_table_ids" {
  description = "IDs of private route tables."
  value = [
    for availability_zone in var.availability_zones :
    aws_route_table.private[availability_zone].id
  ]
}

output "vpc_endpoint_security_group_id" {
  description = "Security group attached to interface VPC endpoints."
  value       = aws_security_group.vpc_endpoints.id
}

output "ecr_vpc_endpoint_ids" {
  description = "Map of ECR service names to VPC endpoint IDs."
  value = {
    for service, endpoint in aws_vpc_endpoint.ecr :
    service => endpoint.id
  }
}

output "s3_vpc_endpoint_id" {
  description = "ID of the S3 gateway endpoint."
  value       = aws_vpc_endpoint.s3.id
}