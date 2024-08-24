/* Procedimiento almacenado que contiene una consulta sin parametros
	Contiene una consulta que muestra listado de vehículos y sus datos */
delimiter //
create procedure lista_vehiculos ()
begin
	select placa, concat(nombres, ' ', apellidos)as propietario, marca, modelo, motor, tipoCarroceria, year
    from vehiculo v
    inner join modelo mo on v.idModelo = mo.idModelo
    inner join marca m on mo.idMarca = m.idMarca
    inner join motor mot on v.idMotor = mot.idMotor
    inner join tipoCarroceria tc on v.idTipoCarroceria = tc.idTipoCarroceria
    inner join cliente c on v.idCliente = c.idCliente;
end
//
delimiter ;
-- Ejecuta procedimiento almacenado sin parametros
call lista_vehiculos();

/* Procedimiento almacenado que ejecuta una sentencia update
	para cambiar el estado de la orden de servicio a completada
    Se declara un parametro de entrada (in) de tipo de dato int
    para indicar el No. de orden que cambiará de estado.
    Al estado completado le corresponde el idEstadoOrden = 2 */
delimiter //
create procedure completar_orden (in no_orden int)
begin
update ordenServicio
set idEstadoOrden = 2
where idOrdenServicio = no_orden;
end
//
delimiter ;
-- Ejecuta procedimiento almacenado con parametro de entrada No. de orden
call completar_orden(1);

/* Procedimiento almacenado con parametros de entrada y salida
	*/
delimiter //
create procedure contar_ordenes_mes(in year int, in mes int, out conteo_mes int)
begin
select count(*) into conteo_mes from ordenServicio
	where year(fechaOrdenServicio) = year 
	and month(fechaOrdenServicio) = mes;
end
//
delimiter ;
-- Se ejecuta procedimiento almacenado con dos parametros de entrada y uno de salida
call contar_ordenes_mes(2024, 3, @conteo_mes);
-- Cuando se ejecuta el sp dentro de otro sp, se puede utilizar la variable que contiene el resultado
select @conteo_mes;

