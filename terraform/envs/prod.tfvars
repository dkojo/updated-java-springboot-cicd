# =========================
# terraform/envs/prod.tfvars
# =========================
aws_region = "us-east-1"
vpc_id     = "vpc-060d68cf8f4f0ff4b"

private_subnet_ids = [
  "subnet-085dd956e5b639f40",
  "subnet-029b9641533fc3b1e"
]

public_subnet_ids = [
  "subnet-0305d0946c139cda7",
  "subnet-0413b34ddd5fbc136"
]

app_name         = "itgenuine"
container_port   = 8085
desired_count    = 1
healthcheck_path = "/"
