# agencia_servicios
<p align="justify"> Una base de datos para almacenar las ordenes de servicios automotrices, clientes, vehículos, empleados y servicios, tambíen se crea un catalogo de precios para manejar el cambio de precios.  Un diseño simple para mostrar ejemplos como utilizar DDL (Data Definition Language) para crear tablas Y DML (Data Manipulation Language) para recuperar datos almacenados. Todo el código DDL y DML fue escrito, ningún código fue generado por el administrador de la base de datos, para este ejemplo se utilizó MySQL 8.4.2.</p>

- Create tables.sql contiene la definición de las tablas.
- Datos.sql contiene los datos.
- Consultas.sql contiene diferentes consultas para generar información
- alter table.sql contiene ejemplos como utilizar alter para agregar o quitar restricciones en las columnas de tablas.

Para ejecutar los procedimientos almacenados

1. Ejecutar procedimiento almacenado sin parametros (lista_vehiculos.sql)
call lista_vehiculos();

2. Ejecuta procedimiento almacenado con parametro de entrada No. de orden (completar_orden.sql)
call completar_orden(1);

3. Ejecutar procedimiento almacenado con dos parametros de entrada y uno de salida (contar_ordenes_mes.sql)
call contar_ordenes_mes(2024, 3, @conteo_mes);

Cuando se ejecuta el procedimiento almacenado dentro de otro, se puede utilizar la variable que contiene el resultado de la siguiente manera
select @conteo_mes;

4. Ejecutar procedimiento almacenado que crea un pivot dinamico sobre ingresos mensuales (ingresos_mensuales.sql)
call ingresos_mensuales(2024);

5. Ejecuta un procedimiento almacenado que implementa cursor (Ejemplo_cursor.sql)
CALL mayor_cien(2024);

## Crear copias de seguridad
```
mysqldump -u root -p --databases --routines agencia_servicios > backup_agencia_servicios.sql
```
## Restaurar copia de seguridad
```
mysql -u root -p < backup_agencia_servicios.sql 
```

