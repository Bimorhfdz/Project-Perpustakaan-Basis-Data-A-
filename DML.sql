--  BAGIAN 2 – DML (INSERT DATA DUMMY)
USE perpustakaan;
-- ── Kategori Buku ────────────────────────────────────────────
INSERT INTO kategori_buku (nama_kategori) VALUES
('Teknologi Informasi'),
('Matematika'),
('Bahasa & Sastra'),
('Sejarah'),
('Ekonomi & Bisnis'),
('Ilmu Sosial'),
('Kesehatan'),
('Hukum');

-- ── Penerbit ─────────────────────────────────────────────────
INSERT INTO penerbit (nama_penerbit, alamat, no_telp) VALUES
('Andi Publisher',     'Jl. Beo 38-40, Yogyakarta',        '0274-560264'),
('Elex Media',         'Jl. Palmerah Barat 29-37, Jakarta', '021-5347503'),
('Informatika',        'Jl. Merdeka 2, Bandung',            '022-4203448'),
('Gramedia Pustaka',   'Jl. Palmerah Selatan 22, Jakarta',  '021-5300660'),
('Rajawali Press',     'Jl. Prof. Hamka, Jakarta',          '021-7401960'),
('Bumi Aksara',        'Jl. Sawo Raya 18, Jakarta',         '021-8908112'),
('Erlangga',           'Jl. H. Baping Raya 100, Jakarta',   '021-4603082'),
('Prenada Media',      'Jl. Tambra Raya 23, Jakarta',       '021-4243444');

-- ── Penulis ──────────────────────────────────────────────────
INSERT INTO penulis (nama_penulis, negara) VALUES
('Abdul Kadir',       'Indonesia'),
('Bunafit Nugroho',   'Indonesia'),
('Rosa Ariani Sukamto','Indonesia'),
('Fathansyah',        'Indonesia'),
('Jogiyanto HM',      'Indonesia'),
('Edhy Sutanta',      'Indonesia'),
('Donald Knuth',      'Amerika Serikat'),
('Thomas Cormen',     'Amerika Serikat');

-- ── Rak Buku ─────────────────────────────────────────────────
INSERT INTO rak_buku (kode_rak, lokasi_rak) VALUES
('R-A01', 'Lantai 1 – Baris A'),
('R-A02', 'Lantai 1 – Baris B'),
('R-B01', 'Lantai 2 – Baris A'),
('R-B02', 'Lantai 2 – Baris B'),
('R-C01', 'Lantai 3 – Baris A');

-- ── Buku ─────────────────────────────────────────────────────
INSERT INTO buku (judul_buku, tahun_terbit, isbn, stok, id_kategori, id_penerbit, id_penulis, id_rak) VALUES
('Pengantar Sistem Basis Data',         2020, '978-979-29-1001-1', 5, 1, 1, 1, 1),
('MySQL untuk Pemula',                  2021, '978-979-29-1002-2', 4, 1, 2, 2, 1),
('Algoritma dan Pemrograman',           2019, '978-979-29-1003-3', 3, 1, 3, 3, 2),
('Rekayasa Perangkat Lunak',            2022, '978-979-29-1004-4', 4, 1, 3, 3, 2),
('Basis Data Relasional',               2020, '978-979-29-1005-5', 2, 1, 1, 4, 1),
('Matematika Diskrit',                  2018, '978-979-29-1006-6', 3, 2, 5, 5, 3),
('Kalkulus untuk Teknik',               2021, '978-979-29-1007-7', 4, 2, 7, 8, 3),
('Bahasa Indonesia Akademik',           2019, '978-979-29-1008-8', 5, 3, 4, 1, 4),
('Sejarah Peradaban Islam',             2017, '978-979-29-1009-9', 3, 4, 6, 6, 4),
('Ekonomi Mikro Terapan',              2022, '978-979-29-1010-0', 4, 5, 8, 7, 5),
('Manajemen Keuangan',                  2023, '978-979-29-1011-1', 5, 5, 7, 5, 5),
('Sosiologi Modern',                    2020, '978-979-29-1012-2', 3, 6, 5, 6, 3),
('Ilmu Kesehatan Masyarakat',           2021, '978-979-29-1013-3', 4, 7, 4, 2, 4),
('Hukum Perdata Indonesia',             2019, '978-979-29-1014-4', 2, 8, 6, 1, 5),
('Struktur Data dengan C++',            2022, '978-979-29-1015-5', 5, 1, 3, 3, 1),
('Jaringan Komputer',                   2021, '978-979-29-1016-6', 3, 1, 2, 2, 2),
('Pemrograman Web dengan PHP',          2023, '978-979-29-1017-7', 6, 1, 1, 4, 1),
('The Art of Computer Programming',    2011, '978-020-13-5205-6', 2, 1, 2, 7, 2),
('Introduction to Algorithms',          2009, '978-026-20-3293-7', 2, 1, 3, 8, 2),
('Statistika untuk Penelitian',         2020, '978-979-29-1020-0', 4, 2, 5, 5, 3);

-- ── Anggota ──────────────────────────────────────────────────
INSERT INTO anggota (nama_anggota, jenis_kelamin, alamat, no_telp, email, tgl_daftar, status_anggota) VALUES
('Budi Pratikno',       'L', 'Jl. Melati 5, Purwokerto',     '08112345601', 'budi@email.com',       '2024-01-10', 'Aktif'),
('Siti Rahayu',        'P', 'Jl. Dahlia 12, Purwokerto',    '08112345602', 'siti@email.com',       '2024-01-15', 'Aktif'),
('Andi Prasetyo',      'L', 'Jl. Mawar 3, Banyumas',        '08112345603', 'andi@email.com',       '2024-02-01', 'Aktif'),
('Dewi Lestari',       'P', 'Jl. Kenanga 7, Purwokerto',    '08112345604', 'dewi@email.com',       '2024-02-14', 'Aktif'),
('Rudi Hermawan',      'L', 'Jl. Cempaka 9, Cilacap',       '08112345605', 'rudi@email.com',       '2024-03-05', 'Aktif'),
('Fitri Handayani',    'P', 'Jl. Anggrek 21, Purwokerto',   '08112345606', 'fitri@email.com',      '2024-03-20', 'Aktif'),
('Hendra Wijaya',      'L', 'Jl. Tulip 14, Banyumas',       '08112345607', 'hendra@email.com',     '2024-04-01', 'Aktif'),
('Yuni Astuti',        'P', 'Jl. Seruni 6, Purbalingga',    '08112345608', 'yuni@email.com',       '2024-04-10', 'Aktif'),
('Bagas Kurniawan',    'L', 'Jl. Flamboyan 2, Purwokerto',  '08112345609', 'bagas@email.com',      '2024-05-01', 'Aktif'),
('Nadia Permata',      'P', 'Jl. Lavender 8, Cilacap',      '08112345610', 'nadia@email.com',      '2024-05-15', 'Aktif'),
('Teguh Wibowo',       'L', 'Jl. Bougenville 3, Banyumas',  '08112345611', 'teguh@email.com',      '2024-06-01', 'Aktif'),
('Rina Safitri',       'P', 'Jl. Alamanda 11, Purwokerto',  '08112345612', 'rina@email.com',       '2024-06-10', 'Aktif'),
('Dodi Nugroho',       'L', 'Jl. Kamboja 5, Purbalingga',   '08112345613', 'dodi@email.com',       '2024-07-01', 'Tidak Aktif'),
('Laras Maharani',     'P', 'Jl. Melati 18, Purwokerto',    '08112345614', 'laras@email.com',      '2024-07-20', 'Aktif'),
('Wahyu Hidayat',      'L', 'Jl. Kenanga 30, Cilacap',      '08112345615', 'wahyu@email.com',      '2024-08-05', 'Aktif');

-- ── Petugas ──────────────────────────────────────────────────
INSERT INTO petugas (nama_petugas, username, password, level_petugas) VALUES
('Admin Perpustakaan', 'admin',   SHA2('admin123',  256), 'Admin'),
('Rina Wulandari',     'rina',    SHA2('rina1234',   256), 'Petugas'),
('Deni Saputra',       'deni',    SHA2('deni1234',   256), 'Petugas'),
('Lilis Suryani',      'lilis',   SHA2('lilis1234',  256), 'Petugas');

-- ── Peminjaman ───────────────────────────────────────────────
INSERT INTO peminjaman (id_anggota, id_petugas, tanggal_pinjam, tanggal_jatuh_tempo, status_pinjam) VALUES
(1,  2, '2025-11-01', '2025-11-08', 'Selesai'),   -- #1
(2,  3, '2025-11-03', '2025-11-10', 'Selesai'),   -- #2
(3,  2, '2025-11-05', '2025-11-12', 'Selesai'),   -- #3
(4,  4, '2025-11-10', '2025-11-17', 'Selesai'),   -- #4
(5,  2, '2025-11-12', '2025-11-19', 'Selesai'),   -- #5
(6,  3, '2025-11-15', '2025-11-22', 'Selesai'),   -- #6
(7,  4, '2025-11-20', '2025-11-27', 'Selesai'),   -- #7
(8,  2, '2025-12-01', '2025-12-08', 'Selesai'),   -- #8
(9,  3, '2025-12-03', '2025-12-10', 'Selesai'),   -- #9
(10, 4, '2025-12-05', '2025-12-12', 'Selesai'),   -- #10
(1,  2, '2025-12-10', '2025-12-17', 'Selesai'),   -- #11
(2,  3, '2025-12-15', '2025-12-22', 'Selesai'),   -- #12
(11, 4, '2026-01-05', '2026-01-12', 'Selesai'),   -- #13
(12, 2, '2026-01-10', '2026-01-17', 'Selesai'),   -- #14
(14, 3, '2026-01-15', '2026-01-22', 'Selesai'),   -- #15
(15, 4, '2026-02-01', '2026-02-08', 'Selesai'),   -- #16
(3,  2, '2026-02-10', '2026-02-17', 'Selesai'),   -- #17
(5,  3, '2026-03-01', '2026-03-08', 'Selesai'),   -- #18
(6,  4, '2026-04-01', '2026-04-08', 'Dipinjam'),  -- #19
(8,  2, '2026-05-20', '2026-05-27', 'Dipinjam'),  -- #20
(9,  3, '2026-06-01', '2026-06-08', 'Dipinjam'),  -- #21
(10, 4, '2026-06-03', '2026-06-10', 'Dipinjam');  -- #22

-- ── Detail Peminjaman ────────────────────────────────────────
INSERT INTO detail_peminjaman (id_peminjaman, id_buku, jumlah) VALUES
(1,  1, 1),(1, 2, 1),
(2,  3, 1),
(3,  5, 1),(3, 6, 1),
(4,  7, 1),
(5,  1, 1),(5, 8, 1),
(6,  9, 1),
(7, 10, 1),(7, 11, 1),
(8, 12, 1),
(9,  3, 1),(9, 15, 1),
(10, 16, 1),
(11, 17, 1),
(12,  4, 1),
(13,  2, 1),(13, 5, 1),
(14, 13, 1),
(15,  6, 1),(15, 7, 1),
(16, 14, 1),
(17,  1, 1),
(18, 10, 1),(18, 11, 1),
(19, 20, 1),
(20, 15, 1),
(21,  2, 1),
(22, 17, 1);

-- 4. Insert pengembalian ulang (trigger akan otomatis isi denda)
INSERT INTO pengembalian (id_peminjaman, tanggal_kembali, terlambat_hari) VALUES
(1,  '2025-11-08',  0),
(2,  '2025-11-15',  5),
(3,  '2025-11-12',  0),
(4,  '2025-11-21',  4),
(5,  '2025-11-19',  0),
(6,  '2025-11-29',  7),
(7,  '2025-11-27',  0),
(8,  '2025-12-11',  3),
(9,  '2025-12-10',  0),
(10, '2025-12-18',  6),
(11, '2025-12-17',  0),
(12, '2025-12-30',  8),
(13, '2026-01-12',  0),
(14, '2026-01-19',  2),
(15, '2026-01-22',  0),
(16, '2026-02-08',  0),
(17, '2026-02-22',  5),
(18, '2026-03-14',  6);

-- ── Denda ────────────────────────────────────────────────────
-- Tabel denda TIDAK diisi manual di DML.
-- Trigger trg_auto_insert_denda akan otomatis mengisi tabel ini
-- setiap kali ada INSERT ke pengembalian dengan terlambat_hari > 0.
-- Rumus: jumlah_denda = terlambat_hari * 2000. Status awal: 'Belum Lunas'.

-- ── Reservasi ────────────────────────────────────────────────
INSERT INTO reservasi (id_anggota, id_buku, tanggal_reservasi, status_reservasi) VALUES
(4,  5, '2025-11-02', 'Selesai'),
(7, 14, '2025-11-25', 'Selesai'),
(11, 1, '2026-01-06', 'Aktif'),
(12, 3, '2026-02-11', 'Aktif'),
(14, 5, '2026-03-10', 'Batal'),
(15, 2, '2026-04-01', 'Aktif'),
(1, 17, '2026-06-02', 'Aktif');


SELECT * FROM buku;
SELECT * FROM anggota;