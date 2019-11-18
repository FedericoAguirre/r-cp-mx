# r-cp-mx
Conjunto de datos normalizados en R de los códigos postales mexicanos.

![Correos mexicanos](./img/cm.png)


## Propósito.

Este proyecto tiene el propósito de generar un conjunto de datos normalizado,
en archivos csv, que tenga catálogos que se puedan utilizar en el análisis de datos.

Correos mexicanos permite descargar los códigos postales del país a través
del siguiente link: [Códigos postales](https://www.correosdemexico.gob.mx/SSLServicios/ConsultaCP/CodigoPostal_Exportar.aspx).


## Conjunto de Datos

El conjunto de datos que se deriva de la descarga es el siguiente:

  - [Estado](./cp-db/estado.csv)
  - [Municipio](./cp-db/municipio.csv)
  - [Ciudad](./cp-db/ciudad.csv)
  - [Zona](./cp-db/zona.csv)
  - [Tipos de asentamiento](./cp-db/tipo_asentamiento.csv)
  - [Asentamiento (y CPs)](./cp-db/asentamiento.csv)

![Asentamientos MX ER](./img/asentamientos-mx-er.png)
