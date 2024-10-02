output "db_private_ip" {
  value = aws_instance.ec2-db.private_ip
}

output "web_instance_id" {
  value = aws_instance.ec2-web.id
}