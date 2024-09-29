#!/bin/bash

fecha=$(date +%d%m%Y_%H%M%S)
nombreBD="agencia_servicios"
directorio="$HOME/mysql_backups/$nombreBD"

salida="$directorio/backup_$fecha.sql"

if [ ! -d $directorio ]; then

	if ! mkdir -p "$directorio"; then
		echo "Error al crear el directorio: $directorio"
            	exit 1
	fi
fi

mysqldump -u root -p --databases --routines $nombreBD > $salida || { echo "Error al crear el backup"; exit 1; }
echo "Backup creado en $salida"
