variable "aws_region" {
  description = "AWS region used to store Terraform state."
  type        = string
  default     = "ap-southeast-1"

  validation {
    condition     = can(regex("^[a-z]{2}(-[a-z]+)+-[0-9]$", var.aws_region))
    error_message = "aws_region must be a valid AWS region name."
  }
}

variable "project_name" {
  description = "Project identifier used for resource names and tags."
  type        = string
  default     = "goldenowl"

  validation {
    condition = (
      length(var.project_name) >= 3 &&
      length(var.project_name) <= 24 &&
      can(regex("^[a-z0-9][a-z0-9-]*[a-z0-9]$", var.project_name))
    )
    error_message = "project_name must contain 3-24 lowercase letters, numbers, or hyphens."
  }
}

variable "state_bucket_prefix" {
  description = "Prefix for the globally unique Terraform state bucket."
  type        = string
  default     = "goldenowl-terraform-state"

  validation {
    condition = (
      length(var.state_bucket_prefix) >= 3 &&
      length(var.state_bucket_prefix) <= 34 &&
      can(regex("^[a-z0-9][a-z0-9-]*[a-z0-9]$", var.state_bucket_prefix))
    )
    error_message = "state_bucket_prefix must contain 3-34 lowercase letters, numbers, or hyphens."
  }
}

variable "additional_tags" {
  description = "Additional tags applied to supported AWS resources."
  type        = map(string)
  default     = {}
}