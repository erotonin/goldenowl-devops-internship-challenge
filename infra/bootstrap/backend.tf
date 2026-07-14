terraform {
  backend "s3" {
    bucket       = "goldenowl-terraform-state-373515082055-ap-southeast-1"
    key          = "goldenowl/bootstrap/terraform.tfstate"
    region       = "ap-southeast-1"
    encrypt      = true
    use_lockfile = true
  }
}