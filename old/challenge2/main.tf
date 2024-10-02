provider "aws" {
    region = "us-east-1"
}

resource "aws_vpc" "main" {
    cidr_block = "10.22.0.0/16"
    
    tags = {
        Name = "main-vpc"
    }
}

resource "aws_subnet" "main" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.22.0.0/24"
  
    tags = {
        Name = "main-subnet"
    }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "main-route-table"
  }
}

resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}

resource "aws_security_group" "main" {
  name        = "main"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.main.id  # This line is corrected

  dynamic "ingress" {
    iterator = port
    for_each = var.ingressrules
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    iterator = port
    for_each = var.egressrules
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = {
    Name = "main_sg"
  }
}

resource "aws_instance" "ec2-db" {
    ami = "ami-0ebfd941bbafe70c6"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.main.id

    tags = {
      Name = "DBServer"
    }
}

resource "aws_instance" "ec2-web" {
    ami = "ami-0ebfd941bbafe70c6"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.main.id
    security_groups = [aws_security_group.main.name]

    user_data = <<-EOF
                #!/bin/bash
                sudo yum update
                sudo yum install -y httpd
                sudo systemctl start httpd
                sudo systemctl enable httpd
                echo "<h1>Hello from Terraform</h1>" | sudo tee /var/www/html/index.html
                EOF
    tags = {
      Name = "WebServer"
    }
}

resource "aws_eip" "elasticeip" {
    instance = aws_instance.ec2-web.id
}

output "db_priv_ip" {
    value = aws_instance.ec2-db.private_ip
}
