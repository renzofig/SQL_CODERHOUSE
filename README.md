<h1 align="center">ENTREGA 1</h1>

                      

Introducción:
  
  ```ella
"La presente entrega es un avance del proyecto final, el cual, girara en torno a una empresa de seguros donde la información debe ser manejada cuidadosamente para la futura toma de decisiones estrategicas en torno al mercado."
```

Objetivos:

 ```ella
"El objetivo principal es mantener actualizada la base da datos, ofrecer información relevante y oportuna para la adecuada toma de decisiones, evaluando las desviaciones y riesgos que puedan surgir de la operatoria diaria pudiendo accedar a dicha información de manera agil."
```

Situación Problemática:

```ella
"Se utilizan actualmente como base de datos, distintos archivos de excel que dificultan el acceso a la información y surgen ciertos errores al no tener un cruce correcto. Este sistema de gestión enfrentará esta problematica uniendo la información."
 ```

Modelo de Negocios:

```ella
"Nuestra aseguradora se dedica a ofrecer productos financieros que cubren riesgos a cambio del pago de una prima por parte del cliente, brindamos protección económica ante eventos imprevistos como accidentes.
Las fuentes de ingresos son las Primas e inversiones hechas con los fondos obtenidos.
Los costos son variables dado que el monto de indemnizaciones y siniestros son impredecibles.
```

Diagrama E_R

```ella
"Se presenta en formato .JPG"
``` 

Listado de tablas

```ella
La base de datos EMPRESA RF esta compuesta por:

Tabla "Clientes":
Clave Primaria: Id (Identificador único de cada cliente)
Claves Foraneas: localidad_id, cobertura_id, patente_id

Tabla "localidad":
Clave Primaria: Id (Identificador único de cada localidad)
Sin claves Foraneas

Tabla "Cobertura"
Clave Primaria: Id (Identificador único de cada cobertura)
Sin claves Foraneas

Tabla "Tipo_Vehiculo"
Clave Primaria: Id (Identificador único de cada Tipo de Vehiculo)
Sin calves Foraneas

Tabla "Marca_Vehiculo"
Clave Primaria: Id (Identificador único de cada Marca de Vehiculo)
Sin calves Foraneas

Tabla "Modelo_vehiculo"
Clave Primaria: Id (Identificador único de cada Modelo de Vehiculo)
Sin calves Foraneas

Tabla "Patente"
Clave Primaria: Id (Identificador único de cada Patente)
Claves Foraneas: tipo_vehiculo_id, marca_vehiculo_id, modelo_vehiculo_id
```
