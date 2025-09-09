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
