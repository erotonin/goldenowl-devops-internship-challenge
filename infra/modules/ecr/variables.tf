variable "repository_name" {
  description = "Name of the private ECR repository."
  type        = string

  validation {
    condition = (
      length(var.repository_name) >= 2 &&
      length(var.repository_name) <= 256 &&
      can(regex("^[a-z0-9]+([._/-][a-z0-9]+)*$", var.repository_name))
    )
    error_message = "repository_name must be a valid lowercase ECR repository name."
  }
}

variable "max_image_count" {
  description = "Maximum number of images retained in the repository."
  type        = number
  default     = 30

  validation {
    condition = (
      var.max_image_count >= 10 &&
      var.max_image_count <= 1000 &&
      var.max_image_count == floor(var.max_image_count)
    )
    error_message = "max_image_count must be an integer between 10 and 1000."
  }
}

variable "untagged_retention_days" {
  description = "Number of days untagged images are retained."
  type        = number
  default     = 7

  validation {
    condition = (
      var.untagged_retention_days >= 1 &&
      var.untagged_retention_days <= 30 &&
      var.untagged_retention_days == floor(var.untagged_retention_days)
    )
    error_message = "untagged_retention_days must be an integer between 1 and 30."
  }
}

variable "tags" {
  description = "Additional tags applied to the ECR repository."
  type        = map(string)
  default     = {}
}

variable "force_delete" {
  description = "Whether repository images may be deleted with the repository during lab cleanup."
  type        = bool
  default     = true
}
