USE perpustakaan;
DELIMITER $$

-- Function 1: Total denda belum lunas milik satu anggota
--   Membaca langsung dari tabel denda yang sudah tercatat,
--   sehingga hasilnya konsisten dengan data transaksi nyata.
CREATE FUNCTION fn_total_denda_anggota(p_id_anggota INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_total DECIMAL(10,2) DEFAULT 0.00;

    SELECT COALESCE(SUM(d.jumlah_denda), 0)
    INTO   v_total
    FROM   denda d
    JOIN   pengembalian pg ON d.id_pengembalian = pg.id_pengembalian
    JOIN   peminjaman   pm ON pg.id_peminjaman  = pm.id_peminjaman
    WHERE  pm.id_anggota  = p_id_anggota
      AND  d.status_bayar = 'Belum Lunas';

    RETURN v_total;
END$$

-- Function 2: Cek apakah anggota boleh meminjam (TRUE = boleh)
CREATE FUNCTION fn_boleh_pinjam(p_id_anggota INT)
RETURNS BOOLEAN
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_status        VARCHAR(20);
    DECLARE v_denda_aktif   INT DEFAULT 0;
    DECLARE v_buku_dipinjam INT DEFAULT 0;

    SELECT status_anggota INTO v_status
    FROM   anggota WHERE id_anggota = p_id_anggota;

    IF v_status != 'Aktif' THEN RETURN FALSE; END IF;

    SELECT COUNT(*) INTO v_denda_aktif
    FROM denda d
    JOIN pengembalian pg ON d.id_pengembalian = pg.id_pengembalian
    JOIN peminjaman   pm ON pg.id_peminjaman  = pm.id_peminjaman
    WHERE pm.id_anggota  = p_id_anggota
      AND d.status_bayar = 'Belum Lunas';

    IF v_denda_aktif > 0 THEN RETURN FALSE; END IF;

    SELECT COUNT(*) INTO v_buku_dipinjam
    FROM peminjaman pm
    JOIN detail_peminjaman dp ON pm.id_peminjaman = dp.id_peminjaman
    WHERE pm.id_anggota   = p_id_anggota
      AND pm.status_pinjam = 'Dipinjam';

    IF v_buku_dipinjam >= 3 THEN RETURN FALSE; END IF;

    RETURN TRUE;
END$$

DELIMITER ;

-- Contoh penggunaan function:
SELECT fn_total_denda_anggota(2) AS total_denda_belum_lunas;
SELECT fn_boleh_pinjam(1) AS boleh_pinjam;
SELECT 
    nama_anggota, 
    fn_total_denda_anggota(id_anggota) AS sisa_denda,
    fn_boleh_pinjam(id_anggota)        AS boleh_pinjam
FROM anggota;

-- ============================================================
--  SELESAI – Sistem Manajemen Perpustakaan siap digunakan.
-- ============================================================