#!/bin/bash

# Lee la variable GITHUB_USER
GITHUB_USER=$1

# Consulta la URL de GitHub para obtener datos del usuario
USER_DATA=$(curl -s https://api.github.com/users/$GITHUB_USER)

# Extrae los datos necesarios del JSON
USER_ID=$(echo $USER_DATA | jq -r '.id')
CREATED_AT=$(echo $USER_DATA | jq -r '.created_at')

# Imprime el mensaje
echo "Hola $GITHUB_USER. User ID: $USER_ID. Cuenta fue creada el: $CREATED_AT."

# Crea el directorio de log con la fecha actual
DATE=$(date +%Y-%m-%d)
LOG_DIR="/tmp/$DATE"
mkdir -p $LOG_DIR

# Escribe el log en el archivo saludos.log
echo "Hola $GITHUB_USER. User ID: $USER_ID. Cuenta fue creada el: $CREATED_AT." >> $LOG_DIR/saludos.log

