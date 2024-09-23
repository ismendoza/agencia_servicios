create table tipoEmpleado (
    idTipoEmpleado INT IDENTITY PRIMARY KEY,
    tipoEmpleado VARCHAR(30) UNIQUE
);

CREATE TABLE departamento (
    idDepartamento INT IDENTITY PRIMARY KEY,
    departamento VARCHAR(60) UNIQUE
);

CREATE TABLE estado (
    idEStado INT IDENTITY PRIMARY KEY,
    estado VARCHAR(60) UNIQUE
);

CREATE TABLE empleado (
    idEmpleado INT IDENTITY PRIMARY KEY,
    nombres VARCHAR(60),
    apellidos VARCHAR(60),
    dpi VARCHAR(20) UNIQUE,
    fechaNacimiento DATE,
    direccion VARCHAR(90),
    telefono INT,
    email VARCHAR(95),
    idTipoEmpleado INT NOT NULL,
    idDepartamento INT NOT NULL,
    idEstado INT NOT NULL,
    createdAt DATETIME default CURRENT_TIMESTAMP,
    CONSTRAINT fk_empleado_idTipoEmpleado FOREIGN KEY (idTipoEmpleado) REFERENCES tipoEmpleado (idTipoEmpleado),
    CONSTRAINT fk_empleado_idDepartamento FOREIGN KEY (idDepartamento) REFERENCES departamento (idDepartamento),
    CONSTRAINT fk_empleado_idEstado FOREIGN KEY (idEstado) REFERENCES estado (idEstado)
    );

CREATE TABLE cliente (
    idCliente INT IDENTITY PRIMARY KEY,
    nombres VARCHAR(60),
    apellidos VARCHAR(60),
    dpi VARCHAR (20) UNIQUE,
    fechaNacimiento DATE,
    direccion VARCHAR(90),
    telefono INT,
    email VARCHAR(95),
    nit VARCHAR(16),
    idEstado INT NOT NULL,
    createdAt DATETIME default CURRENT_TIMESTAMP,
    CONSTRAINT fk_cliente_idestado FOREIGN KEY (idEstado) REFERENCES estado (idEstado)
);


CREATE TABLE marca (
    idMarca INT IDENTITY PRIMARY KEY,
    marca VARCHAR(60) UNIQUE, 
);

CREATE TABLE modelo (
    idModelo INT IDENTITY PRIMARY KEY,
    modelo VARCHAR(60) UNIQUE,
    idMarca INT NOT NULL,
    CONSTRAINT fk_modelo_idmarca FOREIGN KEY (idMarca) REFERENCES marca (idMarca)
);

CREATE TABLE tipoCarroceria (
    idTipoCarroceria INT IDENTITY PRIMARY KEY,
    tipoCarroceria VARCHAR(60) UNIQUE,
);

CREATE TABLE motor (
    idMotor INT IDENTITY PRIMARY KEY,
    motor VARCHAR(20) UNIQUE,
);

CREATE TABLE estadoOrden (
    idEstadoOrden INT IDENTITY PRIMARY KEY,
    estadoOrden VARCHAR(20) UNIQUE
);

CREATE TABLE vehiculo (
    placa VARCHAR (10) PRIMARY KEY,
    descripcion VARCHAR(125),
    COLOR VARCHAR(75),
    year INT,
    idCliente INT NOT NULL,
    idModelo INT NOT NULL,
    idMotor INT NOT NULL,
    idTipoCarroceria INT NOT NULL,
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_vehiculo_idcliente FOREIGN KEY (idCliente) REFERENCES cliente (idCliente),
    CONSTRAINT fk_vehiculo_idmodelo FOREIGN KEY (idModelo) REFERENCES modelo (idModelo),
    CONSTRAINT fk_vehiculo_idmotor FOREIGN KEY (idMotor) REFERENCES motor (idMotor),
    CONSTRAINT fk_vehiculo_idtipocarroceria FOREIGN KEY (idTipoCarroceria) REFERENCES tipoCarroceria (idTipoCarroceria)
);

CREATE TABLE servicio (
    idServicio INT IDENTITY PRIMARY KEY,
    servicio VARCHAR(125) UNIQUE
);

CREATE TABLE precioServicio (
    idServicio INT NOT NULL,
    idModelo INT NOT NULL,
    idMotor INT NOT NULL,
    fechaInicioVigencia DATE,
    precio DECIMAL(12,2),
    PRIMARY KEY (idServicio, idModelo, idMotor, fechaInicioVigencia),
    INDEX ps_idservicio (idServicio),
    INDEX ps_idmodelo (idModelo),
    INDEX ps_idmotor (idMotor),
    INDEX ps_fechaiv (fechaInicioVigencia),
    CONSTRAINT fk_precioservicio_idservicio FOREIGN KEY (idServicio) REFERENCES servicio (idServicio),
    CONSTRAINT fk_precioservicio_idmodelo FOREIGN KEY (idModelo) REFERENCES modelo (idModelo),
    CONSTRAINT fk_precioservicio_idmotor FOREIGN KEY (idMotor) REFERENCES motor (idMotor)
);

CREATE TABLE ordenServicio (
    idOrdenServicio INT IDENTITY PRIMARY KEY,
    fechaOrdenServicio DATE,
    placa VARCHAR(10),
    kmActual INT,
    kmProximo INT,
    idEstadoOrden INT NOT NULL,
    idEmpleado INT NOT NULL,
    CONSTRAINT fk_ordenservicio_placa FOREIGN KEY (placa) REFERENCES vehiculo(placa),
    CONSTRAINT fk_ordenservicio_idestadoorden FOREIGN KEY (idEstadoOrden) REFERENCES estadoOrden (idEstadoOrden),
    CONSTRAINT fk_ordenservicio_idempleado FOREIGN KEY (idEmpleado) REFERENCES empleado (idEmpleado)
);

CREATE TABLE detalleOrden (
    idOrdenServicio INT NOT NULL,
    idServicio INT NOT NULL,
    cantidad int,
    INDEX do_idOrden_fk (idOrdenServicio),
    INDEX do_idServicio_fk (idServicio),
    CONSTRAINT fk_do_idOrdenServicio FOREIGN KEY (idOrdenServicio) REFERENCES ordenServicio (idOrdenServicio) ON DELETE CASCADE,
    CONSTRAINT fk_do_idServicio FOREIGN KEY (idServicio) REFERENCES servicio(idServicio)
);