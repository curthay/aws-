# provider.tf
terraform {
  required_version = ">= 0.13"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"  # Use the latest compatible version
    }
  }
}

provider "aws" {
  region = var.region
}