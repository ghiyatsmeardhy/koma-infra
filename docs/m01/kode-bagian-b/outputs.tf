output "instance_id" {
  description = "ID instance web"
  value       = aws_instance.web.id
}

output "ip_privat" {
  description = "Alamat IP privat instance web"
  value       = aws_instance.web.private_ip
}
