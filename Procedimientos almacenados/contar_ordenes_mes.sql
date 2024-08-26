-- Ejemplo de procedimiento almacenado con parametros de entrada y salida

delimiter //
create procedure contar_ordenes_mes(in year int, in mes int, out conteo_mes int)
begin
select count(*) into conteo_mes 
    from ordenServicio
	where year(fechaOrdenServicio) = year 
	    and month(fechaOrdenServicio) = mes;
end //
delimiter ;