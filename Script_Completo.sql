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

-- Creación de la tabla 'Clientes_audit'

CREATE TABLE IF NOT EXISTS clientes_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    old_nombre VARCHAR(255),
    new_nombre VARCHAR(255),
    old_apellido VARCHAR(255),
    new_apellido VARCHAR(255),
    old_email VARCHAR(255),
    new_email VARCHAR(255),
    cambio_fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Inserción de datos en la tabla 'localidad'

INSERT INTO localidad (Ciudad, Provincia, CP) VALUES
('Concordia', 'Entre Rios', '3200'),
('Rosario', 'Santa Fe', '2000'),
('Charata', 'Chaco', '3730'),
('CABA', 'CABA', '1425'),
('Bella Vista', 'Buenos Aires', '1661');

-- Inserción de datos en la tabla 'cobertura'

INSERT INTO cobertura (Tipo) VALUES
('RC'),
('Tercero Completo'),
('Todo Riesgo');

-- Inserción de datos en la tabla 'patente'

INSERT INTO Patente (Modelo, Marca, Tipo) VALUES
('Clio', 'Renault', 'Sedan'),
('C4', 'Citroën', 'Sedan'),
('Focus', 'Ford', 'Sedan'),
('X-Trail', 'Nissan', 'SUV'),
('Polo', 'Volkswagen', 'Sedan');

-- Inserción de datos en la tabla 'clientes'

INSERT INTO clientes (Nombre, Apellido, Email, localidad_id, cobertura_id, patente_id) VALUES
('Juan', 'Pérez', 'juan.perez@gmail.com', 1, 2, 3),  
('Ana', 'García', 'ana.garcia@ejemplo.com', 2, 3, 1),
('Pedro', 'López', 'pedro.lopez@hotmail.com', 3, 1, 4),
('María', 'Rodríguez', 'maria.rodriguez@yahoo.com', 4, 2, 2),
('Carlos', 'Sánchez', 'carlos.sanchez@outlook.com', 5, 3, 5);

-- vw_clientes_detalle

CREATE OR REPLACE VIEW vw_clientes_detalle AS
SELECT
    c.Id AS cliente_id,
    c.Nombre,
    c.Apellido,
    c.Email,
    l.Ciudad AS Ciudad,
    l.Provincia AS Provincia,
    l.CP AS CodigoPostal,
    co.Tipo AS TipoCobertura,
    p.Marca AS MarcaVehiculo,
    p.Modelo AS ModeloVehiculo,
    p.Tipo AS TipoVehiculo
FROM clientes c
JOIN localidad l ON c.localidad_id = l.Id
JOIN cobertura co ON c.cobertura_id = co.Id
JOIN patente p ON c.patente_id = p.Id;

-- Vista: vw_resumen_cobertura

CREATE OR REPLACE VIEW vw_resumen_cobertura AS
SELECT
    co.Tipo AS TipoCobertura,
    COUNT(c.Id) AS TotalClientes
FROM clientes c
JOIN cobertura co ON c.cobertura_id = co.Id
GROUP BY co.Tipo;


-- Vista: vw_clientes_por_provincia

CREATE OR REPLACE VIEW vw_clientes_por_provincia AS
SELECT
    l.Provincia AS Provincia,
    COUNT(c.Id) AS TotalClientes
FROM clientes c
JOIN localidad l ON c.localidad_id = l.Id
GROUP BY l.Provincia;

-- Vista: vw_vehiculos_por_marca

CREATE OR REPLACE VIEW vw_vehiculos_por_marca AS
SELECT
    p.Marca AS MarcaVehiculo,
    COUNT(c.Id) AS TotalClientes
FROM clientes c
JOIN patente p ON c.patente_id = p.Id
GROUP BY p.Marca;

-- Vista: vw_clientes_todo_riesgo

CREATE OR REPLACE VIEW vw_clientes_todo_riesgo AS
SELECT
    c.Nombre,
    c.Apellido,
    c.Email,
    l.Ciudad,
    l.Provincia,
    p.Marca AS MarcaVehiculo,
    p.Modelo AS ModeloVehiculo
FROM clientes c
JOIN cobertura co ON c.cobertura_id = co.Id
JOIN localidad l ON c.localidad_id = l.Id
JOIN patente p ON c.patente_id = p.Id
WHERE co.Tipo = 'Todo Riesgo';

-- Funciones

DELIMITER //
CREATE FUNCTION fn_obtener_nombre_completo(cliente_id INT)
RETURNS VARCHAR(511)
READS SQL DATA
BEGIN
    DECLARE nombre_completo VARCHAR(511);
    SELECT CONCAT(Nombre, ' ', Apellido) INTO nombre_completo
    FROM clientes
    WHERE Id = cliente_id;
    RETURN nombre_completo;
END //

CREATE FUNCTION fn_obtener_tipo_cobertura(cliente_id INT)
RETURNS VARCHAR(255)
READS SQL DATA
BEGIN
    DECLARE tipo_cobertura VARCHAR(255);
    SELECT co.Tipo INTO tipo_cobertura
    FROM clientes c
    JOIN cobertura co ON c.cobertura_id = co.Id
    WHERE c.Id = cliente_id;
    RETURN tipo_cobertura;
END //
DELIMITER ;


-- Casos de prueba para ambas funciones

SELECT 'Prueba para fn_obtener_nombre_completo' AS Prueba, fn_obtener_nombre_completo(1) AS NombreCompleto;


-- Caso de prueba para fn_obtener_tipo_cobertura

SELECT 'Prueba para fn_obtener_tipo_cobertura' AS Prueba, fn_obtener_tipo_cobertura(2) AS TipoCobertura;



-- Stored Procedures

DELIMITER //
CREATE PROCEDURE sp_agregar_cliente(
    IN p_nombre VARCHAR(255),
    IN p_apellido VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_ciudad VARCHAR(255),
    IN p_provincia VARCHAR(255),
    IN p_cp VARCHAR(255),
    IN p_cobertura_tipo VARCHAR(255),
    IN p_patente_modelo VARCHAR(25),
    IN p_patente_marca VARCHAR(25),
    IN p_patente_tipo VARCHAR(25)
)
BEGIN
    DECLARE localidad_id INT;
    DECLARE cobertura_id INT;
    DECLARE patente_id INT;

    -- Buscar o insertar en localidad
    SELECT Id INTO localidad_id FROM localidad WHERE Ciudad = p_ciudad AND Provincia = p_provincia AND CP = p_cp;
    IF localidad_id IS NULL THEN
        INSERT INTO localidad (Ciudad, Provincia, CP) VALUES (p_ciudad, p_provincia, p_cp);
        SET localidad_id = LAST_INSERT_ID();
    END IF;

    -- Buscar o insertar en cobertura
    SELECT Id INTO cobertura_id FROM cobertura WHERE Tipo = p_cobertura_tipo;
    IF cobertura_id IS NULL THEN
        INSERT INTO cobertura (Tipo) VALUES (p_cobertura_tipo);
        SET cobertura_id = LAST_INSERT_ID();
    END IF;

    -- Buscar o insertar en patente
    SELECT Id INTO patente_id FROM Patente WHERE Modelo = p_patente_modelo AND Marca = p_patente_marca AND Tipo = p_patente_tipo;
    IF patente_id IS NULL THEN
        INSERT INTO Patente (Modelo, Marca, Tipo) VALUES (p_patente_modelo, p_patente_marca, p_patente_tipo);
        SET patente_id = LAST_INSERT_ID();
    END IF;

    -- Insertar el nuevo cliente
    INSERT INTO clientes (Nombre, Apellido, Email, localidad_id, cobertura_id, patente_id)
    VALUES (p_nombre, p_apellido, p_email, localidad_id, cobertura_id, patente_id);
END //

CREATE PROCEDURE sp_actualizar_email_cliente(
    IN p_cliente_id INT,
    IN p_nuevo_email VARCHAR(255)
)
BEGIN
    UPDATE clientes
    SET Email = p_nuevo_email
    WHERE Id = p_cliente_id;
END //

DELIMITER ;

-- Prueba de los SP

CALL sp_agregar_cliente(
    'Juan', 
    'Pérez', 
    'juan.perez@gmail.com', 
    'Buenos Aires', 
    'Buenos Aires', 
    '1001', 
    'Responsabilidad Civil', 
    'Focus', 
    'Ford', 
    'Sedan'
);

CALL sp_actualizar_email_cliente(
    1, 
    'juan.perez1@gmail.com'
);


-- Creación Triggers

DELIMITER //

CREATE TRIGGER tr_after_update_clientes_audit
AFTER UPDATE ON clientes
FOR EACH ROW
BEGIN
    -- Verificar si se ha realizado algún cambio en los datos relevantes
    IF OLD.Nombre <> NEW.Nombre OR OLD.Apellido <> NEW.Apellido OR OLD.Email <> NEW.Email THEN
        INSERT INTO clientes_audit (
            cliente_id,
            old_nombre,
            new_nombre,
            old_apellido,
            new_apellido,
            old_email,
            new_email
        )
        VALUES (
            OLD.Id,
            OLD.Nombre,
            NEW.Nombre,
            OLD.Apellido,
            NEW.Apellido,
            OLD.Email,
            NEW.Email
        );
    END IF;
END //

CREATE TRIGGER tr_before_delete_todo_riesgo
BEFORE DELETE ON clientes
FOR EACH ROW
BEGIN
    DECLARE cobertura_tipo VARCHAR(255);

    -- Obtener el tipo de cobertura del cliente que se va a eliminar
    SELECT Tipo INTO cobertura_tipo
    FROM cobertura
    WHERE Id = OLD.cobertura_id;
    
    -- Prevenir la eliminación si el tipo de cobertura es 'Todo Riesgo'
    IF cobertura_tipo = 'Todo Riesgo' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede eliminar un cliente con cobertura de tipo "Todo Riesgo".';
    END IF;
END //
    
DELIMITER ;

-- Uso trigger "Clientes_audit"

-- Se actualiza el correo electrónico del cliente con ID 1

CALL sp_actualizar_email_cliente(2, 'ana_garcia@gmail.com');

-- Reviso la tabla de auditoría para ver el registro del cambio

SELECT * FROM clientes_audit WHERE cliente_id = 2;

