variable "aws_region"   { type = string; default = "eu-central-1" }
variable "project"      { type = string; default = "myapp" }
variable "key_name"     { type = string; description = "Nazwa key pair w AWS" }

variable "vpc_cidr"            { type = string; default = "10.0.0.0/16" }
variable "public_subnet_cidrs" { type = list(string); default = ["10.0.1.0/24", "10.0.2.0/24"] }
variable "availability_zones"  { type = list(string); default = ["eu-central-1a", "eu-central-1b"] }

variable "jenkins_ip_cidr" { type = string; description = "IP VPS z Jenkinsem, np. 1.2.3.4/32" }
variable "admin_ip_cidr"   { type = string; description = "Twoje IP do Grafany, np. 5.6.7.8/32" }
variable "app_port"        { type = number; default = 8080 }

variable "app_instance_type"        { type = string; default = "t3.small" }
variable "monitoring_instance_type" { type = string; default = "t3.small" }
