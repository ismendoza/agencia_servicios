-- Procedimiento de oracle
-- Se actualiza el estado de la orden del ervicio

CREATE OR REPLACE PROCEDURE actualiza_estado_orden (
    p_no_orden IN NUMBER
) IS
BEGIN
-- Actualiza el registro con el ID proporcionado
  UPDATE ordenServicio
  SET idEstadoOrden = 1
  WHERE idOrdenServicio = p_no_orden;

  	IF SQL%ROWCOUNT > 0 THEN
        DBMS_OUTPUT.PUT_LINE('El estado de la orden ' || p_no_orden || ' se actualizó correctamente.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('No se encontró la orden ' || p_no_orden || ' o no se realizó ninguna actualización.');
	END IF;
END;
/

-- Ejecutar el procedimiento

EXECUTE actualiza_estado_orden(51); 