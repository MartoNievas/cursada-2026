# Guia de Bash Scripting y Makefile

## Respuestas

## Ejercicio 1 — Comandos Básicos de Linux

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

- **PID** — identificador del proceso.
- **Estado** — estado actual del proceso (running, sleeping, etc.).
- **%CPU / %MEM** — consumo de CPU y memoria.
- **TIME+** — tiempo acumulado de CPU.
- **COMMAND** — nombre del proceso o comando.

Opción `-n <iteraciones>`

```bash
$ top -n 10
```

Indica a `top` cuántas **iteraciones de refresco** debe realizar antes de finalizar. En este caso, el programa actualizará la pantalla 10 veces y luego terminará automáticamente, en lugar de quedarse ejecutándose de forma indefinida.

## Ejercicio 2 - Archivos y Directorios

### b) ls 


i. Lo que se obtiene al ejecutar **ls /** son todos los directorios y archivos del root.

ii. Se puede ver usando el comando **ls -l** por ejemplo.

iii. 
  | Opcion | Descripcion |
  | -------------- | --------------- |
  | **-a** | Lo que hace es no ignorar entradas que comienzen con . |
  | **-d** | Imprime solo el directorio, pero no su contenido |
  | **-h** | Imprime los tamanios legibles para humanos, como 1KB, 234MB,etc. |
  |**-l** | Imprime en un formato de lista longitudinal |
  | **-S**| Ordena de manera decreciente por size |
  |**-t**  | Ordena por fecha de creacion/modificacion el mas nuevo primero |
  | **-r**|Invierte el criterio de orden|
  


## Ejercicio 8 Creacion y Ejecucion


