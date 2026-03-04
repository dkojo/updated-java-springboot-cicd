# =========================
# terraform/modules/ecs/variables.tf
# =========================
variable "aws_region" { type = string }
variable "app_name" { type = string }
variable "container_port" { type = number }
variable "desired_count" { type = number }
variable "private_subnet_ids" { type = list(string) }

variable "ecs_security_group_id" { type = string }

variable "target_group_arn" { type = string }
variable "ecr_repository_url" { type = string }

variable "db_address" { type = string }
variable "db_secret_arn" { type = string }
