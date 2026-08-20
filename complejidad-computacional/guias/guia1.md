# Práctica 1: Introducción a máquinas de Turing

## Ordenes

### Ejercicio 1

a) $f(n) \space = \space f(n - 1) \space + 10$

Vamos a analizar la formula recursiva:

$$
f(n) \space = \space f(n-1) + 10 \\
f(n-1) \space = \space f(n-2) \space + \space 10 \\
f(n-2) \space = \space f(n-3) \space + \space 10 \\
\dots \\
f(0) = 0
$$

Haciendo las sustituciones en la formula original nos queda:

$$
f(n) \space = \space f(n-1) + 10 \\
= f(n-2) \space + 2 \cdot 10 \\
= f(n-3) \space + 3 \cdot 10 \\
... \\
= f(n - k) \space + k \cdot 10 
$$

Luego si tomamos $k = n$ nos queda que 

$$
f(n) \space = 10 \cdot n 
$$

Entonces $f(n) \space = \space \theta(n)$

b) $f(n) \space = \space f(n-1) \space + \space n$

Utilizamos el mismo procedimiento que en el ejercicio anterior y nos queda:

$$
f(n-1) \space = \space f(n-2) + (n-1) \\
f(n-2) \space = \space f(n-3) + (n-2) \\
f(n-3) \space = \space f(n-4) + (n-3) \\
\dots \\
f(0) = 0
$$

Sustituyendo llegamos a la formula

$$
f(n) \space = \space f(n-k) \space + \space k \cdot n
$$

Tomando $k = n$ nos queda:

$$
f(n) \space = \space f(0) \space + n^2 \\
f(n) \space = \space n^2
$$

Por lo tanto $f(n) \space = \space \theta(n^2)$

c) $f(n) \space = \space 2 \cdot f(n-1)$

Veamos que pasa con $f(2)$

$$
f(2) \space = \space 2\cdot f(2 - 1) \\
f(2) \space = \space 2 \cdot f(0) \\
f(2) \space = \space 2 \cdot 0 = 0
$$

Si notamos ahora probamos con otro valor $n = 3$

$$
f(3) = 2 \cdot f(2)
$$


Analizando la funcion 

## Módelos de cómputo