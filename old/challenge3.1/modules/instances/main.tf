resource "aws_instance" "ec2-db" {
  ami           = "ami-0ebfd941bbafe70c6"
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  tags = {
    Name = "DBServer"
  }
}

resource "aws_instance" "ec2-web" {
  ami           = "ami-0ebfd941bbafe70c6"
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "<h1>Hello from Terraform</h1>" | sudo tee /var/www/html/index.html
              EOF

  tags = {
    Name = "WebServer"
  }
}