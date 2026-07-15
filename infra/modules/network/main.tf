locals {
  public_subnets = {
    for index, availability_zone in var.availability_zones :
    availability_zone => {
      cidr = var.public_subnet_cidrs[index]
    }
  }

  private_subnets = {
    for index, availability_zone in var.availability_zones :
    availability_zone => {
      cidr = var.private_subnet_cidrs[index]
    }
  }

  ecr_endpoint_services = toset([
    "ecr.api",
    "ecr.dkr",
  ])
}

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-vpc"
  })
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-igw"
  })
}

resource "aws_subnet" "public" {
  for_each = local.public_subnets

  vpc_id                  = aws_vpc.this.id
  availability_zone       = each.key
  cidr_block              = each.value.cidr
  map_public_ip_on_launch = false

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-public-${each.key}"
    Tier = "public"
  })
}

resource "aws_subnet" "private" {
  for_each = local.private_subnets

  vpc_id                  = aws_vpc.this.id
  availability_zone       = each.key
  cidr_block              = each.value.cidr
  map_public_ip_on_launch = false

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-private-${each.key}"
    Tier = "private"
  })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-public"
  })
}

resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  for_each = local.private_subnets

  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-private-${each.key}"
  })
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[each.key].id
}

resource "aws_security_group" "vpc_endpoints" {
  name_prefix            = "${var.name_prefix}-endpoints-"
  description            = "Allow HTTPS from private subnets to VPC endpoints"
  vpc_id                 = aws_vpc.this.id
  revoke_rules_on_delete = true

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-vpc-endpoints"
  })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_ingress_rule" "endpoint_https" {
  for_each = toset(var.private_subnet_cidrs)

  security_group_id = aws_security_group.vpc_endpoints.id
  description       = "HTTPS from private workload subnet ${each.value}"
  cidr_ipv4         = each.value
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

resource "aws_vpc_endpoint" "ecr" {
  for_each = local.ecr_endpoint_services

  vpc_id              = aws_vpc.this.id
  service_name        = "com.amazonaws.${var.aws_region}.${each.value}"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  ip_address_type     = "ipv4"

  subnet_ids = [
    for availability_zone in var.availability_zones :
    aws_subnet.private[availability_zone].id
  ]

  security_group_ids = [
    aws_security_group.vpc_endpoints.id,
  ]

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-${replace(each.value, ".", "-")}"
  })
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    for availability_zone in var.availability_zones :
    aws_route_table.private[availability_zone].id
  ]

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-s3"
  })
}