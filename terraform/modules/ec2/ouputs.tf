output "app_eip" {
  value = aws_eip.web_addr.public_ip
}

output "app_instance" {
    value = aws_instance.web_server.id
}