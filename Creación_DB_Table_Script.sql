-- Creación DB

CREATE DATABASE IF NOT EXISTS empresa_rf; 

-- Uso DB

USE empresa_rf;

-- Creación de la tabla 'localidad'

CREATE TABLE IF NOT EXISTS localidad (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Ciudad VARCHAR(255) NOT NULL,
    Provincia VARCHAR (255) NOT NULL,
    CP VARCHAR (255) NOT NULL);

-- Creación de la tabla 'Cobertura'

CREATE TABLE IF NOT EXISTS cobertura (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Tipo VARCHAR(255));

-- Creación de la tabla 'Patente'    
CREATE TABLE IF NOT EXISTS Patente (
 Id INT AUTO_INCREMENT PRIMARY KEY,
 Modelo VARCHAR (25),
 Marca VARCHAR (25),
 Tipo VARCHAR (25) );
 

-- Creación de la tabla 'Clientes'

CREATE TABLE IF NOT EXISTS clientes (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255),
    Apellido VARCHAR(255),
    Email VARCHAR(255),
    localidad_id INT, 
    cobertura_id INT, 
    patente_id INT,   
    FOREIGN KEY (localidad_id) REFERENCES localidad(Id), 
    FOREIGN KEY (cobertura_id) REFERENCES cobertura(Id),
    FOREIGN KEY (patente_id) REFERENCES patente(Id) );
