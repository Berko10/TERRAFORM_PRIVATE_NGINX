output "custom_message" {
  description = "Custom message for Dockerized Nginx"
  value = "dockerized nginx through nat url: ${aws_instance.nat.public_ip}\nprivate machine ip: ${aws_instance.nginx.private_ip}"
}

