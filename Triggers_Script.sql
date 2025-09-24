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

  
DELIMITER ;

-- Uso trigger "Clientes_audit"

-- Se actualiza el correo electrónico del cliente con ID 1

CALL sp_actualizar_email_cliente(1, 'juan.perez_nuevo@example.com');

-- Reviso la tabla de auditoría para ver el registro del cambio

SELECT * FROM clientes_audit WHERE cliente_id = 1;



