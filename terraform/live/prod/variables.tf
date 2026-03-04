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

variable "instance_ami" {
  description = "AMI ID for the instances"
  type        = string
  default     = "ami-0f3caa1cf4417e51b"
}

variable "instance_key_name" {
  description = "An Existing Keypair to be used for the instances"
  type        = string
  default     = "itgkey"
}

variable "instance_subnet_id" {
  description = "Public Subnet ID for the instances"
  type        = string
  default     = "subnet-0305d0946c139cda7"
}

variable "instance_type" {
  description = "The Instance type"
  type        = string
  default     = "t2.micro"
}

variable "sonar_nexus_instance_type" {
  description = "The Instance type"
  type        = string
  default     = "t2.medium"
}
