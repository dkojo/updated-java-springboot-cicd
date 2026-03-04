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

output "ansible_public_ip" { value = module.ec2_servers.ansible_public_ip }
output "grafana_public_ip" { value = module.ec2_servers.grafana_public_ip }
output "monolithic_public_ip" { value = module.ec2_servers.monolithic_public_ip }
output "nexus_public_ip" { value = module.ec2_servers.nexus_public_ip }
output "prometheus_public_ip" { value = module.ec2_servers.prometheus_public_ip }
output "sonarqube_public_ip" { value = module.ec2_servers.sonarqube_public_ip }
