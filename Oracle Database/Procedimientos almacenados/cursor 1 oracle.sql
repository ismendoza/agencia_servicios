-- Procedimiento de oracle
-- Hacer una verificación con if durante el recorido del cursor
-- Se muestran las ordenes de servicio que hacen un total mayor a 650 (suma los precios de los servicios de la orden de servicio)
CREATE OR REPLACE PROCEDURE mayor_cien(
    year IN NUMBER
) IS

	CURSOR cursor_ordenes IS
		WITH precios_actuales AS (
			select os.idOrdenServicio, nombres||' '||apellidos as cliente, v.placa, os.fechaOrdenServicio, ps.precio, cantidad,
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
				and EXTRACT(YEAR FROM fechaOrdenServicio) = year
			group by idOrdenServicio order by idOrdenServicio;

	v_idOrdenServicio NUMBER;
	v_total NUMBER(12,2);

BEGIN
    OPEN cursor_ordenes;
	LOOP
        FETCH cursor_ordenes INTO v_idOrdenServicio, v_total;
		EXIT WHEN cursor_ordenes%NOTFOUND;

		IF v_total > 650 THEN
        DBMS_OUTPUT.PUT_LINE('No. de orden: ' || v_idOrdenServicio || ', Total: ' || v_total);    
        END IF;

		
	END LOOP;

	CLOSE cursor_ordenes;

END;
/

-- Ejecutar el procedimiento

BEGIN
    mayor_cien(2024); 
END;
/