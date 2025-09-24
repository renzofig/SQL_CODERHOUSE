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


