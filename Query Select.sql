-- ============================================================
--  BAGIAN 3 – QUERY SELECT
-- ============================================================
USE perpustakaan;
-- ─── QUERY SEDERHANA ─────────────────────────────────────────
-- Q1: Daftar semua buku beserta stok yang tersedia
SELECT
    b.id_buku,
    b.judul_buku,
    b.isbn,
    b.tahun_terbit,
    b.stok AS stok_tersedia
FROM buku b
ORDER BY b.judul_buku;

-- Q2: Daftar anggota yang masih aktif
SELECT
    id_anggota,
    nama_anggota,
    jenis_kelamin,
    no_telp,
    email,
    tgl_daftar
FROM anggota
WHERE status_anggota = 'Aktif'
ORDER BY nama_anggota;

-- Q3: Daftar denda yang belum lunas
SELECT
    d.id_denda,
    a.nama_anggota,
    p.tanggal_pinjam,
    pg.tanggal_kembali,
    pg.terlambat_hari,
    d.jumlah_denda,
    d.status_bayar
FROM denda d
JOIN pengembalian pg ON d.id_pengembalian = pg.id_pengembalian
JOIN peminjaman   p  ON pg.id_peminjaman  = p.id_peminjaman
JOIN anggota      a  ON p.id_anggota      = a.id_anggota
WHERE d.status_bayar = 'Belum Lunas';


-- ─── QUERY DENGAN JOIN (minimal 3 tabel) ─────────────────────

-- Q4: Riwayat peminjaman lengkap – anggota, buku, petugas
SELECT
    pm.id_peminjaman,
    a.nama_anggota,
    b.judul_buku,
    kb.nama_kategori,
    pt.nama_petugas,
    pm.tanggal_pinjam,
    pm.tanggal_jatuh_tempo,
    pm.status_pinjam
FROM peminjaman      pm
JOIN anggota         a   ON pm.id_anggota     = a.id_anggota
JOIN petugas         pt  ON pm.id_petugas     = pt.id_petugas
JOIN detail_peminjaman dp ON pm.id_peminjaman = dp.id_peminjaman
JOIN buku            b   ON dp.id_buku        = b.id_buku
JOIN kategori_buku   kb  ON b.id_kategori     = kb.id_kategori
ORDER BY pm.tanggal_pinjam DESC;

-- Q5: Detail pengembalian beserta info denda
SELECT
    a.nama_anggota,
    b.judul_buku,
    pm.tanggal_pinjam,
    pm.tanggal_jatuh_tempo,
    pg.tanggal_kembali,
    pg.terlambat_hari,
    COALESCE(d.jumlah_denda, 0)   AS jumlah_denda,
    COALESCE(d.status_bayar, '-') AS status_bayar
FROM pengembalian   pg
JOIN peminjaman     pm ON pg.id_peminjaman = pm.id_peminjaman
JOIN anggota         a ON pm.id_anggota   = a.id_anggota
JOIN detail_peminjaman dp ON pm.id_peminjaman = dp.id_peminjaman
JOIN buku            b  ON dp.id_buku     = b.id_buku
LEFT JOIN denda      d  ON pg.id_pengembalian = d.id_pengembalian
ORDER BY pg.tanggal_kembali DESC;

-- Q6: Info lengkap buku – kategori, penerbit, penulis, rak
SELECT
    b.id_buku,
    b.judul_buku,
    b.isbn,
    b.tahun_terbit,
    b.stok,
    kb.nama_kategori,
    pn.nama_penerbit,
    pu.nama_penulis,
    r.kode_rak,
    r.lokasi_rak
FROM buku          b
JOIN kategori_buku kb ON b.id_kategori = kb.id_kategori
JOIN penerbit      pn ON b.id_penerbit = pn.id_penerbit
JOIN penulis       pu ON b.id_penulis  = pu.id_penulis
JOIN rak_buku       r ON b.id_rak      = r.id_rak
ORDER BY kb.nama_kategori, b.judul_buku;

-- Q7: Anggota beserta jumlah pinjaman aktif dan total denda belum lunas
SELECT
    a.id_anggota,
    a.nama_anggota,
    a.status_anggota,
    COUNT(DISTINCT pm.id_peminjaman)             AS total_pinjaman,
    COUNT(DISTINCT CASE WHEN pm.status_pinjam = 'Dipinjam'
                        THEN pm.id_peminjaman END) AS pinjaman_aktif,
    COALESCE(SUM(CASE WHEN d.status_bayar = 'Belum Lunas'
                      THEN d.jumlah_denda ELSE 0 END), 0) AS total_denda_belum_lunas
FROM anggota  a
LEFT JOIN peminjaman      pm ON a.id_anggota       = pm.id_anggota
LEFT JOIN pengembalian    pg ON pm.id_peminjaman   = pg.id_peminjaman
LEFT JOIN denda            d ON pg.id_pengembalian = d.id_pengembalian
GROUP BY a.id_anggota, a.nama_anggota, a.status_anggota
ORDER BY total_pinjaman DESC;


-- ─── QUERY SUBQUERY / CTE ────────────────────────────────────

-- Q8: CTE – Buku yang belum pernah dipinjam (stok penuh)
WITH buku_dipinjam AS (
    SELECT DISTINCT dp.id_buku
    FROM detail_peminjaman dp
)
SELECT
    b.id_buku,
    b.judul_buku,
    kb.nama_kategori,
    b.stok
FROM buku b
JOIN kategori_buku kb ON b.id_kategori = kb.id_kategori
WHERE b.id_buku NOT IN (SELECT id_buku FROM buku_dipinjam)
ORDER BY b.judul_buku;

-- Q9: Subquery – Anggota dengan total denda di atas rata-rata denda semua anggota
SELECT
    a.nama_anggota,
    sub.total_denda
FROM (
    SELECT
        pm.id_anggota,
        SUM(d.jumlah_denda) AS total_denda
    FROM denda      d
    JOIN pengembalian pg ON d.id_pengembalian = pg.id_pengembalian
    JOIN peminjaman   pm ON pg.id_peminjaman  = pm.id_peminjaman
    GROUP BY pm.id_anggota
) sub
JOIN anggota a ON sub.id_anggota = a.id_anggota
WHERE sub.total_denda > (
    SELECT AVG(jumlah_denda) FROM denda
)
ORDER BY sub.total_denda DESC;


-- ─── QUERY AGREGAT + GROUP BY + HAVING ──────────────────────

-- Q10: 5 buku paling sering dipinjam (minimal dipinjam 2 kali)
SELECT
    b.id_buku,
    b.judul_buku,
    kb.nama_kategori,
    COUNT(dp.id_detail) AS frekuensi_pinjam
FROM detail_peminjaman dp
JOIN buku          b  ON dp.id_buku      = b.id_buku
JOIN kategori_buku kb ON b.id_kategori  = kb.id_kategori
GROUP BY b.id_buku, b.judul_buku, kb.nama_kategori
HAVING frekuensi_pinjam >= 2
ORDER BY frekuensi_pinjam DESC
LIMIT 5;