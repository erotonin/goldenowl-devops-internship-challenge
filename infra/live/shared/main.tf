data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_caller_identity" "current" {}

locals {
  availability_zones = slice(
    sort(data.aws_availability_zones.available.names),
    0,
    2,
  )
}

module "network" {
  source = "../../modules/network"

  name_prefix         = var.project_name
  vpc_cidr            = var.vpc_cidr
  availability_zones  = local.availability_zones
  public_subnet_cidrs = var.public_subnet_cidrs

  tags = {
    Component = "network"
  }
}

module "ecr" {
  source = "../../modules/ecr"

  repository_name         = var.ecr_repository_name
  max_image_count         = var.ecr_max_image_count
  untagged_retention_days = var.ecr_untagged_retention_days
  force_delete            = true

  tags = {
    Component = "container-registry"
  }
}

module "github_oidc" {
  source = "../../modules/github-oidc"

  enabled                  = var.enable_github_oidc
  aws_account_id           = data.aws_caller_identity.current.account_id
  aws_region               = var.aws_region
  project_name             = var.project_name
  github_repository        = var.github_repository
  ecr_repository_arn       = module.ecr.repository_arn
  task_execution_role_arn  = var.task_execution_role_arn
  task_role_arn            = var.task_role_arn
  approved_image_parameter = var.approved_image_parameter

  tags = {
    Component = "github-oidc"
  }
}
