# =========================
# terraform/modules/alb/variables.tf
# =========================
variable "app_name" { type = string }
variable "vpc_id" { type = string }
variable "public_subnet_ids" { type = list(string) }
variable "container_port" { type = number }
variable "healthcheck_path" { type = string }
variable "alb_security_group_id" { type = string }
