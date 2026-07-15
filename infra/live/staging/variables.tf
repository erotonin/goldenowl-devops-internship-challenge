variable "aws_region" {
  description = "AWS region used by the staging environment."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project identifier used for names and tags."
  type        = string
  default     = "goldenowl"
}

variable "state_bucket_name" {
  description = "S3 bucket containing shared Terraform state."
  type        = string
}

variable "shared_state_key" {
  description = "S3 object key containing shared Terraform state."
  type        = string
  default     = "goldenowl/shared/terraform.tfstate"
}

variable "container_image" {
  description = "Initial immutable application image."
  type        = string
}

variable "task_execution_role_arn" {
  description = "Learner Lab role ARN used by ECS."
  type        = string
}

variable "additional_tags" {
  description = "Additional tags applied to supported resources."
  type        = map(string)
  default     = {}
}
