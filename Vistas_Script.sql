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
