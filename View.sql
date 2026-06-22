-- ============================================================
--  BAGIAN 4 – VIEW
-- ============================================================
USE perpustakaan;
-- View 1: Ringkasan status peminjaman aktif
CREATE OR REPLACE VIEW v_peminjaman_aktif AS
SELECT
    pm.id_peminjaman,
    a.nama_anggota,
    a.no_telp,
    b.judul_buku,
    pt.nama_petugas,
    pm.tanggal_pinjam,
    pm.tanggal_jatuh_tempo,
    DATEDIFF(CURDATE(), pm.tanggal_jatuh_tempo) AS hari_terlambat
FROM peminjaman      pm
JOIN anggota         a  ON pm.id_anggota     = a.id_anggota
JOIN petugas         pt ON pm.id_petugas     = pt.id_petugas
JOIN detail_peminjaman dp ON pm.id_peminjaman = dp.id_peminjaman
JOIN buku            b  ON dp.id_buku        = b.id_buku
WHERE pm.status_pinjam = 'Dipinjam';

-- View 2: Laporan denda keseluruhan per anggota
CREATE OR REPLACE VIEW v_laporan_denda_anggota AS
SELECT
    a.id_anggota,
    a.nama_anggota,
    a.email,
    COUNT(d.id_denda)                             AS jumlah_transaksi_denda,
    SUM(d.jumlah_denda)                           AS total_denda,
    SUM(CASE WHEN d.status_bayar = 'Lunas'
             THEN d.jumlah_denda ELSE 0 END)      AS sudah_dibayar,
    SUM(CASE WHEN d.status_bayar = 'Belum Lunas'
             THEN d.jumlah_denda ELSE 0 END)      AS sisa_tagihan
FROM denda      d
JOIN pengembalian pg ON d.id_pengembalian = pg.id_pengembalian
JOIN peminjaman   pm ON pg.id_peminjaman  = pm.id_peminjaman
JOIN anggota       a ON pm.id_anggota     = a.id_anggota
GROUP BY a.id_anggota, a.nama_anggota, a.email;

-- View 3: Monitoring stok buku real-time (terupdate otomatis oleh trigger)
CREATE OR REPLACE VIEW v_stok_buku AS
SELECT
    b.id_buku,
    b.judul_buku,
    kb.nama_kategori,
    pu.nama_penulis,
    r.kode_rak,
    b.stok AS stok_tersedia
FROM buku          b
JOIN kategori_buku kb ON b.id_kategori = kb.id_kategori
JOIN penulis       pu ON b.id_penulis  = pu.id_penulis
JOIN rak_buku       r ON b.id_rak      = r.id_rak
ORDER BY b.stok ASC;

-- Cek hasilnya
SELECT * FROM v_stok_buku;
SELECT * FROM v_peminjaman_aktif;
SELECT * FROM v_laporan_denda_anggota;