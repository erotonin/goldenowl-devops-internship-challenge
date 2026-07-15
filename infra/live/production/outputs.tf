output "production_url" {
  description = "Public production application URL."
  value       = module.environment.application_url
}

output "production_cluster_name" {
  description = "Production ECS cluster name."
  value       = module.environment.cluster_name
}

output "production_service_name" {
  description = "Production ECS service name."
  value       = module.environment.service_name
}

output "production_task_family" {
  description = "Production task definition family."
  value       = module.environment.task_family
}

output "production_container_name" {
  description = "Production application container name."
  value       = module.environment.container_name
}
