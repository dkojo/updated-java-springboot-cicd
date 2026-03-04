# =========================
# terraform/live/prod/main.tf
# =========================
provider "aws" {
  region = var.aws_region
}

module "security" {
  source         = "../../modules/security"
  app_name       = var.app_name
  vpc_id         = var.vpc_id
  container_port = var.container_port
}

module "alb" {
  source               = "../../modules/alb"
  app_name             = var.app_name
  vpc_id               = var.vpc_id
  public_subnet_ids    = var.public_subnet_ids
  container_port       = var.container_port
  healthcheck_path     = var.healthcheck_path
  alb_security_group_id = module.security.alb_sg_id
}

module "ecr" {
  source   = "../../modules/ecr"
  app_name = var.app_name
}

module "rds" {
  source             = "../../modules/rds"
  app_name           = var.app_name
  vpc_id             = var.vpc_id
  private_subnet_ids = var.private_subnet_ids

  ecs_security_group_id = module.security.ecs_sg_id
}

module "vpc_endpoints" {
  source             = "../../modules/vpc_endpoints"
  app_name           = var.app_name
  vpc_id             = var.vpc_id
  aws_region         = var.aws_region
  private_subnet_ids = var.private_subnet_ids

  ecs_security_group_id = module.security.ecs_sg_id
}

module "ecs" {
  source = "../../modules/ecs"

  aws_region         = var.aws_region
  app_name           = var.app_name
  container_port     = var.container_port
  desired_count      = var.desired_count
  private_subnet_ids = var.private_subnet_ids

  ecs_security_group_id = module.security.ecs_sg_id

  target_group_arn    = module.alb.target_group_arn
  ecr_repository_url  = module.ecr.repository_url

  db_address    = module.rds.db_address
  db_secret_arn = module.rds.db_secret_arn

  depends_on = [module.alb]
}

module "ec2_servers" {
  source = "../../modules/ec2_servers"

  vpc_id                    = var.vpc_id
  instance_ami              = var.instance_ami
  instance_key_name         = var.instance_key_name
  instance_subnet_id        = var.instance_subnet_id
  instance_type             = var.instance_type
  sonar_nexus_instance_type = var.sonar_nexus_instance_type
}
