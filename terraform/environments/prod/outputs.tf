output "app_public_ip" {
  description = "Publiczne IP instancji aplikacyjnej"
  value       = module.app.public_ip
}

output "monitoring_public_ip" {
  description = "Publiczne IP instancji monitoringu"
  value       = module.monitoring.public_ip
}

output "grafana_url" {
  description = "URL Grafany (po skonfigurowaniu Ansible)"
  value       = "http://${module.monitoring.public_ip}:3000"
}
