
variable "nim" {
  description = "Nomor induk mahasiswa"
  type        = string
}

variable "kelompok" {
  description = "Kode kelompok"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "layanan" {
  description = "Katalog layanan aplikasi"
  type = map(object({
    peran  = string
    ukuran = string
    os     = string
  }))

  default = {
    web = {
      peran  = "web"
      ukuran = "kecil"
      os     = "linux"
    }

    api = {
      peran  = "api"
      ukuran = "kecil"
      os     = "linux"
    }
  }

  validation {
    condition = (
      length(var.layanan) >= 2 &&
      length(var.layanan) <= 3 &&
      length(distinct([for layanan in values(var.layanan) : layanan.peran])) >= 2
    )
    error_message = "Katalog harus memiliki 2 sampai 3 layanan dengan minimal 2 peran berbeda."
  }

  validation {
    condition = alltrue([
      for nama, layanan in var.layanan :
      can(regex("^[a-z0-9-]+$", nama)) &&
      can(regex("^[a-z0-9-]+$", layanan.peran)) &&
      contains(["kecil", "sedang"], layanan.ukuran) &&
      contains(["linux", "debian12"], layanan.os)
    ])
    error_message = "Nama dan peran harus berupa slug. Ukuran hanya kecil/sedang dan OS hanya linux/debian12."
  }
}
