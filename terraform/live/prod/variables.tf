# =========================
# terraform/live/prod/variables.tf
# (All variable inputs preserved)
# =========================
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "VPC ID where resources are deployed"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnets for ALB"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Private subnets for ECS tasks"
  type        = list(string)
}

variable "app_name" {
  description = "Application name prefix"
  type        = string
  default     = "itgenuine"
}

variable "container_port" {
  description = "Container port exposed by the application"
  type        = number
  default     = 8085
}

variable "desired_count" {
  description = "Number of tasks to run"
  type        = number
  default     = 1
}

variable "healthcheck_path" {
  description = "ALB target group health check path"
  type        = string
  default     = "/"
}
