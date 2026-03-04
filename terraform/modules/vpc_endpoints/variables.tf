# =========================
# terraform/modules/vpc_endpoints/variables.tf
# =========================
variable "app_name" { type = string }
variable "vpc_id" { type = string }
variable "aws_region" { type = string }
variable "private_subnet_ids" { type = list(string) }
variable "ecs_security_group_id" { type = string }
