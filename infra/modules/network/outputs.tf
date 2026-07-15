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
