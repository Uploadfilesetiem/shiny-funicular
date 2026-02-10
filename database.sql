-- Database untuk Sistem Pendaftaran Siswa
-- Buat Database
CREATE DATABASE IF NOT EXISTS nama_siswa;
USE nama_siswa;

-- Tabel Siswa
CREATE TABLE IF NOT EXISTS siswa (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nama VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE,
  no_hp VARCHAR(15),
  alamat TEXT,
  tanggal_lahir DATE,
  jenis_kelamin ENUM('Laki-laki', 'Perempuan'),
  asal_sekolah VARCHAR(100),
  tanggal_daftar TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status ENUM('aktif', 'nonaktif', 'lulus') DEFAULT 'aktif'
);

-- Tabel Kelas
CREATE TABLE IF NOT EXISTS kelas (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nama_kelas VARCHAR(50) NOT NULL UNIQUE,
  tingkat INT,
  jurusan VARCHAR(100)
);

-- Tabel Nilai (untuk menyimpan nilai siswa)
CREATE TABLE IF NOT EXISTS nilai (
  id INT PRIMARY KEY AUTO_INCREMENT,
  siswa_id INT NOT NULL,
  mata_pelajaran VARCHAR(100),
  nilai_tugas INT,
  nilai_uts INT,
  nilai_uas INT,
  nilai_akhir DECIMAL(5,2),
  semester INT,
  tahun_ajaran VARCHAR(9),
  FOREIGN KEY (siswa_id) REFERENCES siswa(id) ON DELETE RESTRICT
);

-- Tabel Orang Tua
CREATE TABLE IF NOT EXISTS orang_tua (
  id INT PRIMARY KEY AUTO_INCREMENT,
  siswa_id INT NOT NULL,
  nama_ayah VARCHAR(100),
  nama_ibu VARCHAR(100),
  no_hp_ayah VARCHAR(15),
  no_hp_ibu VARCHAR(15),
  pekerjaan_ayah VARCHAR(100),
  pekerjaan_ibu VARCHAR(100),
  alamat TEXT,
  FOREIGN KEY (siswa_id) REFERENCES siswa(id) ON DELETE RESTRICT
);

-- Tabel User Admin/Guru
CREATE TABLE IF NOT EXISTS user (
  id INT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(50) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  email VARCHAR(100),
  nama_lengkap VARCHAR(100),
  role ENUM('admin', 'guru', 'operator') DEFAULT 'operator',
  tanggal_buat TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert data contoh
INSERT INTO siswa (nama, email, no_hp, alamat, jenis_kelamin, asal_sekolah) VALUES
('Ahmad Rizki', 'ahmad@email.com', '081234567890', 'Jl. Merdeka No. 10', 'Laki-laki', 'SMP Negeri 1'),
('Siti Nurhaliza', 'siti@email.com', '082345678901', 'Jl. Diponegoro No. 20', 'Perempuan', 'SMP Negeri 2');

INSERT INTO kelas (nama_kelas, tingkat, jurusan) VALUES
('X-A', 10, 'IPA'),
('X-B', 10, 'IPS'),
('XI-A', 11, 'IPA');

INSERT INTO user (username, password, email, nama_lengkap, role) VALUES
('admin', MD5('admin123'), 'admin@email.com', 'Administrator', 'admin'),
('operator', MD5('operator123'), 'operator@email.com', 'Operator Sekolah', 'operator');
