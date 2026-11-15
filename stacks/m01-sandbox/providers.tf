
provider "aws" {
  region = var.region

  default_tags {
    tags = {
      kursus     = "komputasi-awan"
      nim        = var.nim
      kelompok   = var.kelompok
      modul      = "m01"
      stack      = "m01-sandbox"
      managed-by = "opentofu"
    }
  }
}
