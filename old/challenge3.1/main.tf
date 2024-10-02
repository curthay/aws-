provider "aws" {
  region = "us-east-1"
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

module "instances" {
  source = "./modules/instances"
  subnet_id = module.networking.subnet_id
  security_group_id = module.security.security_group_id
  instance_type = "t2.micro"
}

resource "aws_eip" "elasticeip" {
  instance = module.instances.web_instance_id
}