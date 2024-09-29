-- Una acción simple dentro de un procedimiento almacenado para construir la estructura básica del cursor
-- Verifica si el total es mayor a 650 (No es necesario un cursor para la tarea requerida)
delimiter //
create procedure mayor_cien (IN year INT)
BEGIN
	-- Declaración de variables
	DECLARE done BOOLEAN DEFAULT FALSE;
	DECLARE v_idOrden INT;
    DECLARE v_total DECIMAL(10,2);
	-- Declara y crea el cursor
    DECLARE cur_ordenes CURSOR FOR
		WITH precios_actuales AS (
			select os.idOrdenServicio, concat(nombres, ' ', apellidos)as cliente, v.placa, os.fechaOrdenServicio, ps.precio, cantidad,
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
			)
			select idOrdenServicio, sum(precio * cantidad) as total from precios_actuales
			where rn = 1
				and year(fechaOrdenServicio) = year
			group by idOrdenServicio order by fechaOrdenServicio;
	
    /* Se declara una acción de controlador (CONTINUE) 
		para cuando una valor de condición es NOT FOUND 
        y si ocurre la condición se ejecuta la sentencia SET automaticamente durante el recorrido del cursor */
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    -- Crea una tabla temporal
    CREATE TEMPORARY TABLE tmp_resultado (
		rs varchar(200)
    );
    -- Abre el cursor
    OPEN cur_ordenes;
    -- Declaración de bucle
    read_loop: LOOP
		-- Recupera las filas del cursor y las inserta en variables,
        -- las variables son para cada una de las columnas 
		FETCH cur_ordenes INTO v_idOrden, v_total;
        -- Verifica si done es TRUE
        IF done THEN
			-- Sale del bucle
			LEAVE read_loop;
		END IF;
        /* Este es el objetivo del cursor para verificar fila a fila si total es mayor a 650 */
        IF v_total > 650 THEN
			-- Si es cierto se insertar a una tabla temporal una respuesta para cada fila
			INSERT INTO tmp_resultado SELECT CONCAT('La orden ', v_idOrden, ' tiene un total mayor a 100. Total: ', v_total )as rs;
		END IF;
	END LOOP read_loop; -- fin del bucle
    -- Cierra el cursor
    CLOSE cur_ordenes;
    -- Obtiene los resultados de la tabla temporal
    select *from tmp_resultado;
    -- Elimina la tabla temporal
    DROP temporary table tmp_resultado;
END //
delimiter ;
