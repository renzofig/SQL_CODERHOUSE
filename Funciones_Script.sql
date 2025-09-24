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



