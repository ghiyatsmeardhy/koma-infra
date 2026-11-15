variable "nim" {
  type        = string
  description = "NIM praktikan; dipakai di tag dan nama resource"
  validation {
    condition     = can(regex("^[0-9]{8,10}$", var.nim))
    error_message = "NIM harus 8-10 digit angka."
  }
}

variable "kelompok" {
  type        = string
  description = "ID kelompok kasus (k01-k05; k00 contoh dosen)"
  validation {
    condition     = can(regex("^k0[0-5]$", var.kelompok))
    error_message = "Kelompok harus k01-k05 (k00 untuk contoh dosen)."
  }
}

variable "region" {
  type        = string
  default     = "ap-southeast-2"
  description = "Region proyek AWS"
}

variable "layanan" {
  description = "Katalog komponen layanan sesuai arsitektur kasus kelompok"
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
    condition = length(var.layanan) >= 2 && length(var.layanan) <= 3 &&
      length(distinct([for item in values(var.layanan) : item.peran])) >= 2
    error_message = "Katalog harus berisi 2-3 layanan dengan sedikitnya 2 nilai peran berbeda."
  }
  validation {
    condition = alltrue([
      for k, item in var.layanan :
      can(regex("^[a-z][a-z0-9-]*$", k)) &&
      can(regex("^[a-z][a-z0-9-]*$", item.peran)) &&
      contains(["kecil", "sedang"], item.ukuran) &&
      contains(["linux", "debian12"], item.os)
    ])
    error_message = "Kunci/peran harus slug; ukuran hanya kecil/sedang; OS hanya linux/debian12."
  }
}
