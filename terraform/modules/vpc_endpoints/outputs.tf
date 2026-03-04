# =========================
# terraform/modules/vpc_endpoints/outputs.tf
# =========================
output "vpce_sg_id" { value = aws_security_group.vpce_sg.id }
