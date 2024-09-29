/* Tablas
   Utilizando create table. Se definen las tablas con sus columnas de diferentes tipos de datos y restricciones.
   Este código no ha sido generado por ningun sistema de base de datos
   El propósito de este archivo es conocer los comandos básico DDL (Data Definition Language) para crear una base de datos relacional.
   */

-- Crear tabla para tipo de empleado
create table tipoEmpleado (
    idTipoEmpleado int not null auto_increment key,
    tipoEmpleado varchar(30) unique comment 'Nombre del tipo de empleado'
);
-- Crear la tabla para departamento (ventas, compras, rrhh, etc.)
create table departamento (
    idDepartamento int not null auto_increment key,
    departamento varchar(60) unique comment 'Nombre del departamento'
);
-- crea tabla para estado de empleado y cliente
create table estado (
    idEstado int not null auto_increment key,
    estado varchar(60) unique comment 'Nombre del estado, activo, inactivo'
);

-- Crea tabla empleado: 
-- En esta declaración se muestra como se crean restricciones:
-- NOT NULL, DEFAULT, PRIMARY KEY, FOREIGN KEY Y UNIQUE
create table empleado (
    idEmpleado int not null auto_increment,
    nombres varchar(60),
    apellidos varchar(60),
    dpi varchar(20) unique,
    fechaNacimiento date,
    direccion varchar(90),
    telefono int,
    email varchar(95),
    idTipoEmpleado int not null,
    idDepartamento int not null,
    idEstado int not null,
    createdAt timestamp default current_timestamp,
    primary key (idEmpleado),
    constraint fk_empleado_idTipoEmpleado foreign key (idTipoEmpleado) references tipoEmpleado (idTipoEmpleado),
    constraint fk_empleado_idDepartamento foreign key (idDepartamento) references departamento (idDepartamento),
    constraint fk_empleado_idEstado foreign key (idEstado) references estado (idEstado)
);

-- Crea tabla para cliente
create table cliente (
    idCliente int not null auto_increment,
    nombres varchar(60),
    apellidos varchar(60),
    dpi varchar(20) unique,
    fechaNacimiento date,
    direccion varchar(90),
    telefono int,
    email varchar(95),
    nit varchar(16),
    idEstado int not null,
    createdAt timestamp default current_timestamp,
    primary key (idCliente),
    constraint fk_cliente_idestado foreign key (idEstado) references estado (idEstado)
);

-- crea tabla para marca
create table marca (
    idMarca int not null auto_increment key,
    marca varchar(60) unique comment 'Nombre de marca'
);

-- crea tabla para modelo de la marca
create table modelo (
    idModelo int not null auto_increment,
    modelo varchar(60) unique comment 'Nombre de modelo',
    idMarca int not null,
    primary key (idModelo),
    constraint fk_modelo_idmarca foreign key (idMarca) references marca (idMarca)
);

-- Crea tabla para tipo de carrocería de vehículo
create table tipoCarroceria (
    idTipoCarroceria int not null auto_increment key,
    tipoCarroceria varchar(60) unique comment 'Nombre de tipo de carrocería'
);

-- Crea tabla para el tamaño del motor
create table motor (
    idMotor int not null auto_increment key,
    motor varchar(20)
);

-- Crea tabala para estado de orden de servicio
create table estadoOrden(
    idEstadoOrden int not null auto_increment key,
    estadoOrden varchar(40) unique comment 'Nombre del estado, En progreso, Cancelada, Completada'
);

-- Crea tabla para vehículo
create table vehiculo (
    placa varchar(10) unique not null,
    descripcion varchar(125),
    color varchar(75),
    year int,
    idCliente int not null,
    idModelo int not null,
    idMotor int not null,
    idTipoCarroceria int not null,
    createdAt timestamp default current_timestamp,
    constraint fk_vehiculo_idcliente foreign key (idCliente) references cliente (idCliente),
    constraint fk_vehiculo_idmodelo foreign key (idModelo) references modelo (idModelo),
    constraint fk_vehiculo_idmotor foreign key (idMotor) references motor (idMotor),
    constraint fk_vehiculo_idtipocarroceria foreign key (idTipoCarroceria) references tipoCarroceria (idTipoCarroceria)
);

-- Crea la tabla servicio, la llave priaria se declara con key
create table servicio (
    idServicio int not null auto_increment key,
    servicio varchar(125) unique comment 'Nombre del servicio'
);

-- Crea tabla para manejar los precios
create table precioServicio (
    idServicio int not null,
    idModelo int not null,
    idMotor int not null,
    fechaInicioVigencia date,
    precio decimal(12, 2),
    primary key (idServicio, idModelo, idMotor, fechaInicioVigencia),
    index precioServicio_fechaInicioVigencia (fechaInicioVigencia),
    constraint fk_precioservicio_idservicio foreign key (idServicio) references servicio (idServicio),
	constraint fk_precioservicio_idModelo foreign key (idModelo) references modelo (idModelo),
    constraint fk_precioservicio_idMotor foreign key (idMotor) references motor (idMotor)
);

create table ordenServicio (
    idOrdenServicio int not null auto_increment,
    fechaOrdenServicio date,
    placa varchar(10) not null,
    kmActual int,
    kmProximo int,
    idEstadoOrden int not null,
    idEmpleado int not null,
    primary key (idOrdenServicio),
    constraint fk_ordenservicio_placa foreign key (placa) references vehiculo (placa),
    constraint fk_ordenservicio_idestadoorden foreign key(idEstadoOrden) references estadoOrden(idEstadoOrden),
    constraint fk_ordenservicio_idempleado foreign key(idEmpleado) references empleado(idEmpleado)
);

-- Crea tabla detalle de orden de servicio
-- En esta declaración se definen los indices para las restricciones FOREIGN KEY
create table detalleOrden (
    idOrdenServicio int not null,
    idServicio int not null,
    -- precio decimal(12, 2) comment 'Para registro de precio actual en fecha de creación de ordenServicio',
    cantidad int,
    primary key(idOrdenServicio, idServicio),
    constraint fk_detalleorden_idordenservicio foreign key (idOrdenServicio) references ordenServicio (idOrdenServicio) on delete cascade on update cascade,
    constraint fk_detalleorden_idservicio foreign key (idServicio) references servicio (idServicio)
);