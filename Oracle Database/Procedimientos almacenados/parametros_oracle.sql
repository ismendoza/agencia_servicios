---- Procedimiento de oracle
-- Un procedimiento básico con parametro de entrada y salida, la variable de salida se lee en la ejecución del procedimiento
-- Un simple procedimiento que obtiene el propietario de un vehículo
CREATE OR REPLACE PROCEDURE obtener_propietario_vehiculo(
    p_placa IN vehiculo.placa%TYPE,
    p_cliente OUT VARCHAR2
) IS
BEGIN
    SELECT nombres||' '||apellidos as propietario
    INTO p_cliente 
    from cliente c
    inner join vehiculo v on v.idCliente = c.idCliente
    where placa = p_placa;
END;
/

-- Ejecución del procedimiento
DECLARE
    v_propietario VARCHAR2(100);
BEGIN
    obtener_propietario_vehiculo('P-175ALG', v_propietario);
    DBMS_OUTPUT.PUT_LINE('El propietario del vehículo es: ' || v_propietario);
END;
/



