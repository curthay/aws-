provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "csanders-backups"
    key    = "basic build/terraform/state/terraform.tfstate"
    region = "us-east-1"  # Replace with your desired AWS region
  }
}

module "networking" {
  source = "./modules/networking"
  vpc_cidr = "10.22.0.0/16"
  subnet_cidr = "10.22.0.0/24"
}

module "security" {
  source = "./modules/security"
  vpc_id = module.networking.vpc_id
  ingressrules = var.ingressrules
  egressrules = var.egressrules
}