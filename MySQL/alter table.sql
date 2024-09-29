/* Ejemplos como utilizar ALTER para agregar o quitar restricciones (constraints),
   Suponiendo que no están definidas en las tablas creadas.
   También para agregar o quitar indices o columnas de cualquier tipo de dato.
   
   Restricciones: NOT NULL, UNIQUE, PRIMARY KEY, FOREIGN KEY, CHECK, DEFAULT

   Para estos ejemplos se utiliza la declaración ALTER con las siguientes opciones

   1. modify: Para modificar una columna existente
   2. add: Para agregar una columna, indice o restricción
   3. drop: Para eliminar una columna, indice o restricción
*/

-- NOT NULL
-- 01. Agregar restricción NOT NULL a una columna existente
alter table estado modify nombreEstado varchar(40) NOT NULL;
-- 02. Agregar restricción NULL a una columna existente (quitar NOT NULL)
alter table estado modify nombreEstado varchar(40) NULL;
-- 03. Agregar a una tabla una columna con restricción NOT NULL
alter table estado add nombreEstado varchar(40) NOT NULL;

-- UNIQUE
-- 01. Agregar restricción UNIQUE a una columna existente. Esto crea un indice con nombre estado.
alter table estado add UNIQUE (nombreEstado);
-- 02. Quitar restricción UNIQUE a una columna, se debe eliminar el indice de la restricción
alter table estado drop index nombreEstado;
-- 03. Agregar a una tabla una columna con restricción UNIQUE
alter table estado add nombreEstado varchar(40) UNIQUE;

-- PRIMARY KEY
-- 01. Agregar restricción PRIMARY KEY a una columna existente. Esto crea un indice con nombre PRIMARY
alter table estado add PRIMARY KEY(idEstado).
/* 02. Quitar restricción PRIMARY KEY de una columna.
    Para quitar esta restricción la columna no debe ser auto_increment,
    primero se debe quitar auto_increment de la columna, utilizando modify */
alter table estado modify idEstado int not null;
alter table estado drop PRIMARY KEY;
-- 03. Agregar a una tabla una columna con restricción PRIMARY KEY
alter table estado add idEstado int not null auto_increment PRIMARY KEY first;

-- FOREIGN KEY
-- 01. Agregar restricción FOREIGN KEY a una columna existente llamada idEstado
alter table empleado add constraint fk_empleado_idestado FOREIGN KEY(idEstado) references estado(idEstado) on delete cascade on update cascade;
-- 02. Quitar la restricción FOREIGN KEY a una columna, se utiliza el nombre asignado a la restricción
alter table empleado drop FOREIGN KEY fk_empleado_idestado;
-- Cuando se elimina una restricción foreign key se debe eliminar por separado el indice de esa restricción
alter table empleado drop index fk_empleado_idestado;

-- CHECK
-- 01. Agregar restricción CHECK  a una columna existente
alter table empleado add CONSTRAINT mayor_edad check(edad > 18);
-- 02. Quitar restricción CHECK. Se utiliza el nombre dado a la restricción
alter table empleado drop CONSTRAINT mayor_edad;
-- 03. Agregar a una tabla una columna con restricción CHECK
alter table empleado add edad int check(edad > 18);
alter table empleado add edad int constraint mayor_edad check(edad > 18);


-- DEFAULT
-- 01. Agregar restricción DEFAULT a columna existente. Utilizando modify
alter table empleado modify createdAt timestamp default current_timestamp;
-- 02. Eliminar restricción default current_timestamp. Utilizando modify y alter
alter table empleado modify createdAt timestamp default NULL;
alter table empleado alter createdAt SET DEFAULT (null);



