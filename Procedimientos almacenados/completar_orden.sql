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
    end //
delimiter ;