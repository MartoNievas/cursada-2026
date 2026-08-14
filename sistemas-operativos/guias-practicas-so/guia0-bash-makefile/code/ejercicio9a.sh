#!/bin/bash

# Detiene el script si hay algun error
set -e

echo "Es usted mayor de edad? [si/no]"

read -p "Ingrese respuesta: " RESPUESTA

if [[ "$RESPUESTA" == "si" ]]; then
	echo "Puede pasar es mayor de edad"
else
	echo "No puede pasar es menor de edad"
fi
