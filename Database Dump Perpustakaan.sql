-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: perpustakaan
-- ------------------------------------------------------
-- Server version	8.4.8

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `anggota`
--

DROP TABLE IF EXISTS `anggota`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anggota` (
  `id_anggota` int NOT NULL AUTO_INCREMENT,
  `nama_anggota` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jenis_kelamin` enum('L','P') COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamat` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_telp` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tgl_daftar` date NOT NULL,
  `status_anggota` enum('Aktif','Tidak Aktif') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Aktif',
  PRIMARY KEY (`id_anggota`),
  UNIQUE KEY `uq_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `anggota`
--

LOCK TABLES `anggota` WRITE;
/*!40000 ALTER TABLE `anggota` DISABLE KEYS */;
INSERT INTO `anggota` VALUES (1,'Budi Santoso','L','Jl. Melati 5, Purwokerto','08112345601','budi@email.com','2024-01-10','Aktif'),(2,'Siti Rahayu','P','Jl. Dahlia 12, Purwokerto','08112345602','siti@email.com','2024-01-15','Aktif'),(3,'Andi Prasetyo','L','Jl. Mawar 3, Banyumas','08112345603','andi@email.com','2024-02-01','Aktif'),(4,'Dewi Lestari','P','Jl. Kenanga 7, Purwokerto','08112345604','dewi@email.com','2024-02-14','Aktif'),(5,'Rudi Hermawan','L','Jl. Cempaka 9, Cilacap','08112345605','rudi@email.com','2024-03-05','Aktif'),(6,'Fitri Handayani','P','Jl. Anggrek 21, Purwokerto','08112345606','fitri@email.com','2024-03-20','Aktif'),(7,'Hendra Wijaya','L','Jl. Tulip 14, Banyumas','08112345607','hendra@email.com','2024-04-01','Aktif'),(8,'Yuni Astuti','P','Jl. Seruni 6, Purbalingga','08112345608','yuni@email.com','2024-04-10','Aktif'),(9,'Bagas Kurniawan','L','Jl. Flamboyan 2, Purwokerto','08112345609','bagas@email.com','2024-05-01','Aktif'),(10,'Nadia Permata','P','Jl. Lavender 8, Cilacap','08112345610','nadia@email.com','2024-05-15','Aktif'),(11,'Teguh Wibowo','L','Jl. Bougenville 3, Banyumas','08112345611','teguh@email.com','2024-06-01','Aktif'),(12,'Rina Safitri','P','Jl. Alamanda 11, Purwokerto','08112345612','rina@email.com','2024-06-10','Aktif'),(13,'Dodi Nugroho','L','Jl. Kamboja 5, Purbalingga','08112345613','dodi@email.com','2024-07-01','Tidak Aktif'),(14,'Laras Maharani','P','Jl. Melati 18, Purwokerto','08112345614','laras@email.com','2024-07-20','Aktif'),(15,'Wahyu Hidayat','L','Jl. Kenanga 30, Cilacap','08112345615','wahyu@email.com','2024-08-05','Aktif');
/*!40000 ALTER TABLE `anggota` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buku`
--

DROP TABLE IF EXISTS `buku`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buku` (
  `id_buku` int NOT NULL AUTO_INCREMENT,
  `judul_buku` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tahun_terbit` year NOT NULL,
  `isbn` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stok` int NOT NULL DEFAULT '0',
  `id_kategori` int NOT NULL,
  `id_penerbit` int NOT NULL,
  `id_penulis` int NOT NULL,
  `id_rak` int NOT NULL,
  PRIMARY KEY (`id_buku`),
  UNIQUE KEY `uq_isbn` (`isbn`),
  KEY `fk_buku_pen` (`id_penerbit`),
  KEY `fk_buku_pnu` (`id_penulis`),
  KEY `fk_buku_rak` (`id_rak`),
  KEY `idx_buku_judul` (`judul_buku`),
  KEY `idx_buku_kategori` (`id_kategori`),
  CONSTRAINT `fk_buku_kat` FOREIGN KEY (`id_kategori`) REFERENCES `kategori_buku` (`id_kategori`),
  CONSTRAINT `fk_buku_pen` FOREIGN KEY (`id_penerbit`) REFERENCES `penerbit` (`id_penerbit`),
  CONSTRAINT `fk_buku_pnu` FOREIGN KEY (`id_penulis`) REFERENCES `penulis` (`id_penulis`),
  CONSTRAINT `fk_buku_rak` FOREIGN KEY (`id_rak`) REFERENCES `rak_buku` (`id_rak`),
  CONSTRAINT `chk_stok` CHECK ((`stok` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buku`
--

LOCK TABLES `buku` WRITE;
/*!40000 ALTER TABLE `buku` DISABLE KEYS */;
INSERT INTO `buku` VALUES (1,'Pengantar Sistem Basis Data',2020,'978-979-29-1001-1',2,1,1,1,1),(2,'MySQL untuk Pemula',2021,'978-979-29-1002-2',1,1,2,2,1),(3,'Algoritma dan Pemrograman',2019,'978-979-29-1003-3',1,1,3,3,2),(4,'Rekayasa Perangkat Lunak',2022,'978-979-29-1004-4',3,1,3,3,2),(5,'Basis Data Relasional',2020,'978-979-29-1005-5',0,1,1,4,1),(6,'Matematika Diskrit',2018,'978-979-29-1006-6',1,2,5,5,3),(7,'Kalkulus untuk Teknik',2021,'978-979-29-1007-7',2,2,7,8,3),(8,'Bahasa Indonesia Akademik',2019,'978-979-29-1008-8',4,3,4,1,4),(9,'Sejarah Peradaban Islam',2017,'978-979-29-1009-9',2,4,6,6,4),(10,'Ekonomi Mikro Terapan',2022,'978-979-29-1010-0',2,5,8,7,5),(11,'Manajemen Keuangan',2023,'978-979-29-1011-1',3,5,7,5,5),(12,'Sosiologi Modern',2020,'978-979-29-1012-2',2,6,5,6,3),(13,'Ilmu Kesehatan Masyarakat',2021,'978-979-29-1013-3',3,7,4,2,4),(14,'Hukum Perdata Indonesia',2019,'978-979-29-1014-4',1,8,6,1,5),(15,'Struktur Data dengan C++',2022,'978-979-29-1015-5',3,1,3,3,1),(16,'Jaringan Komputer',2021,'978-979-29-1016-6',2,1,2,2,2),(17,'Pemrograman Web dengan PHP',2023,'978-979-29-1017-7',4,1,1,4,1),(18,'The Art of Computer Programming',2011,'978-020-13-5205-6',2,1,2,7,2),(19,'Introduction to Algorithms',2009,'978-026-20-3293-7',2,1,3,8,2),(20,'Statistika untuk Penelitian',2020,'978-979-29-1020-0',3,2,5,5,3);
/*!40000 ALTER TABLE `buku` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `denda`
--

DROP TABLE IF EXISTS `denda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `denda` (
  `id_denda` int NOT NULL AUTO_INCREMENT,
  `id_pengembalian` int NOT NULL,
  `jumlah_denda` decimal(10,2) NOT NULL DEFAULT '0.00',
  `status_bayar` enum('Lunas','Belum Lunas') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Belum Lunas',
  PRIMARY KEY (`id_denda`),
  UNIQUE KEY `uq_denda_kemb` (`id_pengembalian`),
  CONSTRAINT `fk_denda_kemb` FOREIGN KEY (`id_pengembalian`) REFERENCES `pengembalian` (`id_pengembalian`),
  CONSTRAINT `chk_denda` CHECK ((`jumlah_denda` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `denda`
--

LOCK TABLES `denda` WRITE;
/*!40000 ALTER TABLE `denda` DISABLE KEYS */;
INSERT INTO `denda` VALUES (1,2,10000.00,'Belum Lunas'),(2,4,8000.00,'Belum Lunas'),(3,6,14000.00,'Belum Lunas'),(4,8,6000.00,'Belum Lunas'),(5,10,12000.00,'Belum Lunas'),(6,12,16000.00,'Belum Lunas'),(7,14,4000.00,'Belum Lunas'),(8,17,10000.00,'Belum Lunas'),(9,18,12000.00,'Belum Lunas');
/*!40000 ALTER TABLE `denda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detail_peminjaman`
--

DROP TABLE IF EXISTS `detail_peminjaman`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detail_peminjaman` (
  `id_detail` int NOT NULL AUTO_INCREMENT,
  `id_peminjaman` int NOT NULL,
  `id_buku` int NOT NULL,
  `jumlah` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_detail`),
  KEY `fk_det_pinj` (`id_peminjaman`),
  KEY `fk_det_buku` (`id_buku`),
  CONSTRAINT `fk_det_buku` FOREIGN KEY (`id_buku`) REFERENCES `buku` (`id_buku`),
  CONSTRAINT `fk_det_pinj` FOREIGN KEY (`id_peminjaman`) REFERENCES `peminjaman` (`id_peminjaman`),
  CONSTRAINT `chk_jumlah` CHECK ((`jumlah` >= 1))
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detail_peminjaman`
--

LOCK TABLES `detail_peminjaman` WRITE;
/*!40000 ALTER TABLE `detail_peminjaman` DISABLE KEYS */;
INSERT INTO `detail_peminjaman` VALUES (1,1,1,1),(2,1,2,1),(3,2,3,1),(4,3,5,1),(5,3,6,1),(6,4,7,1),(7,5,1,1),(8,5,8,1),(9,6,9,1),(10,7,10,1),(11,7,11,1),(12,8,12,1),(13,9,3,1),(14,9,15,1),(15,10,16,1),(16,11,17,1),(17,12,4,1),(18,13,2,1),(19,13,5,1),(20,14,13,1),(21,15,6,1),(22,15,7,1),(23,16,14,1),(24,17,1,1),(25,18,10,1),(26,18,11,1),(27,19,20,1),(28,20,15,1),(29,21,2,1),(30,22,17,1),(31,1,1,1),(32,1,2,1),(33,2,3,1),(34,3,5,1),(35,3,6,1),(36,4,7,1),(37,5,1,1),(38,5,8,1),(39,6,9,1),(40,7,10,1),(41,7,11,1),(42,8,12,1),(43,9,3,1),(44,9,15,1),(45,10,16,1),(46,11,17,1),(47,12,4,1),(48,13,2,1),(49,13,5,1),(50,14,13,1),(51,15,6,1),(52,15,7,1),(53,16,14,1),(54,17,1,1),(55,18,10,1),(56,18,11,1),(57,19,20,1),(58,20,15,1),(59,21,2,1),(60,22,17,1);
/*!40000 ALTER TABLE `detail_peminjaman` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kategori_buku`
--

DROP TABLE IF EXISTS `kategori_buku`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kategori_buku` (
  `id_kategori` int NOT NULL AUTO_INCREMENT,
  `nama_kategori` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_kategori`),
  UNIQUE KEY `uq_kategori` (`nama_kategori`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kategori_buku`
--

LOCK TABLES `kategori_buku` WRITE;
/*!40000 ALTER TABLE `kategori_buku` DISABLE KEYS */;
INSERT INTO `kategori_buku` VALUES (3,'Bahasa & Sastra'),(5,'Ekonomi & Bisnis'),(8,'Hukum'),(6,'Ilmu Sosial'),(7,'Kesehatan'),(2,'Matematika'),(4,'Sejarah'),(1,'Teknologi Informasi');
/*!40000 ALTER TABLE `kategori_buku` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `peminjaman`
--

DROP TABLE IF EXISTS `peminjaman`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `peminjaman` (
  `id_peminjaman` int NOT NULL AUTO_INCREMENT,
  `id_anggota` int NOT NULL,
  `id_petugas` int NOT NULL,
  `tanggal_pinjam` date NOT NULL,
  `tanggal_jatuh_tempo` date NOT NULL,
  `status_pinjam` enum('Dipinjam','Selesai') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Dipinjam',
  PRIMARY KEY (`id_peminjaman`),
  KEY `fk_pinj_pet` (`id_petugas`),
  KEY `idx_pinj_anggota` (`id_anggota`),
  CONSTRAINT `fk_pinj_ang` FOREIGN KEY (`id_anggota`) REFERENCES `anggota` (`id_anggota`),
  CONSTRAINT `fk_pinj_pet` FOREIGN KEY (`id_petugas`) REFERENCES `petugas` (`id_petugas`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `peminjaman`
--

LOCK TABLES `peminjaman` WRITE;
/*!40000 ALTER TABLE `peminjaman` DISABLE KEYS */;
INSERT INTO `peminjaman` VALUES (1,1,2,'2025-11-01','2025-11-08','Selesai'),(2,2,3,'2025-11-03','2025-11-10','Selesai'),(3,3,2,'2025-11-05','2025-11-12','Selesai'),(4,4,4,'2025-11-10','2025-11-17','Selesai'),(5,5,2,'2025-11-12','2025-11-19','Selesai'),(6,6,3,'2025-11-15','2025-11-22','Selesai'),(7,7,4,'2025-11-20','2025-11-27','Selesai'),(8,8,2,'2025-12-01','2025-12-08','Selesai'),(9,9,3,'2025-12-03','2025-12-10','Selesai'),(10,10,4,'2025-12-05','2025-12-12','Selesai'),(11,1,2,'2025-12-10','2025-12-17','Selesai'),(12,2,3,'2025-12-15','2025-12-22','Selesai'),(13,11,4,'2026-01-05','2026-01-12','Selesai'),(14,12,2,'2026-01-10','2026-01-17','Selesai'),(15,14,3,'2026-01-15','2026-01-22','Selesai'),(16,15,4,'2026-02-01','2026-02-08','Selesai'),(17,3,2,'2026-02-10','2026-02-17','Selesai'),(18,5,3,'2026-03-01','2026-03-08','Selesai'),(19,6,4,'2026-04-01','2026-04-08','Dipinjam'),(20,8,2,'2026-05-20','2026-05-27','Dipinjam'),(21,9,3,'2026-06-01','2026-06-08','Dipinjam'),(22,10,4,'2026-06-03','2026-06-10','Dipinjam'),(23,1,2,'2025-11-01','2025-11-08','Selesai'),(24,2,3,'2025-11-03','2025-11-10','Selesai'),(25,3,2,'2025-11-05','2025-11-12','Selesai'),(26,4,4,'2025-11-10','2025-11-17','Selesai'),(27,5,2,'2025-11-12','2025-11-19','Selesai'),(28,6,3,'2025-11-15','2025-11-22','Selesai'),(29,7,4,'2025-11-20','2025-11-27','Selesai'),(30,8,2,'2025-12-01','2025-12-08','Selesai'),(31,9,3,'2025-12-03','2025-12-10','Selesai'),(32,10,4,'2025-12-05','2025-12-12','Selesai'),(33,1,2,'2025-12-10','2025-12-17','Selesai'),(34,2,3,'2025-12-15','2025-12-22','Selesai'),(35,11,4,'2026-01-05','2026-01-12','Selesai'),(36,12,2,'2026-01-10','2026-01-17','Selesai'),(37,14,3,'2026-01-15','2026-01-22','Selesai'),(38,15,4,'2026-02-01','2026-02-08','Selesai'),(39,3,2,'2026-02-10','2026-02-17','Selesai'),(40,5,3,'2026-03-01','2026-03-08','Selesai'),(41,6,4,'2026-04-01','2026-04-08','Dipinjam'),(42,8,2,'2026-05-20','2026-05-27','Dipinjam'),(43,9,3,'2026-06-01','2026-06-08','Dipinjam'),(44,10,4,'2026-06-03','2026-06-10','Dipinjam');
/*!40000 ALTER TABLE `peminjaman` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `penerbit`
--

DROP TABLE IF EXISTS `penerbit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `penerbit` (
  `id_penerbit` int NOT NULL AUTO_INCREMENT,
  `nama_penerbit` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamat` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_telp` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_penerbit`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `penerbit`
--

LOCK TABLES `penerbit` WRITE;
/*!40000 ALTER TABLE `penerbit` DISABLE KEYS */;
INSERT INTO `penerbit` VALUES (1,'Andi Publisher','Jl. Beo 38-40, Yogyakarta','0274-560264'),(2,'Elex Media','Jl. Palmerah Barat 29-37, Jakarta','021-5347503'),(3,'Informatika','Jl. Merdeka 2, Bandung','022-4203448'),(4,'Gramedia Pustaka','Jl. Palmerah Selatan 22, Jakarta','021-5300660'),(5,'Rajawali Press','Jl. Prof. Hamka, Jakarta','021-7401960'),(6,'Bumi Aksara','Jl. Sawo Raya 18, Jakarta','021-8908112'),(7,'Erlangga','Jl. H. Baping Raya 100, Jakarta','021-4603082'),(8,'Prenada Media','Jl. Tambra Raya 23, Jakarta','021-4243444'),(9,'Andi Publisher','Jl. Beo 38-40, Yogyakarta','0274-560264'),(10,'Elex Media','Jl. Palmerah Barat 29-37, Jakarta','021-5347503'),(11,'Informatika','Jl. Merdeka 2, Bandung','022-4203448'),(12,'Gramedia Pustaka','Jl. Palmerah Selatan 22, Jakarta','021-5300660'),(13,'Rajawali Press','Jl. Prof. Hamka, Jakarta','021-7401960'),(14,'Bumi Aksara','Jl. Sawo Raya 18, Jakarta','021-8908112'),(15,'Erlangga','Jl. H. Baping Raya 100, Jakarta','021-4603082'),(16,'Prenada Media','Jl. Tambra Raya 23, Jakarta','021-4243444');
/*!40000 ALTER TABLE `penerbit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pengembalian`
--

DROP TABLE IF EXISTS `pengembalian`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pengembalian` (
  `id_pengembalian` int NOT NULL AUTO_INCREMENT,
  `id_peminjaman` int NOT NULL,
  `tanggal_kembali` date NOT NULL,
  `terlambat_hari` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_pengembalian`),
  UNIQUE KEY `uq_pengemb_pinj` (`id_peminjaman`),
  CONSTRAINT `fk_kemb_pinj` FOREIGN KEY (`id_peminjaman`) REFERENCES `peminjaman` (`id_peminjaman`),
  CONSTRAINT `chk_terlambat` CHECK ((`terlambat_hari` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pengembalian`
--

LOCK TABLES `pengembalian` WRITE;
/*!40000 ALTER TABLE `pengembalian` DISABLE KEYS */;
INSERT INTO `pengembalian` VALUES (1,1,'2025-11-08',0),(2,2,'2025-11-15',5),(3,3,'2025-11-12',0),(4,4,'2025-11-21',4),(5,5,'2025-11-19',0),(6,6,'2025-11-29',7),(7,7,'2025-11-27',0),(8,8,'2025-12-11',3),(9,9,'2025-12-10',0),(10,10,'2025-12-18',6),(11,11,'2025-12-17',0),(12,12,'2025-12-30',8),(13,13,'2026-01-12',0),(14,14,'2026-01-19',2),(15,15,'2026-01-22',0),(16,16,'2026-02-08',0),(17,17,'2026-02-22',5),(18,18,'2026-03-14',6);
/*!40000 ALTER TABLE `pengembalian` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `penulis`
--

DROP TABLE IF EXISTS `penulis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `penulis` (
  `id_penulis` int NOT NULL AUTO_INCREMENT,
  `nama_penulis` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `negara` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_penulis`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `penulis`
--

LOCK TABLES `penulis` WRITE;
/*!40000 ALTER TABLE `penulis` DISABLE KEYS */;
INSERT INTO `penulis` VALUES (1,'Abdul Kadir','Indonesia'),(2,'Bunafit Nugroho','Indonesia'),(3,'Rosa Ariani Sukamto','Indonesia'),(4,'Fathansyah','Indonesia'),(5,'Jogiyanto HM','Indonesia'),(6,'Edhy Sutanta','Indonesia'),(7,'Donald Knuth','Amerika Serikat'),(8,'Thomas Cormen','Amerika Serikat'),(9,'Abdul Kadir','Indonesia'),(10,'Bunafit Nugroho','Indonesia'),(11,'Rosa Ariani Sukamto','Indonesia'),(12,'Fathansyah','Indonesia'),(13,'Jogiyanto HM','Indonesia'),(14,'Edhy Sutanta','Indonesia'),(15,'Donald Knuth','Amerika Serikat'),(16,'Thomas Cormen','Amerika Serikat');
/*!40000 ALTER TABLE `penulis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `petugas`
--

DROP TABLE IF EXISTS `petugas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `petugas` (
  `id_petugas` int NOT NULL AUTO_INCREMENT,
  `nama_petugas` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `level_petugas` enum('Admin','Petugas') COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_petugas`),
  UNIQUE KEY `uq_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `petugas`
--

LOCK TABLES `petugas` WRITE;
/*!40000 ALTER TABLE `petugas` DISABLE KEYS */;
INSERT INTO `petugas` VALUES (1,'Admin Perpustakaan','admin','240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9','Admin'),(2,'Rina Wulandari','rina','eb58be504b5e2d7e2431110a38b7ab3d3b0f674487f2d23faa04b9b2eb5d3ea1','Petugas'),(3,'Deni Saputra','deni','04c6026878448b9da05c8fe3ed1d77f78b1ac667a27a6dc0a65bbd9c2231d07d','Petugas'),(4,'Lilis Suryani','lilis','49e14c99c6ab721c70876fcd6c9621d54b173a8108b9fb325c01ec935c8d92f5','Petugas');
/*!40000 ALTER TABLE `petugas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rak_buku`
--

DROP TABLE IF EXISTS `rak_buku`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rak_buku` (
  `id_rak` int NOT NULL AUTO_INCREMENT,
  `kode_rak` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lokasi_rak` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_rak`),
  UNIQUE KEY `uq_kode_rak` (`kode_rak`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rak_buku`
--

LOCK TABLES `rak_buku` WRITE;
/*!40000 ALTER TABLE `rak_buku` DISABLE KEYS */;
INSERT INTO `rak_buku` VALUES (1,'R-A01','Lantai 1 – Baris A'),(2,'R-A02','Lantai 1 – Baris B'),(3,'R-B01','Lantai 2 – Baris A'),(4,'R-B02','Lantai 2 – Baris B'),(5,'R-C01','Lantai 3 – Baris A');
/*!40000 ALTER TABLE `rak_buku` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservasi`
--

DROP TABLE IF EXISTS `reservasi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservasi` (
  `id_reservasi` int NOT NULL AUTO_INCREMENT,
  `id_anggota` int NOT NULL,
  `id_buku` int NOT NULL,
  `tanggal_reservasi` date NOT NULL,
  `status_reservasi` enum('Aktif','Selesai','Batal') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Aktif',
  PRIMARY KEY (`id_reservasi`),
  KEY `fk_res_ang` (`id_anggota`),
  KEY `fk_res_buku` (`id_buku`),
  CONSTRAINT `fk_res_ang` FOREIGN KEY (`id_anggota`) REFERENCES `anggota` (`id_anggota`),
  CONSTRAINT `fk_res_buku` FOREIGN KEY (`id_buku`) REFERENCES `buku` (`id_buku`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservasi`
--

LOCK TABLES `reservasi` WRITE;
/*!40000 ALTER TABLE `reservasi` DISABLE KEYS */;
INSERT INTO `reservasi` VALUES (1,4,5,'2025-11-02','Selesai'),(2,7,14,'2025-11-25','Selesai'),(3,11,1,'2026-01-06','Aktif'),(4,12,3,'2026-02-11','Aktif'),(5,14,5,'2026-03-10','Batal'),(6,15,2,'2026-04-01','Aktif'),(7,1,17,'2026-06-02','Aktif'),(8,4,5,'2025-11-02','Selesai'),(9,7,14,'2025-11-25','Selesai'),(10,11,1,'2026-01-06','Aktif'),(11,12,3,'2026-02-11','Aktif'),(12,14,5,'2026-03-10','Batal'),(13,15,2,'2026-04-01','Aktif'),(14,1,17,'2026-06-02','Aktif');
/*!40000 ALTER TABLE `reservasi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_laporan_denda_anggota`
--

DROP TABLE IF EXISTS `v_laporan_denda_anggota`;
/*!50001 DROP VIEW IF EXISTS `v_laporan_denda_anggota`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_laporan_denda_anggota` AS SELECT 
 1 AS `id_anggota`,
 1 AS `nama_anggota`,
 1 AS `email`,
 1 AS `jumlah_transaksi_denda`,
 1 AS `total_denda`,
 1 AS `sudah_dibayar`,
 1 AS `sisa_tagihan`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_peminjaman_aktif`
--

DROP TABLE IF EXISTS `v_peminjaman_aktif`;
/*!50001 DROP VIEW IF EXISTS `v_peminjaman_aktif`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_peminjaman_aktif` AS SELECT 
 1 AS `id_peminjaman`,
 1 AS `nama_anggota`,
 1 AS `no_telp`,
 1 AS `judul_buku`,
 1 AS `nama_petugas`,
 1 AS `tanggal_pinjam`,
 1 AS `tanggal_jatuh_tempo`,
 1 AS `hari_terlambat`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `v_laporan_denda_anggota`
--

/*!50001 DROP VIEW IF EXISTS `v_laporan_denda_anggota`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_laporan_denda_anggota` AS select `a`.`id_anggota` AS `id_anggota`,`a`.`nama_anggota` AS `nama_anggota`,`a`.`email` AS `email`,count(`d`.`id_denda`) AS `jumlah_transaksi_denda`,sum(`d`.`jumlah_denda`) AS `total_denda`,sum((case when (`d`.`status_bayar` = 'Lunas') then `d`.`jumlah_denda` else 0 end)) AS `sudah_dibayar`,sum((case when (`d`.`status_bayar` = 'Belum Lunas') then `d`.`jumlah_denda` else 0 end)) AS `sisa_tagihan` from (((`denda` `d` join `pengembalian` `pg` on((`d`.`id_pengembalian` = `pg`.`id_pengembalian`))) join `peminjaman` `pm` on((`pg`.`id_peminjaman` = `pm`.`id_peminjaman`))) join `anggota` `a` on((`pm`.`id_anggota` = `a`.`id_anggota`))) group by `a`.`id_anggota`,`a`.`nama_anggota`,`a`.`email` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_peminjaman_aktif`
--

/*!50001 DROP VIEW IF EXISTS `v_peminjaman_aktif`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_peminjaman_aktif` AS select `pm`.`id_peminjaman` AS `id_peminjaman`,`a`.`nama_anggota` AS `nama_anggota`,`a`.`no_telp` AS `no_telp`,`b`.`judul_buku` AS `judul_buku`,`pt`.`nama_petugas` AS `nama_petugas`,`pm`.`tanggal_pinjam` AS `tanggal_pinjam`,`pm`.`tanggal_jatuh_tempo` AS `tanggal_jatuh_tempo`,(to_days(curdate()) - to_days(`pm`.`tanggal_jatuh_tempo`)) AS `hari_terlambat` from ((((`peminjaman` `pm` join `anggota` `a` on((`pm`.`id_anggota` = `a`.`id_anggota`))) join `petugas` `pt` on((`pm`.`id_petugas` = `pt`.`id_petugas`))) join `detail_peminjaman` `dp` on((`pm`.`id_peminjaman` = `dp`.`id_peminjaman`))) join `buku` `b` on((`dp`.`id_buku` = `b`.`id_buku`))) where (`pm`.`status_pinjam` = 'Dipinjam') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-17 10:37:27
