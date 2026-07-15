output "staging_url" {
  description = "Public staging application URL."
  value       = module.environment.application_url
}

output "staging_cluster_name" {
  description = "Staging ECS cluster name."
  value       = module.environment.cluster_name
}

output "staging_service_name" {
  description = "Staging ECS service name."
  value       = module.environment.service_name
}

output "staging_task_family" {
  description = "Staging task definition family."
  value       = module.environment.task_family
}

output "staging_container_name" {
  description = "Staging application container name."
  value       = module.environment.container_name
}
