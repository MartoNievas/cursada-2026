#!/bin/bash

set -e

#Definimos los 3 arrays

arr1=()
arr2=()
arr3=()


FILE="tabla.csv"

es_encabezado=true

while IFS=',' read -r col1 col2 col3; do
	
	#Guardamos el dato en su respestivos arr
	arr1+=("$col1")
	arr2+=("$col2")
	arr3+=("$col3")

	if [ "$es_encabezado" = true ]; then
		array_diff+=("Diferencia")
		es_encabezado=false


	else
		dif=$((col2 - col3))
		array_diff+=("$dif")
	fi

done < "$FILE"


echo "Array columna 1: ${arr1[@]}"
echo "Array columna 2: ${arr2[@]}"
echo "Array columna 3: ${arr3[@]}"
echo "Array Difrencia: ${array_diff[@]}"

NUEVO_ARCHIVO="tabla_nueva.csv"

> "$NUEVO_ARCHIVO"

for (( i=0; i<${#arr1[@]}; i++  )); do
	echo "${arr1[$i]},${arr2[$i]},${arr3[$i]},${array_diff[$i]}" >> "$NUEVO_ARCHIVO"

done

echo "Nueva tabla creada con la columna diferencia en $NUEVO_ARCHIVO"
