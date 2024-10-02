terraform {
  backend "s3" {
    bucket = "csanders-backups"
    key = "terraform/tfstate.tfstate"
    region = "us-east-1"
  }
}