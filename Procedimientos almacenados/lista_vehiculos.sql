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
end //
delimiter ;