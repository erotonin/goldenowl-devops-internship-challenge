variable "name" {
  description = "Name used by ECS and load-balancing resources."
  type        = string
}

variable "environment" {
  description = "Deployment environment name."
  type        = string
}

variable "vpc_id" {
  description = "VPC containing the service."
  type        = string
}

variable "subnet_ids" {
  description = "Two public subnet IDs spanning distinct availability zones."
  type        = list(string)

  validation {
    condition     = length(var.subnet_ids) >= 2
    error_message = "At least two subnet IDs must be supplied."
  }
}

variable "container_image" {
  description = "Immutable container image reference."
  type        = string

  validation {
    condition     = can(regex("@sha256:[a-f0-9]{64}$", var.container_image))
    error_message = "container_image must use an immutable sha256 digest."
  }
}

variable "container_name" {
  description = "Container name used by the ECS task definition."
  type        = string
  default     = "app"
}

variable "container_port" {
  description = "Application container port."
  type        = number
  default     = 3000
}

variable "health_check_path" {
  description = "ALB health check path."
  type        = string
  default     = "/"
}

variable "cpu" {
  description = "Fargate task CPU units."
  type        = number
  default     = 256
}

variable "memory" {
  description = "Fargate task memory in MiB."
  type        = number
  default     = 512
}

variable "desired_count" {
  description = "Initial desired task count."
  type        = number
  default     = 1
}

variable "minimum_count" {
  description = "Minimum service task count."
  type        = number
  default     = 1
}

variable "maximum_count" {
  description = "Maximum service task count."
  type        = number
  default     = 2
}

variable "autoscaling_cpu_target" {
  description = "Average CPU target used by ECS Service Auto Scaling."
  type        = number
  default     = 60
}

variable "scale_out_cooldown" {
  description = "Scale-out cooldown in seconds."
  type        = number
  default     = 60
}

variable "scale_in_cooldown" {
  description = "Scale-in cooldown in seconds."
  type        = number
  default     = 300
}

variable "task_execution_role_arn" {
  description = "Existing ECS task execution role ARN."
  type        = string

  validation {
    condition     = can(regex("^arn:[^:]+:iam::[0-9]{12}:role/.+$", var.task_execution_role_arn))
    error_message = "task_execution_role_arn must be a valid IAM role ARN."
  }
}

variable "tags" {
  description = "Additional tags applied to resources."
  type        = map(string)
  default     = {}
}
