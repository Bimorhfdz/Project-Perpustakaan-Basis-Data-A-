# Project-Perpustakaan-Basis-Data-A-

# 📚 Sistem Manajemen Perpustakaan
> Implementasi basis data relasional untuk pengelolaan perpustakaan menggunakan MySQL

---

## 📋 Deskripsi Project

Sistem Manajemen Perpustakaan adalah implementasi basis data yang dirancang untuk mengelola seluruh aktivitas perpustakaan secara terintegrasi, meliputi pengelolaan data buku, anggota, petugas, transaksi peminjaman, pengembalian, denda, dan reservasi buku.

Sistem ini dibangun menggunakan **MySQL** dengan fitur-fitur lanjutan seperti Stored Procedure, Trigger, View, dan Function untuk mengotomasi logika bisnis perpustakaan.

### Fitur Utama
- Manajemen data master (buku, anggota, petugas, penerbit, penulis, rak)
- Transaksi peminjaman dan pengembalian buku
- Perhitungan denda otomatis via Trigger (Rp2.000/hari)
- Reservasi buku
- Laporan dan monitoring stok buku
- Validasi bisnis via Stored Procedure dan Function

---

## 👥 Anggota Tim

| No | Nama | NIM |
|----|------|-----|
| 1  | Nailah Khusnul Masitha Siregar | K1D024049 |
| 2  | Talenta Nusantara Wijaya | K1D024057 |
| 3  | Salsabella Setya Choerunissa | K1D024060 |
| 4  | Raditya Akbar Firdaus | K1D024063 |
| 5  | Bimo Rahman Hafidz | K1D024069 |

---

## 🗂️ Struktur Folder

```
perpustakaan/
├── README.md
├── ERD/
│   └── ERD_Perpustakaan.png
├── SQL/
│   ├── 1_DDL.sql               # CREATE TABLE, constraint, index
│   ├── 2_DML.sql               # INSERT data dummy
│   ├── 3_Query.sql             # 10 query SELECT
│   ├── 4_View.sql              # 3 View
│   ├── 5_StoredProcedure.sql   # sp_pinjam_buku, sp_kembalikan_buku
│   ├── 6_Trigger.sql           # 4 Trigger
│   └── 7_Function.sql          # fn_total_denda_anggota, fn_boleh_pinjam
└── Referensi/
    └── referensi.md
```

---

## 🗺️ ERD

![ERD Sistem Manajemen Perpustakaan](ERD/ERD_Perpustakaan.png)

## ▶️ Cara Menjalankan Script

### Prasyarat
- MySQL Server 8.0 atau lebih baru
- MySQL Workbench (direkomendasikan)

### Langkah-langkah

> ⚠️ **Penting:** Jalankan script secara **berurutan** dari bagian 1 sampai 7.
> Jangan lewati urutan karena setiap bagian bergantung pada bagian sebelumnya.

**Langkah 1 — Buat Database & Tabel**
```
Buka MySQL Workbench → File → Open SQL Script → pilih 1_DDL.sql → Run (Ctrl+Shift+Enter)
```

**Langkah 2 — Isi Data Dummy**
```
Buka 2_DML.sql → Run
```
> Tabel `denda` akan terisi otomatis oleh Trigger saat data pengembalian dimasukkan.

**Langkah 3 — Jalankan Query**
```
Buka 3_Query.sql → jalankan per query sesuai kebutuhan
```

**Langkah 4 — Buat View**
```
Buka 4_View.sql → Run
```

**Langkah 5 — Buat Stored Procedure**
```
Buka 5_StoredProcedure.sql → Run
```

**Langkah 6 — Buat Trigger**
```
Buka 6_Trigger.sql → Run
```

**Langkah 7 — Buat Function**
```
Buka 7_Function.sql → Run
```

---

### Menguji Sistem

**Test Stored Procedure peminjaman:**
```sql
CALL sp_pinjam_buku(3, 2, 4, @pesan);
SELECT @pesan;
```

**Test Stored Procedure pengembalian:**
```sql
CALL sp_kembalikan_buku(19, @pesan);
SELECT @pesan;
```

**Cek denda anggota:**
```sql
SELECT nama_anggota, fn_total_denda_anggota(id_anggota) AS sisa_denda FROM anggota;
```

**Cek status boleh pinjam:**
```sql
SELECT nama_anggota, fn_boleh_pinjam(id_anggota) AS boleh_pinjam FROM anggota;
```

**Lihat peminjaman aktif:**
```sql
SELECT * FROM v_peminjaman_aktif;
```

**Lihat laporan denda:**
```sql
SELECT * FROM v_laporan_denda_anggota;
```

**Lihat stok buku:**
```sql
SELECT * FROM v_stok_buku;
```

---

## 🛠️ Teknologi

- **Database:** MySQL 8.0
- **Tools:** MySQL Workbench
- **Bahasa:** SQL (DDL, DML, DCL)
