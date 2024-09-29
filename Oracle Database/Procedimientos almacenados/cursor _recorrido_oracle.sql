-- Procedimiento de oracle
-- Un procedimiento que crea y lee un cursor dentro del procedimiento
-- La consulta obtiene las ordenes de servicio de un vehículo específico
CREATE OR REPLACE PROCEDURE obtener_ordenes_vehiculo2 (
    p_placa IN vehiculo.placa%TYPE
) IS
    -- Se crea el cursor
    CURSOR cursor_ordenes IS
        SELECT idOrdenServicio, fechaOrdenServicio
        from ordenServicio os
			inner join vehiculo v on os.placa = v.placa
        where v.placa = p_placa;

    v_idordenservicio ordenServicio.idOrdenServicio%TYPE;
    v_fechaordenservicio ordenServicio.fechaOrdenServicio%TYPE;
    
BEGIN
    OPEN cursor_ordenes;
	LOOP
        FETCH cursor_ordenes INTO v_idordenservicio, v_fechaordenservicio;
        EXIT WHEN cursor_ordenes%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('No. de orden: ' || v_idordenservicio || ', Fecha: ' || v_fechaordenservicio);
    END LOOP;

    CLOSE cursor_ordenes;

END;
/


-- Ejecutar el procedimiento
BEGIN
    obtener_ordenes_vehiculo2('P-175ALG'); 
END;
/
