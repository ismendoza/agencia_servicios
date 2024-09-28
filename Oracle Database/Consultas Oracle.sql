/* CONSULTA PARA MOSTRAR CATALOGO DE PRECIOS ACTUALES DE SERVICIOS
	SEGUN EL VEHÍCULO SELECCIONADO PARA CREAR LA ORDEN DE SERVICIO
    */
WITH precios_actuales AS (
    SELECT s.idServicio, s.servicio, m.idModelo, modelo, motor, ps.precio, ps.fechaInicioVigencia,
        ROW_NUMBER() OVER (PARTITION BY ps.idServicio ORDER BY ps.fechaInicioVigencia DESC ) AS rn
    FROM servicio s
    INNER JOIN precioServicio ps ON ps.idServicio = s.idServicio
    INNER JOIN modelo m ON ps.idModelo = m.idModelo
    INNER JOIN motor mot on ps.idMotor = mot.idMotor
    INNER JOIN vehiculo v on v.idModelo = m.idModelo  AND v.idMotor = mot.idMotor
    WHERE ps.fechaInicioVigencia <= SYSDATE
		AND v.placa = 'P-963JKL'
	) 
SELECT idServicio, servicio, modelo, motor, precio, fechaInicioVigencia FROM precios_actuales
WHERE rn = 1;


/* CONSULTA PARA MOSTRAR UNA ORDEN DE SERVICIO Y SU DETALLE 
	SEGUN FECHA DE ORDEN O NÚMERO DE ORDEN 
    */
WITH precios_actuales AS (
SELECT os.idOrdenServicio, os.fechaOrdenServicio, s.idServicio, servicio, v.placa, modelo, marca, motor, nombres||' '||apellidos as tecnico, ps.precio, dos.cantidad,
	ROW_NUMBER() over (PARTITION BY s.idServicio ORDER BY ps.fechaInicioVigencia DESC) as rn
from servicio s
INNER JOIN precioServicio ps ON ps.idServicio = s.idServicio
INNER JOIN detalleOrden dos ON s.idServicio = dos.idServicio
INNER JOIN ordenServicio os ON dos.idOrdenServicio = os.idOrdenServicio
INNER JOIN modelo mo on ps.idModelo = mo.idModelo
INNER JOIN motor mot on ps.idMotor = mot.idMotor
INNER JOIN marca ma on mo.idMarca = ma.idMarca
INNER JOIN vehiculo v on os.placa = v.placa AND v.idModelo = mo.idModelo AND v.idMotor = mot.idMotor
INNER JOIN empleado em on os.idEmpleado = em.idEmpleado
WHERE ps.fechaInicioVigencia <=  os.fechaOrdenServicio
-- 	AND os.fechaOrdenServicio = '2024-02-08'
 AND os.idOrdenServicio = 1
)
SELECT idOrdenServicio, fechaORdenServicio, idServicio, servicio, placa, modelo, marca, motor, tecnico as "Técnico responsable", precio, cantidad from precios_actuales
WHERE rn = 1;


/* 	CONSULTAR POR NO. DE ORDEN Y MOSTRAR INFORMACIÓN DE LA ORDEN Y SU TOTAL (SIN DETALLE)*/
WITH precios_actuales AS (
SELECT os.idOrdenServicio, c.nombres||' '||c.apellidos as cliente, v.placa, marca||' '||modelo as vehiculo, motor, em.nombres||' '||em.apellidos as tecnico,  os.fechaOrdenServicio, ps.precio, cantidad,
	ROW_NUMBER() over (PARTITION BY s.idServicio, os.idOrdenServicio ORDER BY ps.fechaInicioVigencia DESC) as rn
from servicio s
INNER JOIN precioServicio ps ON ps.idServicio = s.idServicio
INNER JOIN detalleOrden dos ON s.idServicio = dos.idServicio
INNER JOIN ordenServicio os ON dos.idOrdenServicio = os.idOrdenServicio
INNER JOIN modelo mo on ps.idModelo = mo.idModelo
INNER JOIN motor mot on ps.idMotor = mot.idMotor
INNER JOIN marca ma on mo.idMarca = ma.idMarca
INNER JOIN vehiculo v on os.placa = v.placa AND v.idModelo = mo.idModelo AND v.idMotor = mot.idMotor
INNER JOIN cliente c on v.idCliente = c.idCliente
INNER JOIN empleado em on os.idEmpleado = em.idEmpleado
WHERE ps.fechaInicioVigencia <=  os.fechaOrdenServicio
	AND os.idOrdenServicio = 9
)
SELECT idOrdenServicio as "No. Orden", fechaOrdenServicio, cliente, vehiculo, motor, tecnico as "Técnico responsable", sum(precio * cantidad) as total from precios_actuales
WHERE rn = 1
    group by idOrdenServicio, fechaOrdenServicio, cliente, vehiculo, motor, tecnico;


/* 	CONSULTA QUE MUESTRA EL TOTAL DE INGRESO DE UN MES ESPECIFICO */
WITH precios_actuales AS (
    SELECT os.fechaOrdenServicio, ps.precio, cantidad,
        ROW_NUMBER() OVER (PARTITION BY s.idServicio, os.idOrdenServicio ORDER BY ps.fechaInicioVigencia DESC) AS rn
    FROM servicio s
    INNER JOIN precioServicio ps ON ps.idServicio = s.idServicio
    INNER JOIN detalleOrden dos ON s.idServicio = dos.idServicio
    INNER JOIN ordenServicio os ON dos.idOrdenServicio = os.idOrdenServicio
    INNER JOIN modelo mo ON ps.idModelo = mo.idModelo
    INNER JOIN motor mot ON ps.idMotor = mot.idMotor
    INNER JOIN vehiculo v ON os.placa = v.placa AND v.idModelo = mo.idModelo AND v.idMotor = mot.idMotor
    WHERE ps.fechaInicioVigencia <= os.fechaOrdenServicio
)
SELECT EXTRACT(MONTH FROM fechaOrdenServicio) AS mes, SUM(precio * cantidad) as total 
FROM precios_actuales
WHERE rn = 1 
  AND EXTRACT(MONTH FROM fechaOrdenServicio) = 4
  AND EXTRACT(YEAR FROM fechaOrdenServicio) = 2024
GROUP BY EXTRACT(MONTH FROM fechaOrdenServicio);


/* CONSULTA PARA MOSTRAR EL MES Y EL TOTAL DE INGRESO POR MES */
WITH precios_actuales AS (
SELECT os.fechaOrdenServicio, ps.precio, cantidad,
	ROW_NUMBER() over (PARTITION BY s.idServicio, os.idOrdenServicio ORDER BY ps.fechaInicioVigencia DESC) as rn
from servicio s
INNER JOIN precioServicio ps ON ps.idServicio = s.idServicio
INNER JOIN detalleOrden dos ON s.idServicio = dos.idServicio
INNER JOIN ordenServicio os ON dos.idOrdenServicio = os.idOrdenServicio
INNER JOIN modelo mo on ps.idModelo = mo.idModelo
INNER JOIN motor mot on ps.idMotor = mot.idMotor
INNER JOIN vehiculo v on os.placa = v.placa AND v.idModelo = mo.idModelo AND v.idMotor = mot.idMotor
WHERE ps.fechaInicioVigencia <=  os.fechaOrdenServicio
	)
SELECT EXTRACT(MONTH FROM fechaOrdenServicio), sum(precio * cantidad)AS "TOTAL MES" from precios_actuales
WHERE rn = 1 
AND EXTRACT(YEAR FROM fechaOrdenServicio) = 2024
group by EXTRACT(MONTH FROM fechaOrdenServicio);


/* Historial de un vehículo especifico mostrarno ordenes y servicios*/
WITH precios_actuales AS (
    SELECT os.idOrdenServicio, os.fechaOrdenServicio, s.idServicio, s.servicio, v.placa, m.idModelo, modelo, marca, em.nombres||' '||em.apellidos as tecnico, ps.precio,
        ROW_NUMBER() OVER (PARTITION BY ps.idServicio, os.idOrdenServicio ORDER BY ps.fechaInicioVigencia DESC ) AS rn
    FROM servicio s
    INNER JOIN precioServicio ps ON ps.idServicio = s.idServicio
    INNER JOIN detalleOrden dos on dos.idServicio = s.idServicio
    INNER JOIN ordenServicio os on dos.idOrdenServicio = os.idOrdenServicio
    INNER JOIN vehiculo v on os.placa = v.placa
    INNER JOIN modelo m ON ps.idModelo = m.idModelo AND v.idModelo = m.idModelo
    INNER JOIN motor mot on ps.idMotor = mot.idMotor AND v.idMotor = mot.idMotor
    INNER JOIN marca ma on m.idMarca = ma.idMarca
    INNER JOIN cliente c on v.idCliente = c.idCliente
    INNER JOIN empleado em on os.idEmpleado = em.idEmpleado
    WHERE ps.fechaInicioVigencia <= os.fechaOrdenServicio
    AND v.placa = 'P-852GDC'
	) 
SELECT idOrdenServicio, fechaOrdenServicio, idServicio, servicio, placa, modelo, marca, tecnico as "Técnico responsable", precio FROM precios_actuales
WHERE rn = 1;

/* Mostrar todas las ordenes de servicio de un mes específico */
WITH precios_actuales AS (
SELECT os.idOrdenServicio, c.nombres||' '||c.apellidos as cliente, v.placa, os.fechaOrdenServicio, em.nombres||' '||em.apellidos as tecnico, ps.precio, cantidad,
	ROW_NUMBER() OVER (PARTITION BY s.idServicio, os.idOrdenServicio ORDER BY ps.fechaInicioVigencia DESC) AS rn
FROM servicio s
INNER JOIN precioServicio ps ON ps.idServicio = s.idServicio
INNER JOIN detalleOrden dos ON s.idServicio = dos.idServicio
INNER JOIN ordenServicio os ON dos.idOrdenServicio = os.idOrdenServicio
INNER JOIN modelo mo ON ps.idModelo = mo.idModelo
INNER JOIN motor mot ON ps.idMotor = mot.idMotor
INNER JOIN marca ma ON mo.idMarca = ma.idMarca
INNER JOIN vehiculo v ON os.placa = v.placa AND v.idModelo = mo.idModelo AND v.idMotor = mot.idMotor
INNER JOIN cliente c ON v.idCliente = c.idCliente
INNER JOIN empleado em on os.idEmpleado = em.idEmpleado
WHERE ps.fechaInicioVigencia <=  os.fechaOrdenServicio
)
SELECT idOrdenServicio AS "No. Orden", fechaOrdenServicio, cliente, placa, tecnico as "Técnico responsable", SUM(precio * cantidad) as total FROM precios_actuales
WHERE rn = 1
	AND EXTRACT(MONTH FROM fechaOrdenServicio) = 4
GROUP BY idOrdenServicio, fechaOrdenServicio, cliente, placa, tecnico ORDER BY fechaOrdenServicio;