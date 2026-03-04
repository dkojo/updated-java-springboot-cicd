# =========================
# terraform/live/prod/backend.tf
# =========================
terraform {
  backend "s3" {
    bucket         = "itgenuine-tf-state-us-east-1"
    key            = "app/prod.tfstate"
    region         = "us-east-1"
    dynamodb_table = "itgenuine-tf-lock"
    encrypt        = true
  }
}
