data "terraform_remote_state" "shared" {
  backend = "s3"

  config = {
    bucket       = var.state_bucket_name
    key          = var.shared_state_key
    region       = var.aws_region
    encrypt      = true
    use_lockfile = true
  }
}

module "environment" {
  source = "../../modules/ecs-environment"

  name                    = "${var.project_name}-production"
  environment             = "production"
  vpc_id                  = data.terraform_remote_state.shared.outputs.vpc_id
  subnet_ids              = data.terraform_remote_state.shared.outputs.public_subnet_ids
  container_image         = var.container_image
  container_name          = "app"
  desired_count           = 2
  minimum_count           = 2
  maximum_count           = 4
  autoscaling_cpu_target  = 60
  scale_out_cooldown      = 60
  scale_in_cooldown       = 300
  task_execution_role_arn = var.task_execution_role_arn

  tags = {
    Component = "application"
  }
}
