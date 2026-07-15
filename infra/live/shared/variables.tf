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

variable "enable_github_oidc" {
  description = "Whether to create GitHub OIDC deployment roles."
  type        = bool
  default     = false
}

variable "github_repository" {
  description = "GitHub repository trusted by deployment roles."
  type        = string
  default     = "erotonin/goldenowl-devops-internship-challenge"
}

variable "task_execution_role_arn" {
  description = "ECS task execution role ARN that deployment workflows may pass."
  type        = string
  default     = ""
}

variable "task_role_arn" {
  description = "Optional ECS application task role ARN that deployment workflows may pass."
  type        = string
  default     = ""
}

variable "approved_image_parameter" {
  description = "SSM parameter that stores the staging-approved image digest."
  type        = string
  default     = "/goldenowl/staging/approved-image"
}
