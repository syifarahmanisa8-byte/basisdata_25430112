# Normalisasi Basis Data - Kasus Kopma
**NIM:** 25430112
**Nama:** Shifa Rahmanisa

## D.1 Dari UNF ke 1NF
Berdasarkan dokumen sumber Nota Penjualan Kopma, berikut adalah bentuk UNF yang memuat elemen data utama dan rincian barang:

**UNF (Unnormalized Form):**
`NOTA_UNF (no_nota_penjualan, tgl_penjualan, kode_petugas, nama_petugas, no_anggota, nama_anggota, { kode_barang, nama_barang, qty_detail_penjualan, harga_satuan_detail_penjualan, subtotal_detail_penjualan }, jumlah_penjualan, diskon_penjualan, total_penjualan)`

**1NF (First Normal Form):**
Grup berulang dihilangkan sehingga satu baris mendeskripsikan satu barang di dalam nota. Kunci primer (Primary Key) menjadi komposit gabungan dari nomor nota dan kode barang.
`NOTA_1NF (`**`no_nota_penjualan`**`, `**`kode_barang`**`, tgl_penjualan, kode_petugas, nama_petugas, no_anggota, nama_anggota, nama_barang, qty_detail_penjualan, harga_satuan_detail_penjualan, subtotal_detail_penjualan, jumlah_penjualan, diskon_penjualan, total_penjualan)`

| Tahap | Nama Relasi / Tabel | Atribut | Primary Key (PK) |
| :--- | :--- | :--- | :--- |
| **UNF** | `NOTA_UNF` | `no_nota_penjualan`, `tgl_penjualan`, `kode_petugas`, `nama_petugas`, `no_anggota`, `nama_anggota`, {`kode_barang`, `nama_barang`, `qty_detail_penjualan`, `harga_satuan_detail_penjualan`, `subtotal_detail_penjualan`}, `jumlah_penjualan`, `diskon_penjualan`, `total_penjualan` | - |
| **1NF** | `NOTA_1NF` | `no_nota_penjualan`, `kode_barang`, `tgl_penjualan`, `kode_petugas`, `nama_petugas`, `no_anggota`, `nama_anggota`, `nama_barang`, `qty_detail_penjualan`, `harga_satuan_detail_penjualan`, `subtotal_detail_penjualan`, `jumlah_penjualan`, `diskon_penjualan`, `total_penjualan` | **`no_nota_penjualan`**, **`kode_barang`** |

## D.2 Menulis Dependensi Fungsional
Dependensi fungsional (FD) ini diturunkan langsung dari Aturan Bisnis (AB) dan dokumen kebutuhan data Kopma:
* **FD1:** `no_nota_penjualan` → `tgl_penjualan`, `kode_petugas`, `no_anggota`, `jumlah_penjualan`, `diskon_penjualan`, `total_penjualan` (Ketergantungan pada identitas utama transaksi nota).
* **FD2:** `kode_petugas` → `nama_petugas` (Ketergantungan pada entitas Petugas).
* **FD3:** `no_anggota` → `nama_anggota` (Ketergantungan pada entitas Anggota).
* **FD4:** `kode_barang` → `nama_barang` (Ketergantungan pada entitas Barang).
* **FD5:** `no_nota_penjualan`, `kode_barang` → `qty_detail_penjualan`, `harga_satuan_detail_penjualan`, `subtotal_detail_penjualan` (Ketergantungan penuh pada kunci komposit rincian barang).

## D.3 Menuju 2NF dan 3NF
**2NF (Second Normal Form):**
Menghilangkan dependensi parsial (FD1 dan FD4) dari kunci komposit `no_nota_penjualan` dan `kode_barang`.

| Nama Tabel | Atribut | Primary Key (PK) | Foreign Key (FK) | Keterangan FD |
| :--- | :--- | :--- | :--- | :--- |
| `PENJUALAN_2NF` | `no_nota_penjualan`, `tgl_penjualan`, `kode_petugas`, `nama_petugas`, `no_anggota`, `nama_anggota`, `jumlah_penjualan`, `diskon_penjualan`, `total_penjualan` | **`no_nota_penjualan`** | - | Diturunkan dari FD1 |
| `BARANG_2NF` | `kode_barang`, `nama_barang` | **`kode_barang`** | - | Diturunkan dari FD4 |
| `DETAIL_PENJUALAN_2NF` | `no_nota_penjualan`, `kode_barang`, `qty_detail_penjualan`, `harga_satuan_detail_penjualan`, `subtotal_detail_penjualan` | **`no_nota_penjualan`**, **`kode_barang`** | `no_nota_penjualan`, `kode_barang` | Diturunkan dari FD5 |

**3NF (Third Normal Form):**
Menghilangkan dependensi transitif (FD2 dan FD3) dari tabel penjualan.

| Nama Tabel | Atribut | Primary Key (PK) | Foreign Key (FK) | Keterangan Pemisahan |
| :--- | :--- | :--- | :--- | :--- |
| `PENJUALAN_3NF` | `no_nota_penjualan`, `tgl_penjualan`, `kode_petugas`, `no_anggota`, `jumlah_penjualan`, `diskon_penjualan`, `total_penjualan` | **`no_nota_penjualan`** | `kode_petugas`, `no_anggota` | Menghapus dependensi FD2 & FD3 dari tabel Penjualan |
| `PETUGAS_3NF` | `kode_petugas`, `nama_petugas` | **`kode_petugas`** | - | Dipisahkan berdasarkan FD2 |
| `ANGGOTA_3NF` | `no_anggota`, `nama_anggota` | **`no_anggota`** | - | Dipisahkan berdasarkan FD3 |
| `BARANG_3NF` | `kode_barang`, `nama_barang` | **`kode_barang`** | - | Mempertahankan FD4 |
| `DETAIL_PENJUALAN_3NF` | `no_nota_penjualan`, `kode_barang`, `qty_detail_penjualan`, `harga_satuan_detail_penjualan`, `subtotal_detail_penjualan` | **`no_nota_penjualan`**, **`kode_barang`** | `no_nota_penjualan`, `kode_barang` | Mempertahankan FD5 |

**Keputusan Atribut Turunan:**
Atribut `subtotal_detail_penjualan`, `jumlah_penjualan`, `diskon_penjualan`, dan `total_penjualan` adalah data turunan hasil kalkulasi (kuantitas × harga, dsb). Mengikuti prinsip normalisasi untuk mencegah anomali data, nilai turunan ini **tidak akan disimpan di dalam basis data** dan dihapus dari relasi fisik.

## D.4 Pemeriksaan BCNF dan Pencocokan Skema
Setelah pembersihan nilai turunan, skema hasil akhirnya adalah sebagai berikut:

| Nama Tabel | Atribut | Primary Key (PK) | Foreign Key (FK) |
| :--- | :--- | :--- | :--- |
| `PENJUALAN` | `no_nota_penjualan`, `tgl_penjualan`, `kode_petugas`, `no_anggota` | **`no_nota_penjualan`** | `kode_petugas`, `no_anggota` |
| `PETUGAS` | `kode_petugas`, `nama_petugas` | **`kode_petugas`** | - |
| `ANGGOTA` | `no_anggota`, `nama_anggota` | **`no_anggota`** | - |
| `BARANG` | `kode_barang`, `nama_barang` | **`kode_barang`** | - |
| `DETAIL_PENJUALAN` | `no_nota_penjualan`, `kode_barang`, `qty_detail_penjualan`, `harga_satuan_detail_penjualan` | **`no_nota_penjualan`**, **`kode_barang`** | `no_nota_penjualan`, `kode_barang` |

**Pemeriksaan BCNF (Boyce-Codd Normal Form):** 
Setiap atribut penentu dalam seluruh relasi di atas sudah merupakan kunci kandidat (Candidate Key). Tidak ditemukan adanya ketergantungan fungsional terhadap atribut yang bukan kunci utama. Skema ini dinyatakan **sudah memenuhi standar BCNF**.

**Kesesuaian dengan ERD Fisik:**
Hasil normalisasi di atas terbukti konsisten dan selaras dengan gambar ERD Fisik Modul 3. Struktur relasi logika ini diimplementasikan menggunakan *surrogate key* (kunci pengganti buatan) seperti `id_penjualan`, `id_petugas`, `id_anggota`, dan `id_barang` bertipe data `INT` dengan sifat `AUTO_INCREMENT` sebagai kunci primernya.

| Nama Tabel Fisik | Primary Key (*Surrogate Key*) | *Natural Key* (UNIQUE) | Foreign Key (FK) | Atribut Lain |
| :--- | :--- | :--- | :--- | :--- |
| `penjualan` | `id_penjualan` (INT, AI) | `no_nota_penjualan` | `id_petugas`, `id_anggota` | `tgl_penjualan` |
| `petugas` | `id_petugas` (SMALLINT, AI) | `kode_petugas` | - | `nama_petugas` |
| `anggota` | `id_anggota` (INT, AI) | `no_anggota` | - | `nama_anggota` |
| `barang` | `id_barang` (INT, AI) | `kode_barang` | - | `nama_barang` |
| `detail_penjualan` | `id_penjualan`, `id_barang` | - | `id_penjualan`, `id_barang` | `qty_detail_penjualan`, `harga_satuan_detail_penjualan` |