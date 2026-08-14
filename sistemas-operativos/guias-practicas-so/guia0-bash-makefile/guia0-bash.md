# Práctica 0: Bash Scripting y Makefile

**Sistemas Operativos — FCEyN, Universidad de Buenos Aires**

---

> Enunciado: [PDF](p0.pdf)

---

## Parte 1 — Terminal de Linux | Bash Scripting

---

## Ejercicio 1 — Comandos de Información

### a) `whoami`

Imprime el nombre del usuario asociado al **user ID (UID)** actual. Es útil para verificar con qué identidad se está ejecutando una sesión o un script.

```bash
$ whoami
martin
```

---

### b) `uname`

Muestra información sobre el sistema operativo y el kernel.

- **`uname`** — imprime únicamente el nombre del sistema operativo.
- **`uname -a`** — imprime información completa: nombre del sistema operativo, hostname, versión del kernel, arquitectura y más.

```bash
$ uname
Linux

$ uname -a
Linux hostname 6.1.0-arch1 #1 SMP PREEMPT x86_64 GNU/Linux
```

---

### c) `id`

Muestra los **IDs de usuario y grupo**, tanto reales como efectivos, de la sesión actual. Es útil para verificar permisos y membresía en grupos del sistema.

```bash
$ id
uid=1000(martin) gid=1000(martin) grupos=1000(martin),983(video),998(wheel)
```

---

### d) `ps`

Reporta un **snapshot** (instantánea) de los procesos en ejecución al momento de ejecutarse el comando.

- **`ps`** — muestra únicamente los procesos asociados a la **TTY** (terminal) actual.
- **`ps -e`** — muestra **todos** los procesos del sistema, usando sintaxis estándar.

```bash
$ ps
    PID TTY          TIME CMD
  18754 pts/0    00:00:00 bash
  23258 pts/0    00:00:00 ps

$ ps -e
    PID TTY          TIME CMD
      1 ?        00:00:02 systemd
      2 ?        00:00:00 kthreadd
    ...
```

---

### e) `top`

Muestra un **dashboard interactivo** y en tiempo real de los procesos del sistema. Cada entrada incluye:

| Campo           | Descripción                                        |
| --------------- | -------------------------------------------------- |
| **PID**         | Identificador del proceso.                         |
| **Estado**      | Estado actual del proceso (running, sleeping...).  |
| **%CPU / %MEM** | Consumo de CPU y memoria.                          |
| **TIME+**       | Tiempo acumulado de CPU.                           |
| **COMMAND**     | Nombre del proceso o comando.                      |

**Opción `-n <iteraciones>`**

```bash
$ top -n 10
```

Indica a `top` cuántas **iteraciones de refresco** debe realizar antes de finalizar. En este caso, el programa actualizará la pantalla 10 veces y luego terminará automáticamente, en lugar de quedarse ejecutándose de forma indefinida.

---

## Ejercicio 2 — Archivos y Directorios

### b) `ls`

**i.** Al ejecutar `ls /` se listan todos los directorios y archivos del directorio raíz (*root*).

**ii.** El contenido del directorio `/bin` se puede ver con `ls /bin` o con `ls -l /bin` para más detalle.

**iii.** Tabla de opciones principales:

| Opción | Descripción                                                          |
| ------ | -------------------------------------------------------------------- |
| `-a`   | No ignora las entradas que comienzan con `.` (archivos ocultos).     |
| `-d`   | Imprime solo el directorio en sí, sin listar su contenido.           |
| `-h`   | Muestra los tamaños en formato legible (p. ej. `1K`, `234M`).        |
| `-l`   | Formato de lista larga con permisos, propietario, tamaño y fecha.    |
| `-S`   | Ordena de forma decreciente por tamaño.                              |
| `-t`   | Ordena por fecha de modificación, el más reciente primero.           |
| `-r`   | Invierte el criterio de orden actual.                                |

**iv.** `ls -la /etc` muestra todos los archivos del directorio `/etc` (incluyendo ocultos) en formato de lista larga, con permisos, propietario, tamaño y fecha de modificación de cada entrada.

---

## Ejercicio 3 — Creando Archivos y Directorios

### a) Creando un directorio

Creo un directorio scripts con:

```bash
$ mkdir scripts
```

---

### b) Cambiando de directorio

Para cambiar al directorio scripts utilizo:

```bash
$ cd scripts
```

Y con `pwd` verifico que me encuentro en el directorio deseado.

---

### c) Creando un archivo

Con el siguiente comando creo un txt con:

```bash
$ touch miarchivo.txt
```

---

## Ejercicio 4 — Manejo de Archivos y Directorios

### a) Buscando un archivo con el comando find

Lo que hace el comando es buscar en el árbol de directorios a partir del directorio dado, por ejemplo:

```bash
$ find /etc -name "*.txt"
```

Lo que hace exactamente este comando es buscar a partir de `/etc` todos los .txt del árbol.

---

### b) Borrando un archivo

Vamos a borrar el archivo creado con:

```bash
$ rm -i miarchivo.txt
```

Y con `ls` confirmo que se borró.

---

### c) Borrando un directorio

Un directorio se borra utilizando la flag `-r` de recursive:

```bash
$ rm -r scripts
```

También existe el comando `rmdir` el cual solo elimina directorios vacíos sin necesidad de utilizar una flag especial.

---

### d) Renombrando archivos y directorios

Se puede renombrar un archivo de la siguiente manera:

```bash
$ mv usuarios.txt info-user.txt
```

O mover un archivo así:

```bash
$ mv info-user.txt /tmp
```

También vale con directorios el `mv` sin requerir una flag especial.

---

### e) Copiando un archivo

Utilizando `cp` podemos copiar archivos:

```bash
$ cp /tmp/info-user.txt info-user-cp.txt
```

Con la flag `-r` puedes copiar todo el contenido del directorio:

```bash
$ cp -r scripts cp-scripts
```

---

## Ejercicio 5 — Ver y Modificar Permisos de Acceso

No hay como tal un ejercicio, es seguir una serie de pasos; lo que sí, para ver permisos se puede usar el siguiente comando:

```bash
$ ls -l miarchivo.txt
```

La flag `-l` significa long y da una descripción detallada del archivo del directorio.

---

## Ejercicio 6 — Archivos de Texto: Ver Contenido

Lo mismo que con el ejercicio anterior, con el comando `cat` puedes visualizar el contenido de un archivo de texto, ya sea un documento txt, código, etc.

Hay otros comandos como `less`, `more` o `tail`, este último solo imprime las 10 primeras líneas.

---

## Ejercicio 7 — Archivos de Texto: Extraer Líneas y Campos

Para buscar texto podemos utilizar el comando grep:

```bash
$ grep universidad archivo_misterioso.txt
```

E imprime la/s palabra que matcheó en color rojo. El comando grep tiene varias flags, estas son las más importantes.

<div align="center">

| Opción | Descripción |
| :---: | :---: |
| -n | Además de imprimir la línea donde matcheó con el patrón, también indica el número de línea donde se encontró el match. |
| -c | Con esta flag devuelve el número de líneas que matchearon con el patrón dado. |
| -i | Ignora casos distintivos, por ejemplo ignora mayúsculas y minúsculas. |
| -v | Invierte el sentido del matcheo y solo muestra por pantalla aquellas líneas que no matchearon y sin resaltar. |
| -w | Selecciona solo aquellas líneas cuya palabra matchea por completo con la que se pasa por parámetro. |

</div>

---

## Ejercicio 8 — Creación y Ejecución de un Bash Script

> Código fuente: [`code/saludar.sh`](code/saludar.sh)

El script solicita al usuario que ingrese su nombre y lo saluda por pantalla.

Para ejecutarlo directamente con bash:
```bash
$ bash saludar.sh
```

Para hacerlo ejecutable como comando, primero se agrega el shebang al inicio del archivo:
```bash
#!/bin/bash
```

Luego se otorgan permisos de ejecución y se corre:
```bash
$ chmod +x saludar.sh
$ ./saludar.sh
```

---

## Ejercicio 9 — Más sobre Shell Scripting

### a) Sintaxis de condicionales

> Código fuente: [`code/ejercicio9a.sh`](code/ejercicio9a.sh)

Script que pregunta si el usuario es mayor de edad y, según la respuesta (`si`/`no`), imprime si puede pasar o no.

```bash
$ ./ejercicio9a.sh
Es usted mayor de edad? [si/no]
Ingrese respuesta: si
Puede pasar es mayor de edad
```

---

### b) Operadores lógicos de bash

> Código fuente: [`code/ejercicio9b.sh`](code/ejercicio9b.sh)

Script que pide dos números, valida con una expresión regular que ambos sean valores numéricos, calcula su suma y producto, y compara ambos resultados.

```bash
$ ./ejercicio9b.sh
Ingrese un numero: 3
Ingrese otro numero: 4
La suma es: 7
El producto es: 12
La suma en menor que el producto
```

---

### c) Arrays en bash

> Código fuente: [`code/ejercicio9c.sh`](code/ejercicio9c.sh)

Script que lee un archivo CSV (`code/tabla.csv`) columna por columna guardando cada una en un array, calcula la diferencia entre la columna de ingreso y la de gasto, y genera un nuevo CSV (`tabla_nueva.csv`) con esa columna de diferencia agregada.

```bash
$ ./ejercicio9c.sh
Array columna 1: Producto Laptop Teclado Monitor Mouse Auriculares
Array columna 2: Ingreso 1200 150 300 80 200
Array columna 3: Gasto 800 50 210 30 120
Array Difrencia: Diferencia 400 100 90 50 80
Nueva tabla creada con la columna diferencia en tabla_nueva.csv
```

---

## Parte 2 — Programación en C | Makefile

---

## Ejercicio 10 — Word Inverter

> Código fuente: [`code/wordInverter.c`](code/wordInverter.c)

Programa que recibe dos argumentos: un número entero `N` y una cadena de texto. Si el tamaño de una palabra es mayor a `N`, la invierte y la pasa a mayúsculas.

```bash
$ ./wordInverter 4 "Hola, me gustaria introducirme al mundo!"
Hola, me AIRATSUG EMRICUDORTNI al ODNUM
```

---

## Ejercicio 11 — Verificador de CUIT

> Código fuente: [`code/verificadorCuit.c`](code/verificadorCuit.c)

Programa que toma un número de CUIT por entrada estándar, valida el dígito verificador y, si es inválido, muestra la versión corregida.

```bash
$ ./verificadorCuit 33693450239
El CUIT ingresado es válido

$ ./verificadorCuit 30576124272
El CUIT ingresado no es válido. Su información corregida es 30-57612427-5
```

**Algoritmo del dígito verificador:** cada uno de los 10 primeros dígitos se multiplica por `5, 4, 3, 2, 7, 6, 5, 4, 3, 2` respectivamente. Se suman los productos, se divide por 11 tomando la parte entera, y se le restan 11 para obtener el dígito verificador.

---

## Ejercicio 12 — Plataforma de Carga de Usuarios (un usuario)

> Código fuente: [`code/ej12.c`](code/ej12.c)

Programa que acepta comandos por entrada estándar para gestionar la información de **un único usuario**. Valida que la edad esté entre 18 y 99, y que el CUIT sea válido.

Comandos disponibles:
- `agregarInformacionUsuario` — solicita nombre, edad y CUIT, y los almacena.
- `verInformacionUsuario` — imprime la información cargada, o un mensaje si no hay ninguna.

---

## Ejercicio 13 — Plataforma de Carga de Usuarios (múltiples usuarios)

> Código fuente: [`code/ej13.c`](code/ej13.c)

Extensión del ejercicio anterior para soportar **múltiples usuarios** usando `realloc`. El comando `verInformacionUsuario` ahora imprime todos los usuarios cargados.

---

## Ejercicio 14 — Búsqueda por CUIT

Extensión del ejercicio anterior con el nuevo comando `buscarInformacionUsuario`: dado un CUIT, busca y muestra la información del usuario correspondiente, o informa que no existe.

---

## Ejercicio 15 — Estructura de Archivos y Makefile

> Código fuente: [`code/ej15/`](code/ej15/)

Reorganización de los ejercicios anteriores en múltiples archivos, compilados con `make`.

| Archivo | Descripción |
| ------- | ----------- |
| [`main.c`](code/ej15/main.c) | Punto de entrada: toma el input del usuario y despacha comandos. |
| [`utils.c`](code/ej15/utils.c) / [`utils.h`](code/ej15/utils.h) | Funciones compartidas (validación de CUIT, etc.). |
| [`agregarInfo.c`](code/ej15/agregarInfo.c) | Implementación del comando `agregarInformacionUsuario`. |
| [`buscarInfo.c`](code/ej15/buscarInfo.c) | Implementación del comando `buscarInformacionUsuario`. |
| [`verInfo.c`](code/ej15/verInfo.c) | Implementación del comando `verInformacionUsuario`. |
| [`makefile`](code/ej15/makefile) | Reglas de compilación del proyecto. Soporta `make` y `make clean`. |

Para compilar y limpiar:
```bash
$ make
$ make clean
```
