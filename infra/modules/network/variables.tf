variable "name_prefix" {
  description = "Prefix used to name network resources."
  type        = string

  validation {
    condition = (
      length(var.name_prefix) >= 3 &&
      length(var.name_prefix) <= 32 &&
      can(regex("^[a-z0-9][a-z0-9-]*[a-z0-9]$", var.name_prefix))
    )
    error_message = "name_prefix must contain 3-32 lowercase letters, numbers, or hyphens."
  }
}

variable "aws_region" {
  description = "AWS region containing the VPC."
  type        = string
}

variable "vpc_cidr" {
  description = "IPv4 CIDR assigned to the VPC."
  type        = string

  validation {
    condition     = can(cidrnetmask(var.vpc_cidr))
    error_message = "vpc_cidr must be a valid IPv4 CIDR."
  }
}

variable "availability_zones" {
  description = "Two availability zones used by the network."
  type        = list(string)

  validation {
    condition = (
      length(var.availability_zones) == 2 &&
      length(distinct(var.availability_zones)) == 2
    )
    error_message = "Exactly two distinct availability zones must be supplied."
  }
}

variable "public_subnet_cidrs" {
  description = "IPv4 CIDRs for public ALB subnets."
  type        = list(string)

  validation {
    condition = (
      length(var.public_subnet_cidrs) == 2 &&
      alltrue([
        for cidr in var.public_subnet_cidrs :
        can(cidrnetmask(cidr))
      ])
    )
    error_message = "Exactly two valid public subnet CIDRs must be supplied."
  }
}

variable "private_subnet_cidrs" {
  description = "IPv4 CIDRs for private ECS task subnets."
  type        = list(string)

  validation {
    condition = (
      length(var.private_subnet_cidrs) == 2 &&
      alltrue([
        for cidr in var.private_subnet_cidrs :
        can(cidrnetmask(cidr))
      ])
    )
    error_message = "Exactly two valid private subnet CIDRs must be supplied."
  }
}

variable "tags" {
  description = "Additional tags applied to network resources."
  type        = map(string)
  default     = {}
}