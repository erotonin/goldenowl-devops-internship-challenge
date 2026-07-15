data "aws_availability_zones" "available" {
  state = "available"
}

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
