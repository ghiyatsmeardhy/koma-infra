# Jawaban Analisis — Modul 01

| Hal | Isi |
|---|---|
| Nama | Ghiyats Thabularasa Meardhy |
| NIM | `124450067` |
| Kelompok | `k02` |
| Kasus | Kirim Cepat Andalas |

Lengkapi bukti akun dari `catatan-bukti.md` dan sebut kode bukti kasus yang relevan.

## Pertanyaan 1 — Langkah yang hilang

| Keputusan manual di Bagian A | Kini tercatat di |
|---|---|
| Pemilihan AMI, tipe instance, dan konfigurasi jaringan | `stacks/m01-sandbox/main.tf` (data AMI, `instance_type`, dan IP publik dinonaktifkan) |
| Pemberian nama dan identitas resource | `stacks/m01-sandbox/main.tf` (`Name`, `peran`) dan `providers.tf` (tag pemilik/kelompok) |
| Pengulangan pembuatan resource dan pengelolaan hasilnya | `variables.tf`, `main.tf` (`for_each`), dan `outputs.tf` |

Jawaban: *Snowflake system* adalah infrastruktur yang dibangun secara manual dan unik sehingga konfigurasi serta keputusan pembuatannya sulit diketahui atau diulang. Infrastruktur sebagai kode mencatat konfigurasi dalam berkas yang dapat ditinjau dan dibangun ulang. Ini relevan dengan P5: worker tunggal gagal, antrean tertahan enam jam, dan 6.200 event hilang; konfigurasi yang terdokumentasi membantu pemulihan yang konsisten, walaupun IaC saja tidak menjamin data aplikasi yang belum disimpan secara persisten.

## Pertanyaan 2 — Cloud dari sisi pengguna Free plan

| Karakteristik | Penilaian awal | Bukti yang perlu dicantumkan |
|---|---|---|
| On-demand provisioning | Dialami | Waktu aktual dari apply EC2 |
| Self-service | Dialami | Perintah OpenTofu/AWS CLI yang dijalankan sendiri |
| Resource pooling, multi-tenancy | Dialami secara tidak langsung | AWS mengelola infrastruktur fisik bersama; pengguna tidak melihat tenant lain |
| Rapid elasticity | Dibatasi oleh kuota/Free plan dan perlu diuji | Hasil perubahan ukuran/kapasitas aktual |
| Measured service | Dialami, dengan keterbatasan tampilan kredit/tagihan | AWS Budgets/Billing yang benar-benar terlihat |
| Broad network access | Dialami | Konsol web, CLI, dan API melalui jaringan |

Batasan Free plan tidak otomatis mengubah sifat layanan AWS sebagai cloud. Namun batas kuota, kredit, dan jenis resource yang dapat dipakai membatasi skala eksperimen. Untuk KCA, karakteristik yang paling menentukan adalah rapid elasticity karena beban meningkat 2,7 kali menjelang Lebaran (C2), sementara kapasitas perlu mengikuti lonjakan tersebut.

## Pertanyaan 3 — Idempoten bukan reproducible

Jawaban: Idempoten berarti menjalankan apply kembali pada konfigurasi dan state yang sama tidak menghasilkan perubahan tambahan. Reproducible berarti infrastruktur dapat dihancurkan lalu dibangun kembali dengan konfigurasi yang sama dan karakteristik resource yang setara. Keduanya berbeda karena ID resource baru dapat berubah, AMI terbaru dapat berubah, kuota dapat habis, atau dependensi eksternal tidak tersedia. Bukti tugas harus memakai exit code plan dan dua pasang ID aktual dari potret 3 dan 4.

## Pertanyaan 4 — Replace dan in-place di produksi

Jawaban: Perubahan ukuran `api` dapat memerlukan penghentian dan menjalankan ulang instance sehingga ada jeda. Perubahan AMI `web` ke Debian 12 memaksa penggantian instance, sehingga layanan web berisiko mengalami gangguan dan data lokal pada instance lama perlu diperhatikan. `tofu plan` memperlihatkan perubahan sebelum diterapkan; blok `moved` menjaga identitas resource ketika alamat konfigurasi berubah saat refaktor. Keduanya tidak menjamin zero downtime, tidak melindungi data yang tidak disimpan persisten, dan tidak menggantikan strategi deployment bertahap atau redundansi. Dampak perlu dikaitkan dengan SLA 99,9% (E4) dan target p95 di bawah 200 ms (E5).
