-- database/schema.sql

-- Crear la base de datos si no existe
CREATE DATABASE IF NOT EXISTS somoscredito_db;

-- Usar la base de datos
USE somoscredito_db;

-- Crear la tabla de sucursales
CREATE TABLE IF NOT EXISTS sucursales (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ubicacion VARCHAR(255) NOT NULL,
    telefono VARCHAR(50) NOT NULL,
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insertar algunos datos de ejemplo
INSERT INTO sucursales (ubicacion, telefono) VALUES
('Ciudad de Guatemala, Zona 1', '2234-5678'),
('Quetzaltenango, Zona 3', '7765-4321'),
('Antigua Guatemala, Centro', '7832-1098'),
('Tikal, Peten', '1234-5678');