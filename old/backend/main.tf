provider "aws" {
  region = "us-east-1" 
}

resource "aws_vpc" "testVPC" {
  cidr_block = "10.23.0.0/16"
}