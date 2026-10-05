# Praktikum Basis Data

-- Praktikum Basis Data
-- Nama: Shifa Rahmanisa
-- NIM: 25430112
-- Kelas: D

SELECT VERSION();

SELECT USER();

SHOW DATABASES;

CREATE DATABASE IF NOT EXISTS kopma_112
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

CREATE USER IF NOT EXISTS 'Shifa_112'@'localhost'
IDENTIFIED BY '<PASSWORD>';

GRANT ALL PRIVILEGES ON kopma_112.* 
TO 'Shifa_112'@'localhost';

USE kopma_112;

SHOW TABLES;

SELECT @@sql_mode;
CREATE USER IF NOT EXISTS 'tamu_112'@'localhost'
IDENTIFIED BY '<PASSWORD>';

GRANT SELECT ON kopma_112.* 
TO 'tamu_112'@'localhost';
