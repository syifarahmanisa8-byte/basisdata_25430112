# Dokumen Kebutuhan Data - Koperasi Mahasiswa Sejahtera (Kopma)

## 1. Latar Belakang dan Aktivitas Organisasi
Koperasi Mahasiswa Sejahtera (Kopma) menjual alat tulis, makanan ringan, dan minuman di lingkungan kampus kepada anggota maupun pembeli umum[cite: 44]. Anggota aktif yang terdaftar menggunakan NIM memperoleh diskon 5% untuk setiap nota[cite: 44]. Aktivitas operasional meliputi pencatatan penjualan oleh kasir per sif, pemeriksaan dan pemesanan stok barang ke pemasok oleh petugas gudang, serta penyusunan laporan bulanan oleh ketua koperasi[cite: 44].

## 2. Aktor dan Proses Bisnis
| Kode | Proses Bisnis | Aktor | Pemicu |
| :--- | :--- | :--- | :--- |
| PB-01 | Mendaftarkan anggota | Kasir (atas permintaan mahasiswa) | Mahasiswa ingin menjadi anggota[cite: 45] |
| PB-02 | Mencatat penjualan | Kasir | Pembeli membayar di kasir[cite: 45] |
| PB-03 | Memesan barang ke pemasok | Petugas gudang | Stok di bawah batas minimum[cite: 45] |
| PB-04 | Menerima barang dari pemasok | Petugas gudang | Barang datang bersama faktur[cite: 45] |
| PB-05 | Menyusun laporan bulanan | Ketua koperasi | Awal bulan[cite: 45] |

## 3. Dokumen Sumber yang Dianalisis
Dokumen utama yang dianalisis adalah **Nota Penjualan Kopma**:
* **Identitas Transaksi:** Nomor Nota, Tanggal-Jam, Kasir, Anggota[cite: 46].
* **Rincian Barang:** Barang, Qty, Harga Saat Transaksi, Subtotal[cite: 46].
* **Data Pembayaran:** Jumlah, Diskon Anggota 5%, Total, Bayar Tunai, Kembali[cite: 46].
* *Catatan:* Subtotal dan Total merupakan nilai turunan yang dihitung ulang dari kuantitas, harga, dan diskon[cite: 46].

## 4. Entitas Kandidat dan Elemen Data
| Entitas Kandidat | Elemen Data Utama | Sumber |
| :--- | :--- | :--- |
| Anggota | nomor anggota, NIM, nama, program studi, nomor HP, status aktif | Formulir pendaftaran[cite: 46] |
| Barang | kode, nama, kategori, harga jual, stok, batas minimum stok | Daftar barang, faktur[cite: 46] |
| Penjualan | nomor nota, tanggal-jam, kasir, anggota (opsional), bayar | Nota penjualan[cite: 46] |
| Detail penjualan | nomor nota, barang, qty, harga saat transaksi | Nota penjualan[cite: 46] |
| Petugas | kode petugas, nama, peran (kasir/gudang/ketua) | Wawancara[cite: 47] |
| Pemasok | kode, nama, telepon, alamat | Faktur pemasok[cite: 47] |
| Pembelian dan detailnya | nomor faktur, tanggal, pemasok, barang, qty, harga beli | Faktur pemasok[cite: 47] |

## 5. Aturan Bisnis
| Kode | Aturan Bisnis |
| :--- | :--- |
| AB-01 | Setiap nota memiliki nomor unik dan minimal satu baris barang[cite: 47]. |
| AB-02 | Penjualan boleh tanpa anggota (pembeli umum); jika ada, anggota harus berstatus aktif untuk memperoleh diskon 5%[cite: 47]. |
| AB-03 | Stok barang tidak boleh negatif; penjualan ditolak bila qty melebihi stok tersedia[cite: 47]. |
| AB-04 | Harga jual yang dipakai pada nota disimpan per baris dan tidak berubah meski harga barang kemudian naik[cite: 47]. |
| AB-05 | NIM anggota unik; pencarian anggota dapat dilakukan lewat nomor anggota atau NIM[cite: 47]. |
| AB-06 | Pesanan pembelian dibuat bila stok kurang dari batas minimum barang tersebut[cite: 47]. |

## 6. Kebutuhan Informasi
| Kode | Kebutuhan Informasi | Data yang Diperlukan |
| :--- | :--- | :--- |
| KI-01 | Omzet dan jumlah nota per hari dan per bulan | Penjualan, detail penjualan[cite: 47] |
| KI-02 | Lima barang terlaris per bulan berdasarkan qty | Detail penjualan, barang[cite: 47] |
| KI-03 | Barang dengan stok di bawah batas minimum | Barang[cite: 47] |
| KI-04 | Sepuluh anggota dengan belanja terbesar per bulan | Penjualan, detail penjualan, anggota[cite: 47] |

## 7. Matriks CRUD
| Proses | Anggota | Barang | Penjualan | Detail | Pemasok | Pembelian |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **PB-01 Daftar anggota** | C[cite: 47] | | | | | |
| **PB-02 Catat penjualan** | R[cite: 48] | R, U[cite: 48] | C[cite: 48] | C[cite: 48] | | |
| **PB-03 Pesan ke pemasok** | | R[cite: 48] | | | R[cite: 48] | C[cite: 48] |
| **PB-04 Terima barang** | | U[cite: 48] | | | R[cite: 48] | U[cite: 48] |
| **PB-05 Laporan bulanan** | R[cite: 48] | R[cite: 48] | R[cite: 48] | R[cite: 48] | | R[cite: 48] |

## 8. Kamus Data Awal
| Elemen | Arti | Contoh | Aturan | Penanggung Jawab |
| :--- | :--- | :--- | :--- | :--- |
| `no_anggota` | Nomor anggota koperasi | A-0457 | Unik, format A-4 digit[cite: 48] | Ketua[cite: 48] |
| `nim_anggota` | NIM anggota | 2301010123 | Unik, 10 digit[cite: 48] | Ketua[cite: 48] |
| `no_hp_anggota` | Nomor HP anggota | 0812xxxx | Data pribadi, akses terbatas[cite: 48] | Ketua[cite: 48] |
| `no_nota_penjualan` | Nomor nota penjualan | PJ-2609-0142 | Unik per nota[cite: 48] | Kasir[cite: 48] |
| `harga_satuan_detail_penjualan` | Harga jual saat transaksi | 4000 | Bilangan bulat $\ge 0$ (rupiah)[cite: 48] | Kasir[cite: 48] |
| `stok_barang` | Jumlah barang tersedia | 35 | Bilangan bulat $\ge 0$ (AB-03)[cite: 48] | Petugas gudang[cite: 48] |

## 9. Kebutuhan Non-Fungsional Data
* **Volume:** Perkiraan $\pm 150$ nota per hari[cite: 48].
* **Retensi:** Data transaksi disimpan minimal selama lima tahun[cite: 48].
* **Privasi:** Nomor HP anggota diklasifikasikan sebagai data pribadi dan hanya boleh dilihat oleh ketua koperasi, sejalan dengan Undang-Undang Pelindungan Data Pribadi[cite: 48].

## 10. Isu Kualitas Data yang Diantisipasi
Berdasarkan wawancara, isu yang diantisipasi meliputi: inkonsistensi harga masa lalu pada nota karena perubahan harga master barang, catatan stok yang kadang bernilai minus akibat pencatatan manual, serta kesulitan melacak data anggota yang lupa membawa kartu fisik[cite: 44].
```[cite: 41, 44]