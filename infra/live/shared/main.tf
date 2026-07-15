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
  aws_region          = var.aws_region
  vpc_cidr            = var.vpc_cidr
  availability_zones  = local.availability_zones
  public_subnet_cidrs = var.public_subnet_cidrs

  private_subnet_cidrs = var.private_subnet_cidrs

  tags = {
    Component = "network"
  }
}