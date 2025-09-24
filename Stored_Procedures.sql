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
    'juan.perez@example.com', 
    'Buenos Aires', 
    'Buenos Aires', 
    '1001', 
    'Responsabilidad Civil', 
    'Ford', 
    'Focus', 
    'Sedan'
);

CALL sp_actualizar_email_cliente(
    1, 
    'nuevo.email@example.com'
);
