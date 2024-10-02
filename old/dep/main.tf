provider "aws" {
    region = "us-east-1"  
}

#ami-0ebfd941bbafe70c6

resource "aws_instance" "db" {
    ami = "ami-0ebfd941bbafe70c6"
    instance_type = "t2.micro"
}

resource "aws_instance" "web" {
    ami = "ami-0ebfd941bbafe70c6"
    instance_type = "t2.micro"

    depends_on = [ aws_instance.db ]
}