
output "instance" {
  description = "Informasi seluruh instance layanan"

  value = {
    for k, instance in aws_instance.layanan : k => {
      id        = instance.id
      ip_privat = instance.private_ip
      tipe      = instance.instance_type
      peran     = var.layanan[k].peran
      ukuran    = var.layanan[k].ukuran
      os        = var.layanan[k].os
    }
  }
}
