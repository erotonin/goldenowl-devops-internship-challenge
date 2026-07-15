variable "enabled" {
  description = "Whether GitHub OIDC resources are created."
  type        = bool
  default     = false
}

variable "aws_account_id" {
  description = "AWS account containing deployment resources."
  type        = string
}

variable "aws_region" {
  description = "AWS region containing deployment resources."
  type        = string
}

variable "project_name" {
  description = "Project identifier used in ECS resource names."
  type        = string
}

variable "github_repository" {
  description = "GitHub repository in owner/name format."
  type        = string

  validation {
    condition     = can(regex("^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$", var.github_repository))
    error_message = "github_repository must use owner/name format."
  }
}

variable "ecr_repository_arn" {
  description = "ECR repository used by deployment workflows."
  type        = string
}

variable "task_execution_role_arn" {
  description = "ECS task execution role passed during task definition registration."
  type        = string
}

variable "task_role_arn" {
  description = "Optional ECS application task role passed during task definition registration."
  type        = string
  default     = ""
}

variable "approved_image_parameter" {
  description = "SSM parameter containing the staging-approved image."
  type        = string
}

variable "tags" {
  description = "Additional tags applied to the GitHub OIDC provider."
  type        = map(string)
  default     = {}
}
