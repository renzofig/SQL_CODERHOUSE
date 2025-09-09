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
DELIMITER ;
