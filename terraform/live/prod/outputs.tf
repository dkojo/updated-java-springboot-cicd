# =========================
# terraform/live/prod/outputs.tf
# =========================
output "ecr_repo_url" {
  value = module.ecr.repository_url
}

output "ecs_cluster" {
  value = module.ecs.ecs_cluster_name
}

output "ecs_service" {
  value = module.ecs.ecs_service_name
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}
