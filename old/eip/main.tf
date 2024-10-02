provider "aws" {
    region = "us-east-1"  
}

#ami-0ebfd941bbafe70c6

resource "aws_instance" "ec2" {
    ami = "ami-0ebfd941bbafe70c6"
    instance_type = "t2.micro"

}

resource "aws_eip" "elasticeip" {
    instance = aws_instance.ec2.id
}

output "EIP" {
    value = aws_eip.elasticeip.public_ip
}