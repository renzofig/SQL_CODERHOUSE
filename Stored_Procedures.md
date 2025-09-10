<h1 align="center">ENTREGA 2</h1>

                      

Stored Procedure
  
  ```
Stored Procedure: sp_agregar_cliente

Descripción: Un procedimiento almacenado para insertar un nuevo cliente y los datos de su vehículo y localidad de forma controlada.

Objetivo: Aporta un beneficio de integridad y seguridad de los datos. Centraliza la lógica de inserción, asegurando que un nuevo cliente, su localidad, cobertura y vehículo se inserten correctamente y se relacionen adecuadamente en una sola transacción. Esto reduce errores y asegura la consistencia de la base de datos.

Tablas con las que interactúa: clientes, localidad, cobertura, patente
```

```
Stored Procedure: sp_actualizar_email_cliente

Descripción: Este procedimiento almacenado actualiza la dirección de correo electrónico de un cliente existente.

Objetivo: Proporcionar una forma sencilla y segura de modificar el email de un cliente sin afectar otros datos.

Tablas con las que interactúa: Clientes
```

