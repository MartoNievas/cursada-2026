# Intro a Sistemas Operativos

**Sistemas Operativos — FCEyN, Universidad de Buenos Aires**

---

## 1. ¿Qué es un Sistema Operativo?

El **Sistema Operativo (SO)** es una capa de software que se encarga de comunicar el software específico del usuario con los detalles de bajo nivel del **hardware**. Sin un SO, cada programa debería conocer y manejar directamente los detalles particulares de cada dispositivo (discos, memoria, placas de red, etc.), algo inviable en la práctica: cada fabricante tiene su propia forma de comunicarse con sus dispositivos.

El SO cumple, en términos generales, dos funciones centrales:

- **Abstracción:** oculta la complejidad del hardware detrás de interfaces simples y uniformes (por ejemplo, archivos en vez de sectores de disco crudos).
- **Gestión de recursos:** administra el uso compartido de CPU, memoria, disco y dispositivos entre múltiples procesos, evitando conflictos entre ellos.

Ejemplos de sistemas operativos: Linux, Windows, macOS, y sus variantes para dispositivos móviles (Android, iOS) o sistemas embebidos.

> **Nota:** El SO no es el único software que puede correr con privilegios especiales, pero es el que administra el acceso a todo el hardware en nombre de los demás programas.

---

## 2. Componentes de un SO

### 2.1 Drivers

Los **drivers** son programas que forman parte del sistema operativo y manejan los detalles de comunicación con los distintos dispositivos, resolviendo los detalles de bajo nivel específicos de cada uno. Le presentan al resto del SO una interfaz uniforme, de modo que el kernel no necesite conocer las particularidades de cada fabricante o modelo de dispositivo.

### 2.2 Kernel

El **kernel** es el SO propiamente dicho: la parte central que se encarga de las tareas fundamentales y contiene los diversos subsistemas (gestión de procesos, memoria, archivos, dispositivos, red, etc.). Es el único componente que corre con privilegios totales sobre el hardware; el resto de las herramientas del sistema (shells, utilidades, bibliotecas) son programas que corren sobre él.

### 2.3 Shell

La **shell** es un programa de usuario más — no forma parte del kernel — que facilita al usuario interactuar con el SO. Interpreta los comandos que recibe (por línea de comandos, como `bash` o `zsh`, o mediante una interfaz gráfica) y los traduce en la ejecución de otros programas o en pedidos al kernel.

### 2.4 Proceso

Un **proceso** es un programa en ejecución, junto con su espacio de memoria asociado y otros atributos (identificador, estado, prioridad, etc.). El estudio detallado de los procesos y la API del SO para manejarlos se aborda en `teo1-procesos.md`.

### 2.5 Archivo

Un **archivo** es una secuencia de bits con un nombre y una serie de atributos que indican permisos, dueño, fecha de modificación, tamaño, etc. Es la unidad básica que el SO expone para el almacenamiento persistente de datos.

### 2.6 Directorio

Un **directorio** es una colección de archivos y directorios que tiene un nombre y se organiza jerárquicamente, formando el árbol de directorios de un sistema de archivos.

### 2.7 Dispositivo Virtual

Un **dispositivo virtual** es la abstracción de un dispositivo físico bajo la forma de un archivo. En los sistemas tipo UNIX esta idea se lleva al extremo con la filosofía de que "todo es un archivo": se puede leer y escribir un dispositivo con las mismas operaciones (`read`, `write`) que se usan sobre un archivo común, sin necesidad de una API distinta por cada tipo de dispositivo. Ejemplos en Linux: `/dev/null`, `/dev/zero`, `/dev/sda`.

### 2.8 Sistema de Archivos

El **sistema de archivos** es la forma de organizar los datos en el disco para gestionar su acceso, permisos, ubicación física y demás metadatos. Ejemplos: `ext4`, `NTFS`, `APFS`, `FAT32`.

### 2.9 Directorios, Binarios y Archivos de Configuración del Sistema

Los sistemas tipo UNIX organizan su instalación siguiendo una jerarquía estándar de directorios, donde conviven:

- **Directorios del sistema:** ubicaciones fijas que agrupan contenido según su función.
- **Binarios del sistema:** los ejecutables de los programas y utilidades que forman parte del propio SO.
- **Archivos de configuración:** archivos de texto plano que definen el comportamiento de servicios y programas.

| Directorio | Contenido típico |
|---|---|
| `/bin`, `/usr/bin` | Binarios de uso general |
| `/sbin` | Binarios de administración del sistema |
| `/etc` | Archivos de configuración |
| `/home` | Directorios personales de los usuarios |
| `/var` | Datos variables (logs, colas, cachés) |
| `/dev` | Dispositivos virtuales |
| `/proc`, `/sys` | Información del kernel y de los procesos en ejecución |

### 2.10 Usuario

Un **usuario** es la representación dentro del SO de las personas o entidades que pueden usarlo. Sirve para aislar información entre sí y para establecer limitaciones: qué archivos puede leer o escribir, qué procesos puede controlar, qué recursos puede consumir.

### 2.11 Grupos

Un **grupo** es una colección de usuarios. Permite otorgar permisos a varios usuarios a la vez sin necesidad de asignarlos individualmente a cada uno; un usuario puede pertenecer a uno o más grupos.

---

## 3. Modo Usuario vs. Modo Kernel

Para proteger la integridad del sistema, la CPU distingue —a nivel de hardware— al menos dos niveles de privilegio de ejecución:

- **Modo kernel (o modo privilegiado):** el código puede ejecutar cualquier instrucción, incluyendo el acceso directo al hardware. Es el modo en que corre el kernel del SO.
- **Modo usuario:** el código tiene acceso restringido; no puede ejecutar instrucciones privilegiadas ni acceder directamente al hardware. Es el modo en que corren los programas de usuario, incluida la shell.

Cuando un proceso en modo usuario necesita un servicio del kernel (leer un archivo, crear un proceso, etc.), debe pedirlo mediante una **system call**, lo cual provoca un cambio controlado a modo kernel. Este mecanismo evita que un programa de usuario pueda dañar el sistema o interferir con otros procesos.

> Este tema se profundiza en `teo1-procesos.md`, sección de System Calls.

---

## Resumen

| Concepto | Descripción |
|----------|-------------|
| **Sistema Operativo** | Capa de software que comunica el software de usuario con el hardware, abstrayendo su complejidad y gestionando recursos compartidos |
| **Driver** | Programa del SO que maneja los detalles de comunicación con un dispositivo específico |
| **Kernel** | Núcleo del SO; parte central con privilegios totales que contiene sus subsistemas fundamentales |
| **Shell** | Programa de usuario que permite interactuar con el SO mediante comandos |
| **Proceso** | Programa en ejecución más su espacio de memoria y atributos asociados |
| **Archivo** | Secuencia de bits con nombre y atributos (permisos, dueño, etc.) |
| **Directorio** | Colección jerárquica de archivos y directorios |
| **Dispositivo Virtual** | Abstracción de un dispositivo físico bajo la forma de un archivo |
| **Sistema de Archivos** | Forma de organizar los datos en disco para gestionar acceso y permisos |
| **Usuario** | Representación de una persona/entidad dentro del SO; aísla información y limita acciones |
| **Grupo** | Colección de usuarios, usada para otorgar permisos en conjunto |
| **Modo Kernel** | Nivel de privilegio de la CPU que permite ejecutar cualquier instrucción y acceder al hardware |
| **Modo Usuario** | Nivel de privilegio restringido en el que corren los programas de usuario |
| **System Call** | Mecanismo mediante el cual un proceso en modo usuario solicita un servicio al kernel |
