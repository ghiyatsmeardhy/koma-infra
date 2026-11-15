
data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

data "aws_ami" "debian12" {
  most_recent = true
  owners      = ["136693071363"]

  filter {
    name   = "name"
    values = ["debian-12-amd64-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

locals {
  tipe_instance = {
    kecil  = "t3.micro"
    sedang = "t3.small"
  }
}

moved {
  from = aws_instance.web
  to   = aws_instance.layanan["web"]
}

resource "aws_instance" "layanan" {
  for_each = var.layanan

  ami                         = each.value.os == "debian12" ? data.aws_ami.debian12.id : data.aws_ami.al2023.id
  instance_type               = local.tipe_instance[each.value.ukuran]
  subnet_id                   = "subnet-0e9c82dabba5fd6ad"
  associate_public_ip_address = false

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = {
    Name  = "koma-${var.nim}-m01-${each.key}"
    peran = each.value.peran
    os    = each.value.os
  }
}
