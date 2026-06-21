--  BAGIAN 6 – TRIGGER
USE perpustakaan;
DELIMITER $$

-- Trigger 1: Kurangi stok buku saat detail_peminjaman baru dimasukkan
CREATE TRIGGER trg_kurangi_stok_buku
AFTER INSERT ON detail_peminjaman
FOR EACH ROW
BEGIN
    UPDATE buku SET stok = stok - NEW.jumlah WHERE id_buku = NEW.id_buku;
END$$

-- Trigger 2: Tambah stok buku saat status peminjaman berubah jadi Selesai
CREATE TRIGGER trg_tambah_stok_saat_selesai
AFTER UPDATE ON peminjaman
FOR EACH ROW
BEGIN
    IF NEW.status_pinjam = 'Selesai' AND OLD.status_pinjam = 'Dipinjam' THEN
        UPDATE buku b
        JOIN detail_peminjaman dp ON b.id_buku = dp.id_buku
        SET b.stok = b.stok + dp.jumlah
        WHERE dp.id_peminjaman = NEW.id_peminjaman;
    END IF;
END$$

-- Trigger 3: Auto-update status reservasi menjadi Selesai
--            ketika stok buku bertambah kembali (buku dikembalikan)
CREATE TRIGGER trg_update_reservasi_setelah_kembali
AFTER UPDATE ON buku
FOR EACH ROW
BEGIN
    IF NEW.stok > 0 AND OLD.stok = 0 THEN
        UPDATE reservasi
        SET    status_reservasi = 'Selesai'
        WHERE  id_buku = NEW.id_buku
          AND  status_reservasi = 'Aktif'
        LIMIT 1;   -- hanya reservasi pertama (FIFO)
    END IF;
END$$

-- Trigger 4: Cegah penghapusan data transaksi peminjaman
CREATE TRIGGER trg_cegah_hapus_peminjaman
BEFORE DELETE ON peminjaman
FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Data peminjaman tidak boleh dihapus untuk menjaga histori transaksi.';
END$$

-- Trigger 5: Auto insert ke tabel denda saat pengembalian terlambat
--   Dipicu setiap INSERT ke pengembalian dengan terlambat_hari > 0.
--   Menghitung jumlah_denda = terlambat_hari * 2000 secara otomatis.
--   Status awal selalu 'Belum Lunas' — diupdate manual saat anggota bayar.
CREATE TRIGGER trg_auto_insert_denda
AFTER INSERT ON pengembalian
FOR EACH ROW
BEGIN
    IF NEW.terlambat_hari > 0 THEN
        INSERT INTO denda (id_pengembalian, jumlah_denda, status_bayar)
        VALUES (NEW.id_pengembalian, NEW.terlambat_hari * 2000, 'Belum Lunas');
    END IF;
END$$

DELIMITER ;


SELECT * FROM denda;
SELECT * FROM pengembalian;