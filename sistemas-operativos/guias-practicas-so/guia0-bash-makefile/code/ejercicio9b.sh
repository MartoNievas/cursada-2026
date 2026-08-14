#!/bin/bash

set -e


read -p "Ingrese un numero: " NUMERO1

read -p "Ingrese otro numero: " NUMERO2


if [[ ! "$NUMERO1" =~ ^-?[0-9]+$ || ! "$NUMERO2" =~ ^-?[0-9]+$ ]]; then
	echo "Las entradas no son valores numericos validos"
	exit 1
fi

SUMA=$((NUMERO1 + NUMERO2))
PRODUCTO=$((NUMERO1 * NUMERO2))

echo "La suma es: $SUMA"
echo "El producto es: $PRODUCTO"

if [[ "$SUMA" -eq "$PRODUCTO" ]]; then
	echo "la suma y el prodcuto son iguales"
fi


if [[ "$SUMA" -lt "$PRODUCTO" ]]; then
	echo "La suma en menor que el producto"
else
	echo "La suma es mayor que el producto"
fi
