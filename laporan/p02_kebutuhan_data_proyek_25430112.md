# Dokumen Kebutuhan Data - Perpustakaan Cendekia SR

## 1. Latar Belakang dan Aktivitas Organisasi
Perpustakaan Cendekia SR menyediakan layanan pengelolaan literatur dan peminjaman buku untuk civitas akademika. Aktivitas utamanya meliputi pendaftaran keanggotaan, pengelolaan katalog buku, pencatatan transaksi peminjaman, penerimaan pengembalian buku beserta denda, serta penyusunan laporan sirkulasi bulanan.

## 2. Aktor dan Proses Bisnis
| Kode | Proses Bisnis | Aktor | Pemicu |
| :--- | :--- | :--- | :--- |
| PB-01 | Mendaftarkan anggota baru | Pustakawan | Mahasiswa/pemustaka ingin mendaftar |
| PB-02 | Mengelola katalog buku | Pustakawan | Pengadaan buku baru atau pembaruan data |
| PB-03 | Mencatat peminjaman buku | Pustakawan | Anggota melakukan sirkulasi peminjaman |
| PB-04 | Menerima pengembalian dan denda | Pustakawan | Anggota mengembalikan buku |
| PB-05 | Menyusun laporan sirkulasi | Kepala Perpustakaan | Masuk awal bulan |

## 3. Dokumen Sumber yang Dianalisis
**Dokumen Fiktif:** Slip Peminjaman Buku
* **Identitas Transaksi:** Nomor Peminjaman, Tanggal Pinjam, Tanggal Jatuh Tempo, Pustakawan yang melayani.
* **Identitas Anggota:** Nomor Anggota, Nama Anggota.
* **Rincian Buku:** Kode Buku, Judul Buku.
* **Nilai Turunan:** Total Buku yang Dipinjam (dihitung dari jumlah baris rincian buku).

## 4. Entitas Kandidat dan Elemen Data
| Entitas Kandidat | Elemen Data Utama | Sumber |
| :--- | :--- | :--- |
| Anggota | nim, nama, prodi, no_hp, alamat, status | Formulir pendaftaran |
| Buku | kode_buku, judul, pengarang, penerbit, tahun_terbit, stok | Katalog buku |
| Pustakawan | id_pustakawan, nama_pustakawan | Wawancara |
| Peminjaman | no_peminjaman, tgl_pinjam, tgl_jatuh_tempo, status | Slip peminjaman |
| Detail Pinjam | no_peminjaman, kode_buku, tgl_kembali, nominal_denda | Slip pengembalian |
| Kategori | id_kategori, nama_kategori | Katalog buku |

## 5. Aturan Bisnis
| Kode | Aturan Bisnis |
| :--- | :--- |
| AB-01 | Setiap transaksi peminjaman memiliki nomor unik dan minimal berisi 1 buku. |
| AB-02 | Setiap anggota hanya boleh meminjam maksimal 6 buku secara bersamaan (berdasarkan parameter $P=4$). |
| AB-03 | Lama peminjaman maksimal adalah 7 hari dari tanggal transaksi peminjaman. |
| AB-04 | Keterlambatan pengembalian dikenakan denda sebesar Rp4.000 per hari (berdasarkan parameter $P$). |
| AB-05 | NIM anggota bersifat unik dan tidak boleh ganda di dalam sistem. |
| AB-06 | Peminjaman ditolak jika stok buku yang ingin dipinjam bernilai 0 (habis). |

## 6. Kebutuhan Informasi
| Kode | Kebutuhan Informasi | Data yang Diperlukan |
| :--- | :--- | :--- |
| KI-01 | Daftar peminjaman melewati jatuh tempo yang belum dikembalikan | Peminjaman, Detail Pinjam, Anggota |
| KI-02 | Lima judul buku paling sering dipinjam per bulan | Detail Pinjam, Buku |
| KI-03 | Total nominal denda keterlambatan per bulan | Detail Pinjam |
| KI-04 | Daftar buku dengan stok habis (0) | Buku |
| KI-05 | Daftar anggota paling aktif meminjam per semester | Peminjaman, Anggota |

## 7. Matriks CRUD
| Proses Bisnis | Anggota | Buku | Peminjaman | Detail Pinjam | Pustakawan | Kategori |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **PB-01** | C, R, U | | | | R | |
| **PB-02** | | C, R, U | | | R | R |
| **PB-03** | R | R, U | C | C | R | |
| **PB-04** | R | R, U | R, U | R, U | R | |
| **PB-05** | R | R | R | R | R | |

## 8. Kamus Data Awal
| Elemen | Arti | Contoh | Aturan | Penanggung Jawab |
| :--- | :--- | :--- | :--- | :--- |
| `nim_anggota` | Nomor Induk Mahasiswa | 2301010012 | Unik, 10 digit | Pustakawan |
| `nama_anggota` | Nama lengkap anggota | Shifa Rahmanisa | Tidak boleh kosong | Pustakawan |
| `no_hp_anggota` | Nomor telepon anggota | 08123456789 | Data pribadi (rahasia) | Kepala Perpustakaan |
| `alamat_anggota` | Alamat tempat tinggal | Jl. Ki Hajar Dewantara | Data pribadi | Kepala Perpustakaan |
| `prodi_anggota` | Program studi | Ilmu Komputer | Sesuai daftar prodi | Pustakawan |
| `status_anggota` | Status aktif anggota | Aktif | Aktif / Nonaktif | Pustakawan |
| `kode_buku` | Kode unik fisik buku | B-0012 | Unik, format B-4 digit | Pustakawan |
| `judul_buku` | Judul literatur buku | Basis Data | Tidak boleh kosong | Pustakawan |
| `pengarang_buku` | Penulis buku | R. Elmasri | Tidak boleh kosong | Pustakawan |
| `penerbit_buku` | Nama penerbit | Pearson | Tidak boleh kosong | Pustakawan |
| `tahun_terbit` | Tahun rilis buku | 2016 | 4 digit angka (YYYY) | Pustakawan |
| `stok_buku` | Jumlah fisik tersedia | 5 | Bilangan bulat $\ge 0$ | Pustakawan |
| `id_kategori` | Kode kategori buku | K-01 | Unik | Pustakawan |
| `nama_kategori` | Nama kategori buku | Teknologi | Tidak boleh kosong | Pustakawan |
| `id_pustakawan` | ID unik petugas | P-01 | Unik | Kepala Perpustakaan |
| `nama_pustakawan` | Nama petugas layanan | Dimas | Tidak boleh kosong | Kepala Perpustakaan |
| `no_peminjaman` | Nomor unik transaksi | P-2610-001 | Unik, format P-YMM-3 digit | Pustakawan |
| `tgl_pinjam` | Tanggal pinjam | 01/10/2026 | Format Tanggal | Pustakawan |
| `tgl_jatuh_tempo`| Batas waktu kembali | 08/10/2026 | `tgl_pinjam` + 7 hari | Pustakawan |
| `status_pinjam` | Status sirkulasi | Dipinjam | Dipinjam / Selesai | Pustakawan |
| `tgl_kembali` | Tanggal fisik kembali | 10/10/2026 | $\ge$ `tgl_pinjam` atau kosong | Pustakawan |
| `nominal_denda` | Biaya keterlambatan | 8000 | Bilangan bulat $\ge 0$ | Pustakawan |

## 9. Kebutuhan Non-Fungsional Data
* **Volume:** Perkiraan jumlah transaksi harian adalah $\pm 60$ transaksi berdasarkan parameter $P=4$.
* **Retensi:** Data historis peminjaman dan denda disimpan dan dipertahankan minimal selama 5 tahun.
* **Privasi:** Kolom `no_hp_anggota` dan `alamat_anggota` diklasifikasikan sebagai data pribadi dengan tingkat pelindungan tinggi. Hak akses baca (R) hanya dimiliki oleh Kepala Perpustakaan, sedangkan Pustakawan operasional hanya menggunakan pencarian terbatas berbasis NIM.

## 10. Isu Kualitas Data yang Diantisipasi
* **Akurasi Tanggal:** Potensi kesalahan *human error* di mana `tgl_kembali` tercatat lebih dulu daripada `tgl_pinjam`.
* **Konsistensi Status:** Transaksi peminjaman yang menggantung dengan status "Dipinjam" meskipun seluruh buku pada detail peminjaman sudah dikembalikan.
* **Validitas Denda:** Risiko pengisian nominal denda secara manual yang tidak sesuai dengan kalkulasi sistem (jumlah hari keterlambatan $\times$ tarif denda harian).