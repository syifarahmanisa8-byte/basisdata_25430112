# Tugas Mandiri Modul 4 - Normalisasi Basis Data (Proyek Pribadi)
**NIM:** 25430112
**Nama:** Shifa Rahmanisa
**Studi Kasus:** Sistem Basis Data Perpustakaan Cendekia SR

## D.1 Dari UNF ke 1NF
Berdasarkan analisis dokumen sumber berupa **Slip Peminjaman Buku**, berikut adalah bentuk kelompok data yang belum dinormalisasi beserta rincian buku yang dipinjam:

**UNF (Unnormalized Form):**
`SLIP_UNF (no_peminjaman, tgl_pinjam, tgl_jatuh_tempo, id_pustakawan, nama_pustakawan, nim_anggota, nama_anggota, { kode_buku, judul_buku, tgl_kembali, nominal_denda }, total_buku)`

**1NF (First Normal Form):**
Grup berulang (grup rincian buku) dihilangkan, sehingga setiap baris hanya mendeskripsikan satu rincian buku dalam satu slip. Kunci primer menjadi komposit (gabungan nomor peminjaman dan kode buku).
`SLIP_1NF (`**`no_peminjaman`**`, `**`kode_buku`**`, tgl_pinjam, tgl_jatuh_tempo, id_pustakawan, nama_pustakawan, nim_anggota, nama_anggota, judul_buku, tgl_kembali, nominal_denda, total_buku)`

| Tahap | Nama Relasi / Tabel | Atribut | Primary Key (PK) |
| :--- | :--- | :--- | :--- |
| **UNF** | `SLIP_UNF` | `no_peminjaman`, `tgl_pinjam`, `tgl_jatuh_tempo`, `id_pustakawan`, `nama_pustakawan`, `nim_anggota`, `nama_anggota`, {`kode_buku`, `judul_buku`, `tgl_kembali`, `nominal_denda`}, `total_buku` | - |
| **1NF** | `SLIP_1NF` | `no_peminjaman`, `kode_buku`, `tgl_pinjam`, `tgl_jatuh_tempo`, `id_pustakawan`, `nama_pustakawan`, `nim_anggota`, `nama_anggota`, `judul_buku`, `tgl_kembali`, `nominal_denda`, `total_buku` | **`no_peminjaman`**, **`kode_buku`** |

## D.2 Menulis Dependensi Fungsional
Ketergantungan fungsional (FD) di bawah ini diidentifikasi berdasarkan aturan dan alur bisnis Perpustakaan Cendekia SR:
* **FD1:** `no_peminjaman` → `tgl_pinjam`, `tgl_jatuh_tempo`, `id_pustakawan`, `nim_anggota`, `total_buku` (Ketergantungan pada identitas transaksi peminjaman utama).
* **FD2:** `id_pustakawan` → `nama_pustakawan` (Ketergantungan pada entitas Pustakawan).
* **FD3:** `nim_anggota` → `nama_anggota` (Ketergantungan pada entitas Anggota).
* **FD4:** `kode_buku` → `judul_buku` (Ketergantungan pada fisik/katalog Buku).
* **FD5:** `no_peminjaman`, `kode_buku` → `tgl_kembali`, `nominal_denda` (Ketergantungan penuh pada kunci komposit rincian pengembalian dan sanksi keterlambatan).

## D.3 Menuju 2NF dan 3NF
**2NF (Second Normal Form):**
Menghilangkan dependensi parsial (FD1 dan FD4) dari kunci komposit utama.

| Nama Tabel | Atribut | Primary Key (PK) | Foreign Key (FK) | Keterangan FD |
| :--- | :--- | :--- | :--- | :--- |
| `PEMINJAMAN_2NF` | `no_peminjaman`, `tgl_pinjam`, `tgl_jatuh_tempo`, `id_pustakawan`, `nama_pustakawan`, `nim_anggota`, `nama_anggota`, `total_buku` | **`no_peminjaman`** | - | Diturunkan dari FD1 |
| `BUKU_2NF` | `kode_buku`, `judul_buku` | **`kode_buku`** | - | Diturunkan dari FD4 |
| `DETAIL_PINJAM_2NF` | `no_peminjaman`, `kode_buku`, `tgl_kembali`, `nominal_denda` | **`no_peminjaman`**, **`kode_buku`** | `no_peminjaman`, `kode_buku` | Diturunkan dari FD5 |

**3NF (Third Normal Form):**
Menghilangkan dependensi transitif (FD2 dan FD3) dari tabel peminjaman agar masing-masing entitas berdiri sendiri.

| Nama Tabel | Atribut | Primary Key (PK) | Foreign Key (FK) | Keterangan Pemisahan |
| :--- | :--- | :--- | :--- | :--- |
| `PEMINJAMAN_3NF` | `no_peminjaman`, `tgl_pinjam`, `tgl_jatuh_tempo`, `id_pustakawan`, `nim_anggota`, `total_buku` | **`no_peminjaman`** | `id_pustakawan`, `nim_anggota` | Menghapus dependensi FD2 & FD3 dari tabel Peminjaman |
| `PUSTAKAWAN_3NF` | `id_pustakawan`, `nama_pustakawan` | **`id_pustakawan`** | - | Dipisahkan berdasarkan FD2 |
| `ANGGOTA_3NF` | `nim_anggota`, `nama_anggota` | **`nim_anggota`** | - | Dipisahkan berdasarkan FD3 |
| `BUKU_3NF` | `kode_buku`, `judul_buku` | **`kode_buku`** | - | Mempertahankan FD4 |
| `DETAIL_PINJAM_3NF` | `no_peminjaman`, `kode_buku`, `tgl_kembali`, `nominal_denda` | **`no_peminjaman`**, **`kode_buku`** | `no_peminjaman`, `kode_buku` | Mempertahankan FD5 |

**Keputusan Atribut Turunan:**
Atribut `total_buku` merupakan hasil kalkulasi (turunan) dari jumlah baris rincian buku yang direkam dalam satu nomor peminjaman. Untuk menjaga integritas data dan mencegah anomali, atribut ini tidak perlu disimpan secara fisik dan dihapus dari relasi tabel akhir. *(Catatan: Atribut nominal_denda tetap dipertahankan secara fisik sesuai dengan rancangan awal ERD untuk kebutuhan pembukuan historis).*

## D.4 Pemeriksaan BCNF dan Pencocokan Skema
Setelah pembersihan nilai turunan, skema hasil akhirnya adalah sebagai berikut:

| Nama Tabel | Atribut | Primary Key (PK) | Foreign Key (FK) |
| :--- | :--- | :--- | :--- |
| `PEMINJAMAN` | `no_peminjaman`, `tgl_pinjam`, `tgl_jatuh_tempo`, `id_pustakawan`, `nim_anggota` | **`no_peminjaman`** | `id_pustakawan`, `nim_anggota` |
| `PUSTAKAWAN` | `id_pustakawan`, `nama_pustakawan` | **`id_pustakawan`** | - |
| `ANGGOTA` | `nim_anggota`, `nama_anggota` | **`nim_anggota`** | - |
| `BUKU` | `kode_buku`, `judul_buku` | **`kode_buku`** | - |
| `DETAIL_PINJAM` | `no_peminjaman`, `kode_buku`, `tgl_kembali`, `nominal_denda` | **`no_peminjaman`**, **`kode_buku`** | `no_peminjaman`, `kode_buku` |

**Pemeriksaan BCNF (Boyce-Codd Normal Form):** 
Seluruh penentu (determinan) dari relasi di atas sudah berstatus sebagai Candidate Key. Tidak ditemukan ketergantungan dari atribut non-kunci terhadap atribut penentu yang bukan kunci utama. Skema sudah memenuhi BCNF secara menyeluruh.

**Kesesuaian dengan ERD Fisik:**
Hasil normalisasi di atas selaras dengan entitas ERD Fisik Perpustakaan Cendekia SR. Dalam implementasi fisiknya kelak, _surrogate key_ berbasis bilangan bulat (`INT`) dengan fitur `AUTO_INCREMENT` (seperti `id_peminjaman`, `id_anggota`, `id_buku`) ditambahkan untuk meningkatkan performa pengindeksan, sedangkan atribut bisnis asli (seperti `no_peminjaman`, `nim_anggota`, `kode_buku`) diberi batasan `UNIQUE`.

| Nama Tabel Fisik | Primary Key (*Surrogate Key*) | *Natural Key* (UNIQUE) | Foreign Key (FK) | Atribut Lain |
| :--- | :--- | :--- | :--- | :--- |
| `peminjaman` | `id_peminjaman` (INT, AI) | `no_peminjaman` | `id_pustakawan`, `id_anggota` | `tgl_pinjam`, `tgl_jatuh_tempo` |
| `pustakawan` | `id_pustakawan` (SMALLINT, AI) | - | - | `nama_pustakawan` |
| `anggota` | `id_anggota` (INT, AI) | `nim_anggota` | - | `nama_anggota` |
| `buku` | `id_buku` (INT, AI) | `kode_buku` | - | `judul_buku` |
| `detail_pinjam` | `id_peminjaman`, `id_buku` | - | `id_peminjaman`, `id_buku` | `tgl_kembali`, `nominal_denda` |