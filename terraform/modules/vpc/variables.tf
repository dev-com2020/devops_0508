variable "project" {
  description = "Prefix dla wszystkich zasobów"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR blok VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Lista CIDRów dla publicznych subnetów"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "availability_zones" {
  description = "Lista AZ odpowiadających subnetom"
  type        = list(string)
}

variable "jenkins_ip_cidr" {
  description = "IP maszyny z Jenkinsem (dostęp SSH) np. 1.2.3.4/32"
  type        = string
}

variable "admin_ip_cidr" {
  description = "IP admina (dostęp do Grafany/Prometheusa)"
  type        = string
}

variable "app_port" {
  description = "Port na którym nasłuchuje aplikacja"
  type        = number
  default     = 8080
}

variable "tags" {
  description = "Tagi wspólne dla wszystkich zasobów"
  type        = map(string)
  default     = {}
}
