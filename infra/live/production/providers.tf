provider "aws" {
  region = var.aws_region

  default_tags {
    tags = merge(var.additional_tags, {
      ManagedBy   = "Terraform"
      Project     = var.project_name
      Repository  = "goldenowl-devops-internship-challenge"
      Environment = "production"
      Stack       = "production"
    })
  }
}
