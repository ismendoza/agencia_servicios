insert into tipoEmpleado (tipoEmpleado) values ('Mecánico');
insert into marca (marca) values ('Toyota'), ('Nissan'), ('Mazda'), ('Honda'), ('Ford'), ('Volkswagen');
insert into modelo (modelo, idMarca) values ('Yaris', 1), ('Versa',2), ('Mazda 3', 3), ('Corolla',1);
insert into tipoCarroceria (tipoCarroceria) values ('Sedan'), ('Camioneta'), ('Hatchback');
insert into estado(estado) values ('Activo');
insert into estadoOrden(estadoOrden) values ('En progreo');
insert into estadoOrden(estadoOrden) values ('Completada');

-- Catalogo de servicios
-- 1
insert into servicio(servicio) values ('Cambio de aceite de motor');
-- 2
insert into servicio(servicio) values ('Cambio de liquido de frenos'); 
-- 3
insert into servicio(servicio) values ('Cambio de filtro de aceite'); 
-- 4
insert into servicio(servicio) values ('Cambio de refrigerante'); 
-- 5
insert into servicio(servicio) values ('Cambio de faja de alternador'); 
-- 6
insert into servicio(servicio) values ('Cambio de bujias'); 
-- 7
insert into servicio(servicio) values ('Cambio de filtro de aire'); 
-- 8
insert into servicio(servicio) values ('Cambio de aceite de transmisión automática'); 
-- 9
insert into servicio(servicio) values ('Cambio de aceite de transmisión mecaánica'); 
-- 10
insert into servicio(servicio) values ('Revisión y ajusto de clutch');
-- Catalogo de tamaños de motor
insert into motor(motor) values ('1.5L'); -- 1
insert into motor(motor) values ('1.6L'); -- 2
insert into motor(motor) values ('1.8L'); -- 3
insert into motor(motor) values ('2.0L'); -- 4
insert into motor(motor) values ('2.4L'); -- 5
insert into motor(motor) values ('2.5L'); -- 6
insert into motor(motor) values ('2.8L'); -- 7
insert into motor(motor) values ('3.0L'); -- 8
insert into motor(motor) values ('3.2L'); -- 9
insert into motor(motor) values ('3.5L'); -- 10
-- Catalogo de clientes
insert into cliente(nombres, apellidos, direccion, nit, idEstado) values ('Leticia','Campos','2 calle','104752-5',1);
insert into cliente(nombres, apellidos, direccion, nit, idEstado) values ('Lucas','Rosales','5 calle','261425-1',1);
insert into cliente(nombres, apellidos, direccion, nit, idEstado) values ('Daniela','Ramirez','6 calle','1842142-1',1);
insert into cliente(nombres, apellidos, direccion, nit, idEstado) values ('Mariela','Gomez','9 calle','114714-1',1);
insert into cliente(nombres, apellidos, direccion, nit, idEstado) values ('Miguel','Marino','4 calle','465214-6',1);
insert into cliente(nombres, apellidos, direccion, nit, idEstado) values ('Angelica','Ramirez','1 calle','2914512-6',1);
insert into cliente(nombres, apellidos, direccion, nit, idEstado) values ('Luis','Fernandez','5 calle','578458-6',1);
insert into cliente(nombres, apellidos, direccion, nit, idEstado) values ('Antonio','Quezada','2 calle','5478541-6',1);

-- Catalogo de vehículos
insert into vehiculo(placa, color, year, idCliente, idModelo, idMotor, idTipoCarroceria ) values ('P-256LRM', 'Negro',  2022, 1, 1, 1, 1);
insert into vehiculo(placa, color, year, idCliente, idModelo, idMotor, idTipoCarroceria ) values ('P-128MHB', 'Blanco', 2020, 1, 2, 1, 1);
insert into vehiculo(placa, color, year, idCliente, idModelo, idMotor, idTipoCarroceria ) values ('P-614PNR', 'Rojo',   2020, 3, 3, 4, 1);
insert into vehiculo(placa, color, year, idCliente, idModelo, idMotor, idTipoCarroceria ) values ('P-120RAM', 'Azul',   2020, 3, 4, 3, 1);
insert into vehiculo(placa, color, year, idCliente, idModelo, idMotor, idTipoCarroceria ) values ('P-175ALG', 'Blanco',  2023,1, 1, 1, 1);
insert into vehiculo(placa, color, year, idCliente, idModelo, idMotor, idTipoCarroceria ) values ('P-240ABC', 'Blanco',  2023,5, 1, 1, 1);
insert into vehiculo(placa, color, year, idCliente, idModelo, idMotor, idTipoCarroceria ) values ('P-741XYZ', 'Blanco',  2023,6, 3, 4, 1);
insert into vehiculo(placa, color, year, idCliente, idModelo, idMotor, idTipoCarroceria ) values ('P-852GDC', 'Blanco',  2022,7, 3, 4, 1);
insert into vehiculo(placa, color, year, idCliente, idModelo, idMotor, idTipoCarroceria ) values ('P-963JKL', 'Blanco',  2022,8, 3, 5, 1);

-- Catalogo de precis de servicio -----
-- Tomar en cuenta que un mismo servicio se puede realizar en diferentes modelos con diferentes tamaño de motor
-- Por eso un mismo servicio tiene diferente precio en diferentes modelos debido al tamaño del motor

-- Yaris 1.5L 
-- Cambio de aceite de motor; precio 450.00
insert into precioServicio(idServicio, idModelo, idMotor, fechaInicioVigencia, precio) values (1, 1, 1, '2024-02-01', '450.00');
-- Cambio de filtro de aire; precio 96.00; 
insert into precioServicio(idServicio, idModelo, idMotor, fechaInicioVigencia, precio) values (7, 1, 1, '2024-02-01', '96.00');
-- Cambio de aceite de motor; precio 458.00; Aquí cambia el precio de este servicio
insert into precioServicio(idServicio, idModelo, idMotor, fechaInicioVigencia, precio) values (1, 1, 1, '2024-02-15', '458.00');
-- Cambio de aceite de motor; precio 450.00; Aquí Cambia el precio de este servicio
insert into precioServicio(idServicio, idModelo, idMotor, fechaInicioVigencia, precio) values (1, 1, 1, '2024-03-01', '450.00');
-- Cambio de aceite de motor; precio 475.00; Aquí cambia el precio de este servicio
insert into precioServicio(idServicio, idModelo, idMotor, fechaInicioVigencia, precio) values (1, 1, 1, '2024-04-01', '475.00');


-- Versa 1.5L
-- Cambio de aceite de motor; precio 460.00
insert into precioServicio(idServicio, idModelo, idMotor, fechaInicioVigencia, precio) values (1, 2, 1, '2024-02-01', '460.00'); 
-- Cambio de refrigerante; precio 650.00
insert into precioServicio(idServicio, idModelo, idMotor, fechaInicioVigencia, precio) values (4, 2, 1, '2024-02-01', '100.00');
-- Revisión y ajuste de clutch; precio 100.00
insert into precioServicio(idServicio, idModelo, idMotor, fechaInicioVigencia, precio) values (10, 2, 1, '2024-02-01', '100.00');

-- Corolla 1.8L
-- cambio de aceite de motor; precio 455.00
insert into precioServicio(idServicio, idModelo, idMotor, fechaInicioVigencia, precio) values (1, 4, 3, '2024-02-01', '455.00');
-- Cambio de refrigerante; precio 100.00
insert into precioServicio(idServicio, idModelo, idMotor, fechaInicioVigencia, precio) values (4, 4, 3, '2024-02-01', '100.00');
-- Cambio de bujias, modelo; precio 300.00
insert into precioServicio(idServicio, idModelo, idMotor, fechaInicioVigencia, precio) values (6, 4, 3, '2024-02-01', '300.00');
-- Cambio de filtro de aire; precio 100.00
insert into precioServicio(idServicio, idModelo, idMotor, fechaInicioVigencia, precio) values (7, 4, 3, '2024-02-01', '100.00');

-- Mazda3 2.0L
-- Cambio de aceite de motor; precio 675.00
insert into precioServicio(idServicio, idModelo, idMotor, fechaInicioVigencia, precio) values (1, 3, 4, '2024-02-01', '675.00');
-- Cambio de refrigerante; precio 125.00
insert into precioServicio(idServicio, idModelo, idMotor, fechaInicioVigencia, precio) values (4, 3, 4, '2024-02-01', '125.00');
-- Cambio de filtro de aire; precio 110.00
insert into precioServicio(idServicio, idModelo, idMotor, fechaInicioVigencia, precio) values (7, 3, 4, '2024-02-01', '110.00'); 
-- Cambio de filtro de aceite; precio 125.00
insert into precioServicio(idServicio, idModelo, idMotor, fechaInicioVigencia, precio) values (3, 3, 4, '2024-02-01', '125.00'); 
-- Cambio de bujías; precio 610.00
insert into precioServicio(idServicio, idModelo, idMotor, fechaInicioVigencia, precio) values (6, 3, 4, '2024-02-01', '610.00'); 
-- Revisión y ajuste de clutch; precio 95.00
insert into precioServicio(idServicio, idModelo, idMotor, fechaInicioVigencia, precio) values (10, 3, 4, '2024-02-01', '95.00');
-- Cambio de filtro de aire; precio 105.00; Aquí cambia el precio
insert into precioServicio(idServicio, idModelo, idMotor, fechaInicioVigencia, precio) values (7, 3, 4, '2024-02-20', '105.00');

-- Mazda3 2.4L
-- Cambio de aceite de motor; precio 625.00
insert into precioServicio(idServicio, idModelo, idMotor, fechaInicioVigencia, precio) values (1, 3, 5, '2024-02-01', '625.00');


-- Crea orden de servicio 1
insert into ordenServicio(fechaOrdenServicio, placa, kmActual, idEstadoOrden) values ('2024-02-05', 'P-256LRM', 50000, 1);
-- Crea detalle de orden 1
insert into detalleOrden(idOrdenServicio, idServicio, cantidad) values (1, 1, 1);

-- Crea orden de servicio 2
insert into ordenServicio(fechaOrdenServicio, placa, kmActual, idEstadoOrden) values ('2024-02-06', 'P-128MHB', 80000, 1);
-- Crea detalle de orden 2. Las dos filas pertenecen a la orden de servicio 2
insert into detalleOrden(idOrdenServicio, idServicio, cantidad) values (2, 1, 1);
insert into detalleOrden(idOrdenServicio, idServicio, cantidad) values (2, 4, 1);

-- CREA ORDEN DE SERVICIO 3
insert into ordenServicio(fechaOrdenServicio, placa, kmActual, idEstadoOrden) values ('2024-02-08', 'P-120RAM', 30000, 1);
-- Crea detalle de orden 3. Las filas pertenecen a la orden de servicio 3
insert into detalleOrden(idOrdenServicio, idServicio, cantidad) values (3, 1, 1); 
insert into detalleOrden(idOrdenServicio, idServicio, cantidad) values (3, 4, 1); 
insert into detalleOrden(idOrdenServicio, idServicio, cantidad) values (3, 6, 1); 
insert into detalleOrden(idOrdenServicio, idServicio, cantidad) values (3, 7, 1);

-- CREA ORDEN DE SERVICIO 4
insert into ordenServicio(fechaOrdenServicio, placa, kmActual, idEstadoOrden) values ('2024-02-20', 'P-175ALG', 30000, 1);
-- Crea detalle de orden 4. Las fila pertenecen a la orden de servicio 4
insert into detalleOrden(idOrdenServicio, idServicio, cantidad) values (4, 1, 1); 

-- CREA ORDEN DE SERVICIO 5
insert into ordenServicio(fechaOrdenServicio, placa, kmActual, idEstadoOrden) values ('2024-03-05', 'P-240ABC', 26000, 1);
-- Crea detalle de orden 5. La fila pertenecen a la orden de servicio 5
insert into detalleOrden(idOrdenServicio, idServicio, cantidad) values (5, 1, 1); 

-- CREA ORDEN DE SERVICIO 6
insert into ordenServicio(fechaOrdenServicio, placa, kmActual, idEstadoOrden) values ('2024-02-14', 'P-741XYZ', 26000, 1);
-- Crea detalle de orden 6. Las filas pertenecen a la orden de servicio 6
insert into detalleOrden(idOrdenServicio, idServicio, cantidad) values (6, 1, 1); 
insert into detalleOrden(idOrdenServicio, idServicio, cantidad) values (6, 4, 1); 
insert into detalleOrden(idOrdenServicio, idServicio, cantidad) values (6, 7, 1); 
insert into detalleOrden(idOrdenServicio, idServicio, cantidad) values (6, 3, 1); 
insert into detalleOrden(idOrdenServicio, idServicio, cantidad) values (6, 6, 1); 

-- CREA ORDEN DE SERVICIO 7
insert into ordenServicio(fechaOrdenServicio, placa, kmActual, idEstadoOrden) values ('2024-02-20', 'P-852GDC', 29500, 1);
-- Crea detalle de orden 7. Las filas pertenecen a la orden de servicio 7
insert into detalleOrden(idOrdenServicio, idServicio, cantidad) values (7, 7, 1); 
insert into detalleOrden(idOrdenServicio, idServicio, cantidad) values (7, 10, 1);

-- CREA ORDEN DE SERVICIO 8
insert into ordenServicio(fechaOrdenServicio, placa, kmActual, idEstadoOrden) values ('2024-02-21', 'P-963JKL', 29300, 1);
-- Crea detalle de orden 8. La fila pertenecen a la orden de servicio 8
insert into detalleOrden(idOrdenServicio, idServicio, cantidad) values (8, 1, 1); 

-- CREA ORDEN DE SERVICIO 9
insert into ordenServicio(fechaOrdenServicio, placa, kmActual, idEstadoOrden) values ('2024-03-06', 'P-128MHB', 29600, 1);
-- Crea detalle de orden 9. Las filas pertenecen a la orden de servicio 9
insert into detalleOrden(idOrdenServicio, idServicio, cantidad) values (9, 1, 1);
insert into detalleOrden(idOrdenServicio, idServicio, cantidad) values (9, 4, 1);
insert into detalleOrden(idOrdenServicio, idServicio, cantidad) values (9, 10, 1); 

-- CREA ORDEN DE SERVICIO 10
insert into ordenServicio(fechaOrdenServicio, placa, kmActual, idEstadoOrden) values ('2024-03-03', 'P-852GDC', 23000, 1);
-- Crea detalle de orden 10. La fila pertenecen a la orden de servicio 10
insert into detalleOrden(idOrdenServicio, idServicio, cantidad) values (10, 10, 1); 

-- CREA ORDEN DE SERVICIO 11
insert into ordenServicio(fechaOrdenServicio, placa, kmActual, idEstadoOrden) values ('2024-04-07', 'P-175ALG', 24000, 1);
-- Crea detalle de orden 11. Las filas pertenecen a la orden de servicio 11
insert into detalleOrden(idOrdenServicio, idServicio, cantidad) values (11, 1, 1);
insert into detalleOrden(idOrdenServicio, idServicio, cantidad) values (11, 7, 1);


/* Información: Cuando se crea una orden de servicio se debe mostrar un catalogo de precios de servicios
para los diferentes modelos y sus tamaños de motor, con el precio de la fecha vigente.
Ver el archivo de Consultas.sql
*/