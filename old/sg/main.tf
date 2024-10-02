provider "aws" {
    region = "us-east-1"  
}

#ami-0ebfd941bbafe70c6

variable "ingressrules" {
    type = list(number)
    default = [ 80,443 ]
}
variable "egressrules" {
    type = list(number)
    default = [ 80,443,25,3306,53,8080 ]
}

resource "aws_security_group" "webtraffic" {
  name        = "webtraffic"
  description = "Allow SSH inbound traffic"

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
    Name = "allow_ssh"
  }
}

resource "aws_instance" "ec2" {
    ami = "ami-0ebfd941bbafe70c6"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.webtraffic.id]
}

resource "aws_eip" "elasticeip" {
    instance = aws_instance.ec2.id
}

output "EIP" {
    value = aws_eip.elasticeip.public_ip
}

