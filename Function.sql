-- ============================================================
--  BAGIAN 7 – FUNCTION
-- ============================================================
USE perpustakaan;
DELIMITER $$

-- Function 1: Hitung denda berdasarkan id_peminjaman
CREATE FUNCTION fn_hitung_denda(p_id_peminjaman INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_jatuh_tempo DATE;
    DECLARE v_terlambat   INT DEFAULT 0;

    SELECT tanggal_jatuh_tempo INTO v_jatuh_tempo
    FROM   peminjaman WHERE id_peminjaman = p_id_peminjaman;

    IF v_jatuh_tempo IS NULL THEN
        RETURN 0;
    END IF;

    IF CURDATE() > v_jatuh_tempo THEN
        SET v_terlambat = DATEDIFF(CURDATE(), v_jatuh_tempo);
    END IF;

    RETURN v_terlambat * 2000;
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
SELECT fn_hitung_denda(19) AS estimasi_denda;
SELECT fn_boleh_pinjam(1) AS boleh_pinjam;
SELECT nama_anggota, fn_boleh_pinjam(id_anggota) AS boleh_pinjam FROM anggota;


-- ============================================================
--  SELESAI – Sistem Manajemen Perpustakaan siap digunakan.
-- ============================================================