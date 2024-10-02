provider "aws" {
  region = "us-east-1"
  
}

resource "aws_db_instance" "myRDS" {
    db_name = "myDB"
    identifier = "my-first-rds"
    instance_class = "db.t2.micro"
    allocated_storage = 20
    engine = "mariadb"
    engine_version = "10.4.32"
    username = "admin"
    password = "password123"
    port = 3306
    skip_final_snapshot = true
}