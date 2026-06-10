-- ============================================================
--  SISTEM MANAJEMEN PERPUSTAKAAN
--  MySQL Workbench Script
--  Mencakup: DDL, DML, Query, View, Stored Procedure,
--            Trigger, Function
-- ============================================================

DROP DATABASE IF EXISTS perpustakaan;
CREATE DATABASE perpustakaan
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;
USE perpustakaan;

-- ============================================================
--  BAGIAN 1 – DDL (CREATE TABLE)
-- ============================================================

CREATE TABLE kategori_buku (
    id_kategori   INT           NOT NULL AUTO_INCREMENT,
    nama_kategori VARCHAR(100)  NOT NULL,
    CONSTRAINT pk_kategori  PRIMARY KEY (id_kategori),
    CONSTRAINT uq_kategori  UNIQUE (nama_kategori)
);

CREATE TABLE penerbit (
    id_penerbit   INT           NOT NULL AUTO_INCREMENT,
    nama_penerbit VARCHAR(100)  NOT NULL,
    alamat        VARCHAR(255)  NOT NULL,
    no_telp       VARCHAR(20)   NOT NULL,
    CONSTRAINT pk_penerbit PRIMARY KEY (id_penerbit)
);

CREATE TABLE penulis (
    id_penulis   INT          NOT NULL AUTO_INCREMENT,
    nama_penulis VARCHAR(100) NOT NULL,
    negara       VARCHAR(50)  NOT NULL,
    CONSTRAINT pk_penulis PRIMARY KEY (id_penulis)
);

CREATE TABLE rak_buku (
    id_rak     INT          NOT NULL AUTO_INCREMENT,
    kode_rak   VARCHAR(20)  NOT NULL,
    lokasi_rak VARCHAR(100) NOT NULL,
    CONSTRAINT pk_rak    PRIMARY KEY (id_rak),
    CONSTRAINT uq_kode_rak UNIQUE (kode_rak)
);

CREATE TABLE anggota (
    id_anggota     INT                      NOT NULL AUTO_INCREMENT,
    nama_anggota   VARCHAR(100)             NOT NULL,
    jenis_kelamin  ENUM('L','P')            NOT NULL,
    alamat         VARCHAR(255)             NOT NULL,
    no_telp        VARCHAR(20)              NOT NULL,
    email          VARCHAR(100)             NOT NULL,
    tgl_daftar     DATE                     NOT NULL,
    status_anggota ENUM('Aktif','Tidak Aktif') NOT NULL DEFAULT 'Aktif',
    CONSTRAINT pk_anggota  PRIMARY KEY (id_anggota),
    CONSTRAINT uq_email    UNIQUE (email)
);

CREATE TABLE petugas (
    id_petugas   INT                       NOT NULL AUTO_INCREMENT,
    nama_petugas VARCHAR(100)              NOT NULL,
    username     VARCHAR(50)               NOT NULL,
    password     VARCHAR(255)              NOT NULL,
    level_petugas ENUM('Admin','Petugas')  NOT NULL,
    CONSTRAINT pk_petugas  PRIMARY KEY (id_petugas),
    CONSTRAINT uq_username UNIQUE (username)
);

CREATE TABLE buku (
    id_buku      INT          NOT NULL AUTO_INCREMENT,
    judul_buku   VARCHAR(200) NOT NULL,
    tahun_terbit YEAR         NOT NULL,
    isbn         VARCHAR(20)  NOT NULL,
    stok         INT          NOT NULL DEFAULT 0,
    id_kategori  INT          NOT NULL,
    id_penerbit  INT          NOT NULL,
    id_penulis   INT          NOT NULL,
    id_rak       INT          NOT NULL,
    CONSTRAINT pk_buku      PRIMARY KEY (id_buku),
    CONSTRAINT uq_isbn      UNIQUE (isbn),
    CONSTRAINT chk_stok     CHECK (stok >= 0),
    CONSTRAINT fk_buku_kat  FOREIGN KEY (id_kategori) REFERENCES kategori_buku(id_kategori),
    CONSTRAINT fk_buku_pen  FOREIGN KEY (id_penerbit) REFERENCES penerbit(id_penerbit),
    CONSTRAINT fk_buku_pnu  FOREIGN KEY (id_penulis)  REFERENCES penulis(id_penulis),
    CONSTRAINT fk_buku_rak  FOREIGN KEY (id_rak)      REFERENCES rak_buku(id_rak)
);
CREATE INDEX idx_buku_judul    ON buku(judul_buku);
CREATE INDEX idx_buku_kategori ON buku(id_kategori);

CREATE TABLE peminjaman (
    id_peminjaman       INT                       NOT NULL AUTO_INCREMENT,
    id_anggota          INT                       NOT NULL,
    id_petugas          INT                       NOT NULL,
    tanggal_pinjam      DATE                      NOT NULL,
    tanggal_jatuh_tempo DATE                      NOT NULL,
    status_pinjam       ENUM('Dipinjam','Selesai') NOT NULL DEFAULT 'Dipinjam',
    CONSTRAINT pk_peminjaman  PRIMARY KEY (id_peminjaman),
    CONSTRAINT fk_pinj_ang   FOREIGN KEY (id_anggota) REFERENCES anggota(id_anggota),
    CONSTRAINT fk_pinj_pet   FOREIGN KEY (id_petugas) REFERENCES petugas(id_petugas)
);
CREATE INDEX idx_pinj_anggota ON peminjaman(id_anggota);

CREATE TABLE detail_peminjaman (
    id_detail     INT NOT NULL AUTO_INCREMENT,
    id_peminjaman INT NOT NULL,
    id_buku       INT NOT NULL,
    jumlah        INT NOT NULL DEFAULT 1,
    CONSTRAINT pk_detail     PRIMARY KEY (id_detail),
    CONSTRAINT chk_jumlah   CHECK (jumlah >= 1),
    CONSTRAINT fk_det_pinj  FOREIGN KEY (id_peminjaman) REFERENCES peminjaman(id_peminjaman),
    CONSTRAINT fk_det_buku  FOREIGN KEY (id_buku)       REFERENCES buku(id_buku)
);

CREATE TABLE pengembalian (
    id_pengembalian INT  NOT NULL AUTO_INCREMENT,
    id_peminjaman   INT  NOT NULL,
    tanggal_kembali DATE NOT NULL,
    terlambat_hari  INT  NOT NULL DEFAULT 0,
    CONSTRAINT pk_pengembalian PRIMARY KEY (id_pengembalian),
    CONSTRAINT uq_pengemb_pinj UNIQUE (id_peminjaman),          -- 1:1
    CONSTRAINT chk_terlambat   CHECK (terlambat_hari >= 0),
    CONSTRAINT fk_kemb_pinj    FOREIGN KEY (id_peminjaman) REFERENCES peminjaman(id_peminjaman)
);

CREATE TABLE denda (
    id_denda        INT             NOT NULL AUTO_INCREMENT,
    id_pengembalian INT             NOT NULL,
    jumlah_denda    DECIMAL(10,2)   NOT NULL DEFAULT 0.00,
    status_bayar    ENUM('Lunas','Belum Lunas') NOT NULL DEFAULT 'Belum Lunas',
    CONSTRAINT pk_denda      PRIMARY KEY (id_denda),
    CONSTRAINT uq_denda_kemb UNIQUE (id_pengembalian),          -- 1:1
    CONSTRAINT chk_denda     CHECK (jumlah_denda >= 0),
    CONSTRAINT fk_denda_kemb FOREIGN KEY (id_pengembalian) REFERENCES pengembalian(id_pengembalian)
);

CREATE TABLE reservasi (
    id_reservasi      INT  NOT NULL AUTO_INCREMENT,
    id_anggota        INT  NOT NULL,
    id_buku           INT  NOT NULL,
    tanggal_reservasi DATE NOT NULL,
    status_reservasi  ENUM('Aktif','Selesai','Batal') NOT NULL DEFAULT 'Aktif',
    CONSTRAINT pk_reservasi PRIMARY KEY (id_reservasi),
    CONSTRAINT fk_res_ang   FOREIGN KEY (id_anggota) REFERENCES anggota(id_anggota),
    CONSTRAINT fk_res_buku  FOREIGN KEY (id_buku)    REFERENCES buku(id_buku)
);