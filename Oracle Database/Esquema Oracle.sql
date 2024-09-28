CREATE TABLE tipoEmpleado (
    idTipoEmpleado number not null PRIMARY KEY,
    tipoEmpleado VARCHAR2(60)
);

CREATE SEQUENCE sec_tipoEmpleado START WITH 1 INCREMENT BY 1;

CREATE TRIGGER trig_idTipoEmpleado
BEFORE INSERT ON tipoEmpleado
FOR EACH ROW
BEGIN
	SELECT sec_tipoEmpleado.NEXTVAL
	INTO :new.idTipoEmpleado
	FROM dual;
END;
/

-- departamento
CREATE TABLE departamento (
    idDepartamento NUMBER NOT NULL PRIMARY KEY,
    departamento VARCHAR2(30)
);

CREATE SEQUENCE sec_departamento START WITH 1 INCREMENT BY 1;

CREATE TRIGGER trig_idDepartamento
BEFORE INSERT ON departamento
FOR EACH ROW
BEGIN
	SELECT sec_departamento.NEXTVAL
	INTO :new.idDepartamento
	FROM dual;
END;
/

-- estado de empleado
CREATE TABLE estado (
    idEstado NUMBER NOT NULL PRIMARY KEY,
    estado VARCHAR2(20)
);

CREATE SEQUENCE sec_estado START WITH 1 INCREMENT BY 1;

CREATE TRIGGER trig_idEstado
BEFORE INSERT ON estado
FOR EACH ROW
BEGIN
	SELECT sec_estado.NEXTVAL
	INTO :new.idEstado
	FROM dual;
END;
/
-- Empleado
CREATE TABLE empleado (
    idEmpleado NUMBER NOT NULL PRIMARY KEY,
    nombres VARCHAR2(60),
    apellidos VARCHAR2(60),
    dpi VARCHAR2(20) UNIQUE,
    fechaNacimiento DATE,
    direccion VARCHAR2(90),
    telefono NUMBER,
    email VARCHAR2(95),
    idTipoEmpleado NUMBER NOT NULL,
    idDepartamento NUMBER NOT NULL,
    idEstado NUMBER NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_empleado_idtipoempleado FOREIGN KEY (idTipoEmpleado) REFERENCES tipoEmpleado (idTipoEmpleado),
    CONSTRAINT fk_empleado_iddepartamento FOREIGN KEY (idDepartamento) REFERENCES departamento (idDepartamento),
	CONSTRAINT fk_empleado_idestado FOREIGN KEY (idEstado) REFERENCES estado (idEstado)
);

CREATE SEQUENCE sec_empleado START WITH 1 INCREMENT BY 1;

CREATE TRIGGER trig_idEmpleado
BEFORE INSERT ON empleado
FOR EACH ROW
BEGIN
	SELECT sec_empleado.NEXTVAL
	INTO :new.idEmpleado
	FROM dual;
END;
/

-- CLIENTE
CREATE TABLE cliente (
    idCliente NUMBER NOT NULL PRIMARY KEY,
    nombres VARCHAR2(60),
    apellidos VARCHAR2(60),
    dpi VARCHAR2(20) UNIQUE,
    fechaNacimiento DATE,
    direccion VARCHAR2(90),
    telefono NUMBER,
    email VARCHAR2(95),
    nit VARCHAR2(16),
    idEstado INT NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_cliente_idestado FOREIGN KEY (idEstado) REFERENCES estado (idEStado)
);

CREATE SEQUENCE sec_cliente START WITH 1 INCREMENT BY 1;

CREATE TRIGGER trig_idCliente
BEFORE INSERT ON cliente
FOR EACH ROW
BEGIN
	SELECT sec_cliente.NEXTVAL
	INTO :new.idCliente
	FROM dual;
END;
/
-- Marca
CREATE TABLE marca (
    idMarca NUMBER NOT NULL PRIMARY KEY,
    marca VARCHAR2(60) UNIQUE
);

CREATE SEQUENCE sec_marca START WITH 1 INCREMENT BY 1;

CREATE TRIGGER trig_idMarca
BEFORE INSERT ON marca
FOR EACH ROW
BEGIN
	SELECT sec_marca.NEXTVAL
	INTO :new.idMarca
	FROM dual;
END;
/
-- Modelo
CREATE TABLE modelo (
    idModelo NUMBER NOT NULL PRIMARY KEY,
    modelo VARCHAR2(60) UNIQUE,
    idMarca NUMBER NOT NULL,
    CONSTRAINT fk_modelo_idmarca FOREIGN KEY (idMarca) REFERENCES marca(idMarca)
);

CREATE SEQUENCE sec_modelo START WITH 1 INCREMENT BY 1;

CREATE TRIGGER trig_idModelo
BEFORE INSERT ON modelo
FOR EACH ROW
BEGIN
	SELECT sec_modelo.NEXTVAL
	INTO :new.idModelo
	FROM dual;
END;
/

-- Tipo de carrocería
CREATE TABLE tipoCarroceria (
    idTipoCarroceria NUMBER NOT NULL PRIMARY KEY,
    tipoCarroceria VARCHAR2(60) UNIQUE
);

CREATE SEQUENCE sec_tipoCarroceria START WITH 1 INCREMENT BY 1;

CREATE TRIGGER trig_idTipoCarroceria 
BEFORE INSERT ON tipoCarroceria
FOR EACH ROW
BEGIN
	SELECT sec_tipoCarroceria.NEXTVAL
	INTO :new.idTipoCarroceria
	FROM dual;
END;
/

-- Motor
CREATE TABLE motor (
    idMotor NUMBER NOT NULL PRIMARY KEY,
    motor VARCHAR2(20) UNIQUE    
);

CREATE SEQUENCE sec_motor START WITH 1 INCREMENT BY 1;

CREATE TRIGGER trig_idMotor 
BEFORE INSERT ON motor
FOR EACH ROW
BEGIN
	SELECT sec_motor.NEXTVAL
	INTO :new.idMotor
	FROM dual;
END;
/

-- Estado de Orden
CREATE TABLE estadoOrden (
    idEstadoOrden NUMBER NOT NULL PRIMARY KEY,
    estadoOrden VARCHAR2(20) UNIQUE
);

CREATE SEQUENCE sec_estadoOrden START WITH 1 INCREMENT BY 1;

CREATE TRIGGER trig_idEstadoOrden 
BEFORE INSERT ON estadoOrden
FOR EACH ROW
BEGIN
	SELECT sec_estadoOrden.NEXTVAL
	INTO :new.idEstadoOrden
	FROM dual;
END;
/

-- Vehiculo
CREATE TABLE vehiculo (
    placa VARCHAR2(10) PRIMARY KEY,
    descripcion VARCHAR2(125),
    color VARCHAR2(75),
    year NUMBER,
    idCliente NUMBER NOT NULL,
    idModelo NUMBER NOT NULL,
    idMotor	NUMBER NOT NULL,
    idTipoCarroceria NUMBER NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_vehiculo_idcliente FOREIGN KEY (idCliente) REFERENCES cliente (idCliente),
    CONSTRAINT fk_vehiculo_idmodelo FOREIGN KEY (idModelo) REFERENCES modelo (idModelo),
	CONSTRAINT fk_vehiculo_idmotor FOREIGN KEY (idMotor) REFERENCES motor (idMotor),
    CONSTRAINT fk_vehiculo_idtipocarroceria FOREIGN KEY (idTipoCarroceria) REFERENCES tipoCarroceria (idTipoCarroceria)
);

-- Servicio
CREATE TABLE servicio (
    idServicio NUMBER NOT NULL PRIMARY KEY,
    servicio VARCHAR2(125) UNIQUE
);

CREATE SEQUENCE sec_servicio START WITH 1 INCREMENT BY 1;

CREATE TRIGGER trig_idServicio 
BEFORE INSERT ON servicio
FOR EACH ROW
BEGIN
	SELECT sec_servicio.NEXTVAL
	INTO :new.idServicio
	FROM dual;
END;
/

-- Precio de servicio
CREATE TABLE precioServicio (
    idServicio NUMBER NOT NULL,
    idModelo NUMBER NOT NULL,
    idMotor NUMBER NOT NULL,
    fechaInicioVigencia DATE NOT NULL,
    precio NUMBER(12,2),
    PRIMARY KEY (idServicio, idModelo, idMotor, fechaInicioVigencia),
    CONSTRAINT fk_precioservicio_idservicio FOREIGN KEY (idServicio) REFERENCES servicio (idServicio),
    CONSTRAINT fk_precioservicio_idmodelo FOREIGN KEY (idModelo) REFERENCES modelo (idModelo),
    CONSTRAINT fk_precioservicio_idmotor FOREIGN KEY (idMotor) REFERENCES motor (idMotor)
);

-- Orden de servicio
CREATE TABLE ordenServicio (
    idOrdenServicio NUMBER NOT NULL PRIMARY KEY,
    fechaOrdenServicio DATE,
    placa VARCHAR2(10),
    kmActual NUMBER,
    kmProximo NUMBER,
    idEstadoOrden NUMBER NOT NULL,
    idEmpleado NUMBER NOT NULL,
    CONSTRAINT fk_ordenservicio_placa FOREIGN KEY (placa) REFERENCES vehiculo (placa),
    CONSTRAINT fk_ordenservicio_idestadoorden FOREIGN KEY (idEstadoOrden) REFERENCES estadoOrden (idEstadoOrden)
);

CREATE SEQUENCE sec_ordenServicio START WITH 1 INCREMENT BY 1;

CREATE TRIGGER trig_idOrdenServicio
BEFORE INSERT ON ordenServicio
FOR EACH ROW
BEGIN
	SELECT sec_ordenServicio.NEXTVAL
	INTO :new.idOrdenServicio
	FROM dual;
END;
/

-- DETALLE DE ORDEN
CREATE TABLE detalleOrden (
    idOrdenServicio NUMBER NOT NULL,
    idServicio NUMBER NOT NULL,
    cantidad NUMBER NOT NULL,
    PRIMARY KEY (idOrdenServicio, idServicio),
    CONSTRAINT fk_do_idordenservicio FOREIGN KEY (idOrdenServicio) REFERENCES ordenServicio (idOrdenServicio) ON DELETE CASCADE,
    CONSTRAINT fk_do_idservicio FOREIGN KEY (idServicio) REFERENCES servicio (idServicio)
);



