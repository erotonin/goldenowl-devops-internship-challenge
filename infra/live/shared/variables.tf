variable "aws_region" {
  description = "AWS region used for shared infrastructure."
  type        = string
  default     = "us-east-1"
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

variable "additional_tags" {
  description = "Additional tags applied to supported AWS resources."
  type        = map(string)
  default     = {}
}

variable "ecr_repository_name" {
  description = "Name of the application ECR repository."
  type        = string
  default     = "goldenowl-app"
}

variable "ecr_max_image_count" {
  description = "Maximum number of images retained in ECR."
  type        = number
  default     = 30
}

variable "ecr_untagged_retention_days" {
  description = "Number of days untagged images are retained."
  type        = number
  default     = 7
}
