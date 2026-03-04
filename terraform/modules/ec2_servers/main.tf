# terraform/modules/ec2_servers/main.tf
# real security groups + 6 EC2 instances

locals {
  ssh_cidr = "0.0.0.0/0"
}

# ----------------------------
# Security Groups (real ports)
# ----------------------------

# Ansible: SSH only
resource "aws_security_group" "ansible_sg" {
  name   = "ansible_sg"
  vpc_id = var.vpc_id

  ingress { from_port = 22 to_port = 22 protocol = "tcp" cidr_blocks = [local.ssh_cidr] }
  egress  { from_port = 0  to_port = 0  protocol = "-1"  cidr_blocks = ["0.0.0.0/0"] }
}

# Monitoring: SSH + Grafana(3000) + Prometheus(9090)
resource "aws_security_group" "monitoring_sg" {
  name   = "monitoring_sg"
  vpc_id = var.vpc_id

  ingress { from_port = 22   to_port = 22   protocol = "tcp" cidr_blocks = [local.ssh_cidr] }
  ingress { from_port = 3000 to_port = 3000 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"] }
  ingress { from_port = 9090 to_port = 9090 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"] }

  egress  { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["0.0.0.0/0"] }
}

# Monolithic: SSH + HTTP/HTTPS
resource "aws_security_group" "monolithic_sg" {
  name   = "monolithic_sg"
  vpc_id = var.vpc_id

  ingress { from_port = 22  to_port = 22  protocol = "tcp" cidr_blocks = [local.ssh_cidr] }
  ingress { from_port = 80  to_port = 80  protocol = "tcp" cidr_blocks = ["0.0.0.0/0"] }
  ingress { from_port = 443 to_port = 443 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"] }

  egress  { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["0.0.0.0/0"] }
}

# Nexus: SSH + 8081
resource "aws_security_group" "nexus_sg" {
  name   = "nexus_sg"
  vpc_id = var.vpc_id

  ingress { from_port = 22   to_port = 22   protocol = "tcp" cidr_blocks = [local.ssh_cidr] }
  ingress { from_port = 8081 to_port = 8081 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"] }

  egress  { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["0.0.0.0/0"] }
}

# SonarQube: SSH + 9000
resource "aws_security_group" "sonarqube_sg" {
  name   = "sonarqube_sg"
  vpc_id = var.vpc_id

  ingress { from_port = 22   to_port = 22   protocol = "tcp" cidr_blocks = [local.ssh_cidr] }
  ingress { from_port = 9000 to_port = 9000 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"] }

  egress  { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["0.0.0.0/0"] }
}

# ----------------------------
# EC2 Instances
# ----------------------------

resource "aws_instance" "ansible_server" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  key_name                    = var.instance_key_name
  vpc_security_group_ids      = [aws_security_group.ansible_sg.id]
  subnet_id                   = var.instance_subnet_id
  associate_public_ip_address = true

  tags = { Name = "ansible_server" }
}

resource "aws_instance" "grafana_server" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  key_name                    = var.instance_key_name
  vpc_security_group_ids      = [aws_security_group.monitoring_sg.id]
  subnet_id                   = var.instance_subnet_id
  associate_public_ip_address = true

  tags = { Name = "grafana_server" }
}

resource "aws_instance" "monolithic_server" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  key_name                    = var.instance_key_name
  vpc_security_group_ids      = [aws_security_group.monolithic_sg.id]
  subnet_id                   = var.instance_subnet_id
  associate_public_ip_address = true

  tags = { Name = "monolithic_server" }
}

resource "aws_instance" "nexus_server" {
  ami                         = var.instance_ami
  instance_type               = var.sonar_nexus_instance_type
  key_name                    = var.instance_key_name
  vpc_security_group_ids      = [aws_security_group.nexus_sg.id]
  subnet_id                   = var.instance_subnet_id
  associate_public_ip_address = true

  tags = { Name = "nexus_server" }
}

resource "aws_instance" "prometheus_server" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  key_name                    = var.instance_key_name
  vpc_security_group_ids      = [aws_security_group.monitoring_sg.id]
  subnet_id                   = var.instance_subnet_id
  associate_public_ip_address = true

  tags = { Name = "prometheus_server" }
}

resource "aws_instance" "sonarqube_server" {
  ami                         = var.instance_ami
  instance_type               = var.sonar_nexus_instance_type
  key_name                    = var.instance_key_name
  vpc_security_group_ids      = [aws_security_group.sonarqube_sg.id]
  subnet_id                   = var.instance_subnet_id
  associate_public_ip_address = true

  tags = { Name = "sonarqube_server" }
}
