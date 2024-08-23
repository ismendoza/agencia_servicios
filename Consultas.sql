/* CONSULTA PARA MOSTRAR CATALOGO DE PRECIOS ACTUALES DE SERVICIOS
	SEGUN EL VEHÍCULO SELECCIONADO PARA CREAR LA ORDEN DE SERVICIO
    */
WITH precios_actuales AS (
    SELECT s.idServicio, s.servicio, m.idModelo, modelo, motor, ps.precio, ps.fechaInicioVigencia,
        ROW_NUMBER() OVER (PARTITION BY ps.idServicio ORDER BY ps.fechaInicioVigencia DESC ) AS rn
    FROM servicio s
    INNER JOIN precioServicio ps ON ps.idServicio = s.idServicio
    INNER JOIN modelo m ON ps.idModelo = m.idModelo
    inner join motor mot on ps.idMotor = mot.idMotor
    inner join vehiculo v on v.idModelo = m.idModelo  and v.idMotor = mot.idMotor
    WHERE ps.fechaInicioVigencia <= NOW()
		and v.placa = 'P-963JKL'
	) 
SELECT idServicio, servicio, modelo, motor, precio, fechaInicioVigencia FROM precios_actualesr
WHERE rn = 1;

/* CONSULTA PARA MOSTRAR UNA ORDEN DE SERVICIO Y SU DETALLE 
	SEGUN FECHA DE ORDEN O NÚMERO DE ORDEN 
    */
WITH precios_actuales AS (
select os.idOrdenServicio, os.fechaOrdenServicio, s.idServicio, servicio, v.placa, modelo, marca, motor, ps.precio, dos.cantidad,
	ROW_NUMBER() over (PARTITION BY s.idServicio ORDER BY ps.fechaInicioVigencia DESC) as rn
from servicio s
INNER JOIN precioServicio ps ON ps.idServicio = s.idServicio
INNER JOIN detalleOrden dos ON s.idServicio = dos.idServicio
INNER Join ordenServicio os ON dos.idOrdenServicio = os.idOrdenServicio
inner join modelo mo on ps.idModelo = mo.idModelo
inner join motor mot on ps.idMotor = mot.idMotor
inner join marca ma on mo.idMarca = ma.idMarca
inner join vehiculo v on os.placa = v.placa and v.idModelo = mo.idModelo and v.idMotor = mot.idMotor
where ps.fechaInicioVigencia <=  os.fechaOrdenServicio
-- 	and os.fechaOrdenServicio = '2024-02-08'
 and os.idOrdenServicio = 10
)
select idOrdenServicio, fechaORdenServicio, idServicio, servicio, placa, modelo, marca, motor, precio, cantidad from precios_actuales
where rn = 1;

/* 	CONSULTAR POR NO. DE ORDEN Y MOSTRAR INFORMACIÓN DE LA ORDEN Y SU TOTAL (SIN DETALLE)*/
WITH precios_actuales AS (
select os.idOrdenServicio, concat(nombres, ' ', apellidos)as cliente, v.placa, concat(marca, ' ',modelo)as vehiculo, motor, os.fechaOrdenServicio, ps.precio, cantidad,
	ROW_NUMBER() over (PARTITION BY s.idServicio, os.idOrdenServicio ORDER BY ps.fechaInicioVigencia DESC) as rn
from servicio s
INNER JOIN precioServicio ps ON ps.idServicio = s.idServicio
INNER JOIN detalleOrden dos ON s.idServicio = dos.idServicio
INNER Join ordenServicio os ON dos.idOrdenServicio = os.idOrdenServicio
inner join modelo mo on ps.idModelo = mo.idModelo
inner join motor mot on ps.idMotor = mot.idMotor
inner join marca ma on mo.idMarca = ma.idMarca
inner join vehiculo v on os.placa = v.placa and v.idModelo = mo.idModelo and v.idMotor = mot.idMotor
inner join cliente c on v.idCliente = c.idCliente
where ps.fechaInicioVigencia <=  os.fechaOrdenServicio
	and os.idOrdenServicio = 11
)
select idOrdenServicio as 'No. Orden', fechaOrdenServicio, cliente, vehiculo, motor, sum(precio * cantidad) as total from precios_actuales
where rn = 1
group by month(fechaOrdenServicio);

/* 	CONSULTA QUE MUESTRA EL TOTAL DE INGRESO DE UN MES ESPECIFICO */
WITH precios_actuales AS (
select os.fechaOrdenServicio, ps.precio, cantidad,
	ROW_NUMBER() over (PARTITION BY s.idServicio, os.idOrdenServicio ORDER BY ps.fechaInicioVigencia DESC) as rn
from servicio s
INNER JOIN precioServicio ps ON ps.idServicio = s.idServicio
INNER JOIN detalleOrden dos ON s.idServicio = dos.idServicio
INNER Join ordenServicio os ON dos.idOrdenServicio = os.idOrdenServicio
inner join modelo mo on ps.idModelo = mo.idModelo
inner join motor mot on ps.idMotor = mot.idMotor
inner join vehiculo v on os.placa = v.placa and v.idModelo = mo.idModelo  and v.idMotor = mot.idMotor
where ps.fechaInicioVigencia <=  os.fechaOrdenServicio
	)
select month(fechaOrdenServicio), sum(precio * cantidad) from precios_actuales
where rn = 1 
  and month(fechaOrdenServicio ) = 2 and year(fechaOrdenServicio) = 2024
group by month(fechaOrdenServicio);

/* CONSULTA PARA MOSTRAR EL MES Y EL TOTAL DE INGRESO POR MES */
WITH precios_actuales AS (
select os.fechaOrdenServicio, ps.precio, cantidad,
	ROW_NUMBER() over (PARTITION BY s.idServicio, os.idOrdenServicio ORDER BY ps.fechaInicioVigencia DESC) as rn
from servicio s
INNER JOIN precioServicio ps ON ps.idServicio = s.idServicio
INNER JOIN detalleOrden dos ON s.idServicio = dos.idServicio
INNER Join ordenServicio os ON dos.idOrdenServicio = os.idOrdenServicio
inner join modelo mo on ps.idModelo = mo.idModelo
inner join motor mot on ps.idMotor = mot.idMotor
inner join vehiculo v on os.placa = v.placa and v.idModelo = mo.idModelo and v.idMotor = mot.idMotor
where ps.fechaInicioVigencia <=  os.fechaOrdenServicio
	)
select month(fechaOrdenServicio), sum(precio * cantidad) from precios_actuales
where rn = 1 
and year(fechaOrdenServicio) = 2024
group by month(fechaOrdenServicio);

/* Historial de un vehículo especifico mostrarno ordenes y servicios*/
WITH precios_actuales AS (
    SELECT os.idOrdenServicio, os.fechaOrdenServicio, s.idServicio, s.servicio, v.placa, m.idModelo, modelo, marca, ps.precio,
        ROW_NUMBER() OVER (PARTITION BY ps.idServicio, os.idOrdenServicio ORDER BY ps.fechaInicioVigencia DESC ) AS rn
    FROM servicio s
    INNER JOIN precioServicio ps ON ps.idServicio = s.idServicio
    inner join detalleOrden dos on dos.idServicio = s.idServicio
    inner join ordenServicio os on dos.idOrdenServicio = os.idOrdenServicio
    inner join vehiculo v on os.placa = v.placa
    INNER JOIN modelo m ON ps.idModelo = m.idModelo and v.idModelo = m.idModelo
    inner join motor mot on ps.idMotor = mot.idMotor and v.idMotor = mot.idMotor
    inner join marca ma on m.idMarca = ma.idMarca
    inner join cliente c on v.idCliente = c.idCliente
    WHERE ps.fechaInicioVigencia <= os.fechaOrdenServicio
    and v.placa = 'P-852GDC'
	) 
SELECT idOrdenServicio, fechaOrdenServicio, idServicio, servicio, placa, modelo, marca, precio FROM precios_actuales
WHERE rn = 1;