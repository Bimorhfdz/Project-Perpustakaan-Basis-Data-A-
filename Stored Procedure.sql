-- ============================================================
--  BAGIAN 5 – STORED PROCEDURE
-- ============================================================
USE perpustakaan;
DELIMITER $$

-- SP1: Proses peminjaman buku
DROP PROCEDURE IF EXISTS sp_pinjam_buku$$
CREATE PROCEDURE sp_pinjam_buku(
    IN  p_id_anggota  INT,
    IN  p_id_petugas  INT,
    IN  p_id_buku     INT,
    OUT p_pesan        VARCHAR(200)
)
sp_label: BEGIN
    DECLARE v_status_anggota  VARCHAR(20);
    DECLARE v_denda_belum     INT DEFAULT 0;
    DECLARE v_stok            INT;
    DECLARE v_pinjam_aktif    INT;
    DECLARE v_id_peminjaman   INT;

    -- Cek status anggota
    SELECT status_anggota INTO v_status_anggota
    FROM anggota WHERE id_anggota = p_id_anggota;

    IF v_status_anggota IS NULL OR v_status_anggota != 'Aktif' THEN
        SET p_pesan = 'GAGAL: Anggota tidak aktif atau tidak ditemukan.';
        LEAVE sp_label;
    END IF;

    -- Cek denda belum lunas
    SELECT COUNT(*) INTO v_denda_belum
    FROM denda d
    JOIN pengembalian pg ON d.id_pengembalian = pg.id_pengembalian
    JOIN peminjaman   pm ON pg.id_peminjaman  = pm.id_peminjaman
    WHERE pm.id_anggota = p_id_anggota AND d.status_bayar = 'Belum Lunas';

    IF v_denda_belum > 0 THEN
        SET p_pesan = 'GAGAL: Masih ada denda belum lunas.';
        LEAVE sp_label;
    END IF;

    -- Cek batas 3 buku pinjam serentak tercapai
    SELECT COUNT(*) INTO v_pinjam_aktif
    FROM peminjaman pm
    JOIN detail_peminjaman dp ON pm.id_peminjaman = dp.id_peminjaman
    WHERE pm.id_anggota = p_id_anggota AND pm.status_pinjam = 'Dipinjam';

    IF v_pinjam_aktif >= 3 THEN
        SET p_pesan = 'GAGAL: Batas 3 buku pinjam serentak tercapai.';
        LEAVE sp_label;
    END IF;

    -- Cek stok buku
    SELECT stok INTO v_stok FROM buku WHERE id_buku = p_id_buku;
    IF v_stok IS NULL OR v_stok < 1 THEN
        SET p_pesan = 'GAGAL: Stok buku habis atau buku tidak ditemukan.';
        LEAVE sp_label;
    END IF;

    -- Insert peminjaman baru
    INSERT INTO peminjaman (id_anggota, id_petugas, tanggal_pinjam, tanggal_jatuh_tempo, status_pinjam)
    VALUES (p_id_anggota, p_id_petugas, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 7 DAY), 'Dipinjam');
    SET v_id_peminjaman = LAST_INSERT_ID();

    -- Insert detail peminjaman
    INSERT INTO detail_peminjaman (id_peminjaman, id_buku, jumlah) VALUES (v_id_peminjaman, p_id_buku, 1);

    SET p_pesan = CONCAT('BERHASIL: Peminjaman #', v_id_peminjaman, ' dicatat. Jatuh tempo: ',
                         DATE_FORMAT(DATE_ADD(CURDATE(), INTERVAL 7 DAY), '%d-%m-%Y'));
END$$


-- SP2: Proses pengembalian buku
DROP PROCEDURE IF EXISTS sp_kembalikan_buku$$
CREATE PROCEDURE sp_kembalikan_buku(
    IN  p_id_peminjaman INT,
    OUT p_pesan          VARCHAR(200)
)
sp_label: BEGIN
    DECLARE v_status       VARCHAR(20);
    DECLARE v_jatuh_tempo  DATE;
    DECLARE v_terlambat    INT DEFAULT 0;
    DECLARE v_denda        DECIMAL(10,2) DEFAULT 0;
    DECLARE v_id_kembalian INT;

    SELECT status_pinjam, tanggal_jatuh_tempo
    INTO   v_status, v_jatuh_tempo
    FROM   peminjaman WHERE id_peminjaman = p_id_peminjaman;

    IF v_status IS NULL THEN
        SET p_pesan = 'GAGAL: ID peminjaman tidak ditemukan.';
        LEAVE sp_label;
    END IF;

    IF v_status != 'Dipinjam' THEN
        SET p_pesan = 'GAGAL: Buku sudah dikembalikan atau status tidak valid.';
        LEAVE sp_label;
    END IF;

    -- Hitung keterlambatan dan denda (Rp 2.000 / hari)
    IF CURDATE() > v_jatuh_tempo THEN
        SET v_terlambat = DATEDIFF(CURDATE(), v_jatuh_tempo);
        SET v_denda     = v_terlambat * 2000;
    END IF;

    -- Insert pengembalian
    INSERT INTO pengembalian (id_peminjaman, tanggal_kembali, terlambat_hari)
    VALUES (p_id_peminjaman, CURDATE(), v_terlambat);
    SET v_id_kembalian = LAST_INSERT_ID();

    -- Insert denda jika terbukti terlambat
    IF v_denda > 0 THEN
        INSERT INTO denda (id_pengembalian, jumlah_denda, status_bayar)
        VALUES (v_id_kembalian, v_denda, 'Belum Lunas');
    END IF;

    -- Update status peminjaman menjadi Selesai
    UPDATE peminjaman SET status_pinjam = 'Selesai' WHERE id_peminjaman = p_id_peminjaman;

    IF v_denda > 0 THEN
        SET p_pesan = CONCAT('BERHASIL: Buku dikembalikan. Terlambat ', v_terlambat,
                             ' hari. Denda: Rp', FORMAT(v_denda, 0));
    ELSE
        SET p_pesan = 'BERHASIL: Buku dikembalikan tepat waktu. Tidak ada denda.';
    END IF;
END$$

DELIMITER ;

-- Menguji SP Peminjaman (Output pesan akan muncul di kolom @pesan)
CALL sp_pinjam_buku(1, 2, 3, @pesan); 
SELECT @pesan;

-- Menguji SP Pengembalian (Ganti angka 1 dengan ID Peminjaman yang aktif)
CALL sp_kembalikan_buku(1, @pesan);  
SELECT @pesan;