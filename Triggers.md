<h1 align="center">ENTREGA 2</h1>

                      

Triggers
  
  ```
Cambios de registrador en los datos del cliente:

Su propósito es crear un registro de auditoría cada vez que se modifica la información de un cliente, como su nombre, apellido o correo electrónico. 
```



 ```
Evitar la eliminación de clientes con cobertura "Todo Riesgo":

Es un trigger BEFORE DELETE en la tabla clientes. 
Su función es evitar la eliminación accidental de cualquier cliente que tenga una póliza de seguro de tipo Todo Riesgo. 
Esto es una forma de protección de la integridad de los datos.
```
