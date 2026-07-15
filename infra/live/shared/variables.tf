variable "aws_region" {
  description = "AWS region used for shared infrastructure."
  type        = string
  default     = "ap-southeast-1"
}

variable "project_name" {
  description = "Project identifier used for names and tags."
  type        = string
  default     = "goldenowl"
}

variable "vpc_cidr" {
  description = "IPv4 CIDR assigned to the shared VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "IPv4 CIDRs for public ALB subnets."
  type        = list(string)

  default = [
    "10.0.0.0/24",
    "10.0.1.0/24",
  ]
}

variable "private_subnet_cidrs" {
  description = "IPv4 CIDRs for private ECS task subnets."
  type        = list(string)

  default = [
    "10.0.10.0/24",
    "10.0.11.0/24",
  ]
}

variable "additional_tags" {
  description = "Additional tags applied to supported AWS resources."
  type        = map(string)
  default     = {}
}