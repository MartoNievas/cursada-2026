# Guía de Bash Scripting y Makefile


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
