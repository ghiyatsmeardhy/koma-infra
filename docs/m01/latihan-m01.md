# Latihan 1.1 — Memilih dari katalog, bukan mengetik angka

| Hal | Isi |
|---|---|
| Nama | Ghiyats Thabularasa Meardhy |
| NIM | `124450067` |
| Kelompok | `k02` |
| Kasus | Kirim Cepat Andalas |

## L.1 — `api` naik ke ukuran `sedang`

Blok plan aktual:

```text
(tempel keluaran plan aktual di sini)
```

Penjelasan: perubahan ukuran dari `t3.micro` menjadi `t3.small` umumnya ditampilkan sebagai perubahan in-place (`~`) pada atribut `instance_type`, bukan penggantian AMI. Provider AWS menghentikan instance, mengubah tipe instance, lalu menjalankannya kembali. Selama proses tersebut API dapat mengalami jeda layanan. Untuk KCA, hal ini perlu dipertimbangkan karena API pemindaian memiliki SLA 99,9% (E4) dan target p95 kurang dari 200 ms (E5).

## L.2 — `web` pindah ke Debian 12 (tidak di-apply)

Blok plan aktual:

```text
(tempel keluaran plan aktual yang memuat must be replaced dan ringkasan)
```

Penjelasan: perubahan OS mengganti AMI. Perubahan AMI pada EC2 memaksa penggantian instance (`-/+` atau `must be replaced`). Instance lama akan dihancurkan dan instance baru dibuat; data lokal yang hanya berada pada root volume instance lama dapat hilang ketika instance/volume dihapus. Ringkasan dapat menampilkan perubahan dan penghancuran sebagai bagian dari rencana penggantian. Jangan jalankan `tofu apply` untuk eksperimen ini.

## L.3 — Ukuran di luar katalog

Pesan galat aktual:

```text
(tempel pesan galat aktual untuk ukuran raksasa)
```

Penjelasan: validasi variabel Terraform/OpenTofu seharusnya menolak nilai `raksasa` pada tahap validasi konfigurasi/plan, sebelum perubahan resource dikirim untuk diterapkan ke AWS. Validasi di sisi konfigurasi mencegah nilai yang tidak disetujui katalog dipakai.

## L.4 — Bukti

- Waktu `koma cek m01` (WIB): (isi aktual)
- Nomor potret: (isi aktual)
- `Latihan lulus`: (salin hasil aktual)
- Tipe instance `api` setelah apply: (salin dari `tofu output instance`)
- Plan sesudah apply: exit code (salin `$LASTEXITCODE`; 0 berarti tidak ada perubahan)
