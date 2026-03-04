# =========================
# terraform/modules/rds/outputs.tf
# =========================
output "db_address" { value = aws_db_instance.app.address }
output "db_secret_arn" { value = aws_secretsmanager_secret.db.arn }
