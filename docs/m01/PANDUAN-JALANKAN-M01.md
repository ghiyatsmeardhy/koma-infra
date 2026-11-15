# Panduan menjalankan Modul 01 (Windows PowerShell)

Jalankan dari root `koma-infra`. Pastikan AWS CLI, OpenTofu, Python, dan Git tersedia. Jangan tempel kredensial AWS ke repo.

## 0. Identitas dan autentikasi

```powershell
py alat\koma.py init --nim 124450067 --kelompok k02 --region ap-southeast-2
py alat\koma.py info
aws sts get-caller-identity
```

Jika sesi AWS kedaluwarsa, autentikasi ulang sesuai profil yang diberikan di kelas (misalnya `aws sso login` bila memakai AWS IAM Identity Center). Pastikan akun yang aktif benar sebelum membuat resource.

## 1. Fondasi anggaran (sekali saja; jangan di-destroy)

Berkas `stacks/m00-fondasi/terraform.tfvars` sudah disiapkan untuk NIM/kelompok dan email peringatan yang sebelumnya kamu gunakan. Periksa emailnya sebelum apply.

```powershell
cd stacks/m00-fondasi
tofu init
tofu fmt
tofu validate
tofu plan -out m00.tfplan
tofu apply m00.tfplan
cd ../..
```

## 2. Bagian B — buat resource web awal

Salin tiga berkas Bagian B ke stack:

```powershell
Copy-Item docs/m01/kode-bagian-b/variables.tf stacks/m01-sandbox/variables.tf -Force
Copy-Item docs/m01/kode-bagian-b/main.tf stacks/m01-sandbox/main.tf -Force
Copy-Item docs/m01/kode-bagian-b/outputs.tf stacks/m01-sandbox/outputs.tf -Force
```

Lalu:

```powershell
cd stacks/m01-sandbox
tofu init
tofu fmt
tofu validate
tofu plan -out m01.tfplan
tofu apply m01.tfplan
tofu output instance_id
tofu output ip_privat
cd ../..
py alat\koma.py cek m01
```

Catat ID dan nomor potret sebagai potret aktif pertama. Langkah A (EC2 Console dan dua kali AWS CLI) tetap harus dilakukan sesuai instruksi kelas; jangan mengarang bukti waktunya.

## 3. Bagian C — refaktor ke katalog `for_each`

Berkas final ada di `docs/m01/kode-bagian-c`. Salin ketiganya kembali ke stack setelah Bagian B. Jangan menambahkan `layanan` ke `terraform.tfvars`.

```powershell
Copy-Item docs/m01/kode-bagian-c/variables.tf stacks/m01-sandbox/variables.tf -Force
Copy-Item docs/m01/kode-bagian-c/main.tf stacks/m01-sandbox/main.tf -Force
Copy-Item docs/m01/kode-bagian-c/outputs.tf stacks/m01-sandbox/outputs.tf -Force
cd stacks/m01-sandbox
tofu fmt
tofu validate
tofu plan -out m01.tfplan
tofu apply m01.tfplan
tofu output instance
cd ../..
py alat\koma.py cek m01
```

Periksa plan: `web` seharusnya dipindahkan alamatnya tanpa dibuat ulang, sedangkan `api` dibuat sebagai resource kedua. Catat nomor potret.

## 4. Bagian D — uji reproducible

```powershell
cd stacks/m01-sandbox
tofu plan -detailed-exitcode
$LASTEXITCODE
tofu destroy
# setelah destroy berhasil:
tofu apply
tofu output instance
cd ../..
py alat\koma.py cek m01
```

Simpan exit code plan (0 bila tidak ada perubahan), ID sebelum/sesudah destroy, waktu, dan nomor potret. Hapus spasi awal sebelum `tofu output instance` jika menyalin baris per baris.

## 5. Latihan L.1–L.3

Edit `default` variabel `layanan` di `variables.tf` sementara:

- L.1: ubah `api.ukuran` dari `kecil` ke `sedang`, jalankan `tofu plan`, simpan blok perubahan; apply sesuai instruksi latihan, lalu pulihkan `kecil`.
- L.2: ubah `web.os` dari `linux` ke `debian12`, jalankan `tofu plan` saja dan simpan blok `must be replaced`; **jangan apply**. Pulihkan `linux` setelah mengambil bukti.
- L.3: ubah salah satu `ukuran` menjadi `raksasa`, jalankan `tofu plan`, simpan pesan validasi; pulihkan `kecil`.

Sesudah mengembalikan default, jalankan `tofu fmt`, `tofu validate`, `tofu plan -detailed-exitcode` dan pastikan `$LASTEXITCODE` adalah 0.

## 6. E.1 dan tugas akhir — bersihkan resource

```powershell
cd stacks/m01-sandbox
tofu destroy
cd ../..
py alat\koma.py cek m01
py alat\koma.py sisa
```

Untuk tugas katalog kasus, gunakan default `web` + `api` di `variables.tf` (dua peran berbeda, ukuran `kecil`), lalu jalankan plan/apply dan `py alat\koma.py cek m01`. Setelah potret aktif tercatat, segera:

```powershell
cd stacks/m01-sandbox
tofu destroy
cd ../..
py alat\koma.py cek m01
```

Potret terakhir harus kosong dan keluaran checker harus menunjukkan `tugas_lulus: true`. Jangan commit `terraform.tfvars`, state, `.terraform`, `.koma`, atau file plan.

## 7. Commit, tag, arsip

Lengkapi `TIM.md`, `log-keputusan.md`, dan `docs/m01/catatan-bukti.md` dengan data aktual. Pastikan `bukti/bukti-m01.json` dibuat oleh `koma cek` dan ikut commit.

```powershell
git status
git add TIM.md log-keputusan.md stacks/m00-fondasi stacks/m01-sandbox docs/m01/catatan-bukti.md bukti/bukti-m01.json
git commit -m "Selesaikan Modul 01"
# PR m01-kerja harus ditinjau dan di-merge sesuai instruksi kelas.
git switch main
git pull
git tag m01
git push origin m01
py alat\koma.py arsip m01
```

Unggah `koma-module-01.zip` yang dibuat oleh perintah terakhir ke panel tugas. Isi anggota/peninjau kelompok yang belum diketahui dari data kelompok sebenarnya, jangan mengarang.
