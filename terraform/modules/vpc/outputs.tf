output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "sg_app_id" {
  value = aws_security_group.app.id
}

output "sg_monitoring_id" {
  value = aws_security_group.monitoring.id
}
