<h1 align="center">ENTREGA FINAL</h1>

                      

Vistas
  
  ```
Vista: vw_clientes_detalle

Descripción: Esta vista combina los datos de las tablas clientes, localidad, cobertura y patente para tener una visión completa y detallada de cada cliente en una sola consulta.

Objetivo: Simplificar las consultas. En lugar de tener que unir múltiples tablas cada vez que se necesita información detallada de los clientes, se puede consultar directamente esta vista. Esto mejora la legibilidad del código SQL y reduce la probabilidad de errores.

Tablas que la componen: clientes, localidad, cobertura, patente.
```



 ```
Vista: vw_resumen_cobertura

Descripción: Esta vista muestra un resumen de la cantidad de clientes por tipo de cobertura.

Objetivo: Obtener métricas clave para el análisis, como la distribución de los clientes por tipo de servicio contratado.

Tablas que la componen: clientes, cobertura.
```


```
Vista: vw_clientes_por_provincia

Descripción: Esta vista muestra un resume de la cantidad total de clientes que hay en cada provincia, sin duplicados.

Objetivo: Proporcionar un resumen rápido y estadístico de la distribución geográfica de los clientes. Es útil para identificar en qué provincia hay mayor o menor presencia.

Tablas que la componen: clientes, localidad.
```


```
Vista: vw_vehiculos_por_marca

Descripción: Esta vista muestra un resumen del número de clientes para cada marca de vehículo.

Objetivo: El objetivo es analizar la popularidad de las diferentes marcas de autos entre tus clientes. Esto puede ser valioso para estudios de mercado o para enfocar campañas de marketing en marcas específicas.

Tablas que la componen: clientes, patente.
```


```
Vista: vw_clientes_todo_riesgo

Descripción: Esta vista filtra y muestra un listado detallado de todos los clientes que tienen contratada la cobertura de tipo 'Todo Riesgo'.

Objetivo: Su propósito es crear una lista específica de clientes que tienen el nivel de cobertura más alto. Esto puede ser útil para la gestión de cuentas, la atención al cliente o para ofrecerles servicios exclusivos.

Tablas que la componen: clientes, cobertura, localidad, patente.
```
