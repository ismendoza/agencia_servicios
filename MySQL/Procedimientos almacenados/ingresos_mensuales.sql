-- Procedimiento almacenado para crear un pivot dinámico
delimiter //
create procedure ingresos_mensuales (IN year INT)
begin
	-- Crea una tabla temporal
	CREATE TEMPORARY TABLE tmp_ingresos_mes (
		mes VARCHAR(20),
        month_num INT,
		total DECIMAL(12,2)
	);
    -- Inserta en la tabla temporal el resultado de la CTE
	INSERT INTO tmp_ingresos_mes 
    WITH precios_actuales AS (
        select os.fechaOrdenServicio, ps.precio, cantidad,
            ROW_NUMBER() over (PARTITION BY s.idServicio, os.idOrdenServicio ORDER BY ps.fechaInicioVigencia DESC) as rn
        from servicio s
            INNER JOIN precioServicio ps ON ps.idServicio = s.idServicio
            INNER JOIN detalleOrden dos ON s.idServicio = dos.idServicio
            INNER JOIN ordenServicio os ON dos.idOrdenServicio = os.idOrdenServicio
            INNER JOIN modelo mo on ps.idModelo = mo.idModelo
            INNER JOIN motor mot on ps.idMotor = mot.idMotor
            INNER JOIN vehiculo v on os.placa = v.placa and v.idModelo = mo.idModelo and v.idMotor = mot.idMotor
        WHERE ps.fechaInicioVigencia <=  os.fechaOrdenServicio
    )
    select  monthname(fechaOrdenServicio) as mes, month(fechaOrdenServicio) as month_num,  sum(precio * cantidad) as total 
    from precios_actuales
        where rn = 1 
        and year(fechaOrdenServicio) = year
        group by monthname(fechaOrdenServicio), month(fechaOrdenServicio) order by month(fechaOrdenServicio) asc;
    
    /* Crea un pivot dinamico
		1- Crea los meses dinamicamente utilizando el valor que contiene la columna mes de la tabla temporal
        2- DISTINCT CONCAT construye expresión sum para cada mes con la siguiente forma: sum(case when mes = "Enero" then total else 0 end) as "Enero",
        3- GROUP_CONCAT crea una cadena de todas las expresiones sum generadas por DISTINCT CONCAT separadas por comas y ordenadas por month_num ascendente.
        5- El resultado del select lo almacena en la variable @query */
	  IF EXISTS (SELECT * FROM tmp_ingresos_mes) THEN
      -- Crea variable query
      SET @query = NULL;
		SELECT
			GROUP_CONCAT(
			  DISTINCT CONCAT('SUM(CASE WHEN mes = "', mes, '" THEN total ELSE 0 END) AS `', mes, '`' )
			order by month_num asc) INTO @query
		FROM tmp_ingresos_mes;
		
        /* En la misma variable @query se asigna una cadena 
			formada por la palabra select, y el contenido de la variable @query
            y la palabra from con el nombre de la tabla temporal  */
		SET @query = CONCAT('SELECT ', @query, ' FROM tmp_ingresos_mes');

	  -- Prepara la consulta contenida en la variable @query para su ejecución
		PREPARE stmt FROM @query; 
      -- Ejecuta la consulta
		EXECUTE stmt;
      -- Desasigna la consulta preparada
		DEALLOCATE PREPARE stmt;
      
        ELSE
          SELECT CONCAT('No hay datos para el año ', year) AS result;
          
	END IF;
    -- Se elimina la tabla temporal
    DROP TEMPORARY TABLE IF EXISTS tmp_ingresos_mes;
end //
delimiter ;