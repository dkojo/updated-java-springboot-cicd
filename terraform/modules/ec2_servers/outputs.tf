output "ansible_public_ip" { value = aws_instance.ansible_server.public_ip }
output "grafana_public_ip" { value = aws_instance.grafana_server.public_ip }
output "monolithic_public_ip" { value = aws_instance.monolithic_server.public_ip }
output "nexus_public_ip" { value = aws_instance.nexus_server.public_ip }
output "prometheus_public_ip" { value = aws_instance.prometheus_server.public_ip }
output "sonarqube_public_ip" { value = aws_instance.sonarqube_server.public_ip }
