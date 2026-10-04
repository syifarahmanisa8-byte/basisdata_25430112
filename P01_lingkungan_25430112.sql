# Praktikum Basis Data

Nama: Shifa Rahmanisa
NIM: 25430112
Kelas: D

-- Praktikum Basis Data
-- Nama: Shifa Rahmanisa
-- NIM: 25430112
-- Kelas: D

SELECT VERSION();

SELECT USER();

SHOW DATABASES;

CREATE DATABASE kopma_112
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

CREATE USER 'Shifa_112'@'localhost'
IDENTIFIED BY '<PASSWORD>';

GRANT ALL PRIVILEGES ON kopma_112.* 
TO 'Shifa_112'@'localhost';

USE Shifa_112;

SHOW TABLES;

SELECT @@sql_mode;
