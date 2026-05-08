terraform {
  required_version = ">= 1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Stan zdalny — S3 + DynamoDB lock
  # Przed pierwszym uruchomieniem utwórz bucket i tabelę ręcznie (lub skryptem bootstrap)
  backend "s3" {
    bucket         = "mateusz-1939-2024-12344321"   # <-- uzupełnij
    key            = "prod/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = local.common_tags
  }
}

locals {
  common_tags = {
    Project     = var.project
    Environment = "prod"
    ManagedBy   = "terraform"
  }
}

# ── VPC ─────────────────────────────────────────────────────────────────────
module "vpc" {
  source = "../../modules/vpc"

  project             = var.project
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  availability_zones  = var.availability_zones
  jenkins_ip_cidr     = var.jenkins_ip_cidr
  admin_ip_cidr       = var.admin_ip_cidr
  app_port            = var.app_port
  tags                = local.common_tags
}

# ── EC2 App ──────────────────────────────────────────────────────────────────
module "app" {
  source = "../../modules/ec2"

  project       = var.project
  instance_type = var.app_instance_type
  subnet_id     = module.vpc.public_subnet_ids[0]
  sg_id         = module.vpc.sg_app_id
  key_name      = var.key_name
  tags          = local.common_tags
}

# ── EC2 Monitoring ────────────────────────────────────────────────────────────
module "monitoring" {
  source = "../../modules/monitoring"

  project       = var.project
  instance_type = var.monitoring_instance_type
  subnet_id     = module.vpc.public_subnet_ids[0]
  sg_id         = module.vpc.sg_monitoring_id
  key_name      = var.key_name
  tags          = local.common_tags
}

# ── Generuj inventory dla Ansible ────────────────────────────────────────────
resource "local_file" "ansible_inventory" {
  filename        = "${path.module}/../../../ansible/inventory/hosts.ini"
  file_permission = "0644"

  content = <<-INI
    [app]
    ${module.app.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file={{ key_path }}

    [monitoring]
    ${module.monitoring.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file={{ key_path }}

    [all:vars]
    ansible_python_interpreter=/usr/bin/python3
    app_private_ip=${module.app.private_ip}
    monitoring_private_ip=${module.monitoring.private_ip}
  INI
}
