# Log Keputusan

| ID | Tanggal | Keputusan | Alasan (rujuk kode bukti kasus) | Pengusul (NIM) |
|---|---|---|---|---|
| K-01-001 | 2026-11-15 | Memetakan kunci `web` untuk pelacakan publik dan `api` untuk API pemindaian; nama resource mengikuti `koma-<nim>-m01-<kunci>`. | E1 memisahkan web pelacakan publik dan API pemindaian; P5 menunjukkan dampak kegagalan worker terhadap status kiriman. | 124450067 |
| K-01-002 | 2026-11-15 | Menggunakan katalog `map(object({ peran, ukuran, os }))` dan `for_each` dengan dua layanan serta dua peran berbeda. | E1 menjelaskan komponen aplikasi; E4 menetapkan SLA API 99,9% dan E5 menetapkan p95 penerimaan event di bawah 200 ms. | 124450067 |
| K-01-003 | 2026-11-15 | Mempertahankan alamat resource web dengan blok `moved` ketika refaktor dari `aws_instance.web` ke `aws_instance.layanan["web"]`. | API pemindaian beroperasi 24 jam dan pemindai menganggap gagal setelah 1 detik (E5); refaktor tidak seharusnya mengganti instance web yang sudah ada. | 124450067 |
