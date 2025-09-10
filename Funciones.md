<h1 align="center">ENTREGA 2</h1>

                      

Funciones
  
  ```
Función: fn_obtener_nombre_completo

Descripción: Una función que toma el ID de un cliente y devuelve su nombre completo (Nombre + Apellido) como una sola cadena de texto.

Objetivo: Proporcionar un método reutilizable para obtener el nombre completo de un cliente, evitando tener que concatenar las columnas Nombre y Apellido en cada consulta.

Datos que manipula: La función lee los datos de la tabla clientes. No realiza modificaciones.
```

```
Función: fn_obtener_tipo_cobertura

Descripción: Devuelve el tipo de cobertura de un cliente en particular, utilizando el ID de ese cliente como entrada.

Objetivo: El objetivo principal de esta función es simplificar y reutilizar el código. Para no tener que escribir una consulta "JOIN" cada vez que se quiere saber el tipo de cobertura de un cliente, se puede utilizar esta función con el ID del cliente.

Datos que manipula: La función lee los datos de la tabla cobertura. No realiza modificaciones.
```
