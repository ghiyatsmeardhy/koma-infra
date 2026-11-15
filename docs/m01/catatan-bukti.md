# Modul 01 — Catatan Bukti

Isi segera setelah setiap langkah. Waktu WIB dan ID instance harus disalin dari keluaran aktual. Jangan mengisi dengan perkiraan.

| Hal | Isi |
|---|---|
| Nama | Ghiyats Thabularasa Meardhy |
| NIM | `124450067` |
| Kelompok | `k02` |
| Kasus | Kirim Cepat Andalas |

## Log langkah

| Langkah | Waktu (WIB) | Perintah | Hasil singkat |
|---|---|---|---|
| A.1 Konsol | (isi aktual) | Konsol EC2 | (ID dan hasil aktual) |
| A.2 CLI dua kali | (isi aktual) | `aws ec2 run-instances` | (dua ID aktual) |
| A.3 Cek + bongkar | (isi aktual) | `py alat\koma.py cek m01`; terminate instance Bagian A | (hasil aktual) |
| B.1 Anggaran | (isi aktual) | `tofu apply m00.tfplan` | (hasil aktual) |
| B.4 Apply pertama | (isi aktual) | `tofu apply m01.tfplan` | (ID web aktual) |
| B.5 Potret 2 | (isi aktual) | `py alat\koma.py cek m01` | (nomor potret dan hasil aktual) |
| C.1 Plan kedua | (isi aktual) | `tofu plan -detailed-exitcode` | (exit code aktual) |
| C.3 Refaktor | (isi aktual) | `tofu apply m01.tfplan` | (web dipertahankan; api dibuat) |
| C.4 Potret 3 | (isi aktual) | `py alat\koma.py cek m01` | (nomor potret dan hasil aktual) |
| D.1 Destroy + apply | (isi aktual) | `tofu destroy`, lalu `tofu apply` | (waktu dan ID aktual) |
| D.1 Potret 4 | (isi aktual) | `py alat\koma.py cek m01` | (nomor potret dan hasil aktual) |
| Latihan L.4 (potret 5) | (isi aktual) | `tofu apply`, cek m01 | (hasil aktual) |
| E.1 Destroy + potret 6 | (isi aktual) | `tofu destroy`, cek m01, `py alat\koma.py sisa` | (hasil aktual) |
| Tugas: katalog kasus | (isi aktual) | `tofu apply`, cek m01 | (nomor potret dan hasil aktual) |
| Tugas: destroy akhir | (isi aktual) | `tofu destroy`, cek m01 | (nomor potret dan hasil aktual) |

## Catatan Bagian A

- Waktu konsol: (isi aktual)
- Waktu CLI: (isi aktual)
- ID instance: (salin ID aktual)
- Keputusan yang tidak tercatat di tempat lain: (isi berdasarkan pengalaman aktual)
- Semua instance Bagian A sudah di-terminate: (ya/belum; sertakan bukti aktual)

## Catatan Bagian D

- Plan kedua (C.1): exit code = (isi aktual; seharusnya 0 jika tidak ada perubahan)
- ID sebelum destroy: `web` (ID aktual), `api` (ID aktual)
- ID sesudah apply ulang: `web` (ID aktual), `api` (ID aktual)
- Waktu destroy: (aktual); waktu apply ulang: (aktual)
- Potret yang meluluskan `reproducible`: (nomor potret aktual)

## Model layanan

| Komponen | Model | Alasan |
|---|---|---|
| Instance EC2 | IaaS | Pengguna memilih image, tipe instance, jaringan, dan mengelola OS tamu. |
| AWS Budgets | (lengkapi dari pengalaman akun) | Layanan pengelolaan anggaran terkelola; pengguna mengatur batas dan notifikasi. |
| Repo GitHub | (lengkapi) | (jelaskan layanan repositori yang digunakan) |
| Workbench (panel Tugas) | (lengkapi) | (jelaskan layanan platform yang digunakan) |
| `koma cek` | Bukan model layanan cloud | Alat CLI lokal untuk memeriksa resource dan menyimpan bukti. |

## Karakteristik cloud yang dialami

| Karakteristik | Dialami / dibatasi / tidak | Bukti aktual |
|---|---|---|
| On-demand provisioning | (lengkapi) | (waktu plan/apply aktual) |
| Self-service | (lengkapi) | (perintah yang dijalankan sendiri) |
| Resource pooling, multi-tenancy | (lengkapi) | (bukti layanan AWS) |
| Rapid elasticity | (lengkapi) | (perubahan ukuran/kapasitas yang benar-benar diuji) |
| Measured service | (lengkapi) | (Billing/Budgets aktual) |
| Broad network access | (lengkapi) | (akses konsol/CLI/API aktual) |

## Potret Tugas

- Katalog default: `web` (peran `web`, ukuran `kecil`, OS `linux`) dan `api` (peran `api`, ukuran `kecil`, OS `linux`).
- Potret aktif katalog kasus: (nomor dan waktu aktual)
- Potret bersih terakhir: (nomor dan waktu aktual); `tugas_lulus`: (salin hasil aktual)
