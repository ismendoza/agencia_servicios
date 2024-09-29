-- Procedimiento de oracle
-- Un procedimiento con una consulta simple para crear un cusor
-- Se muestran las ordenes de servicio que pertenecen a un vehiculo
-- Se crean dos parametros, un o de entrada y uno salida, el de salida es un cursor
-- Este procedimiento da el mismo resultado que el cursor_recorrido_oracle.sql pero el cursor se lee en la ejecución del procedimiento

CREATE OR REPLACE PROCEDURE obtener_ordenes_vehiculo (
    p_placa IN vehiculo.placa%TYPE,
    p_ordenes OUT SYS_REFCURSOR
) IS
BEGIN
    OPEN p_ordenes FOR
        SELECT idOrdenServicio, fechaOrdenServicio
        from ordenServicio os
			inner join vehiculo v on os.placa = v.placa
        where v.placa = p_placa;
END;
/

-- Ejecutar el procedimiento almacenado y recorrer el cursor
DECLARE
    v_ordenes_cursor SYS_REFCURSOR;
    v_idordenservicio ordenServicio.idOrdenServicio%TYPE;
    v_fechaordenservicio ordenServicio.fechaOrdenServicio%TYPE;
    
BEGIN
    obtener_ordenes_vehiculo('P-175ALG', v_ordenes_cursor); 

    LOOP
        FETCH v_ordenes_cursor INTO v_idordenservicio, v_fechaordenservicio;
        EXIT WHEN v_ordenes_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('No. de orden: ' || v_idordenservicio || ', Fecha: ' || v_fechaordenservicio);
    END LOOP;

    CLOSE v_ordenes_cursor;
END;
/
