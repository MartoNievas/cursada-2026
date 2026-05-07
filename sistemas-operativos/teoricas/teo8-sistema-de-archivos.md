# Sistema de Archivos

## ¿Qué es el proceso de booteo?

El proceso de booteo o arranque es la secuencia de eventos que inicia un sistema operativo desde que se enciende el hardware hasta que el sistema está listo para su uso. Las etapas son las siguientes:

1. **BIOS/UEFI:** inicializa el hardware básico.
2. **Cargador de arranque** (ej. GRUB): selecciona y carga el kernel.
3. **Init/Systemd:** arranca los servicios del sistema.
4. **Login:** el usuario puede iniciar sesión.

---

## Archivos y Sistema de Archivos

### ¿Qué es un archivo?

Un archivo es una colección con nombre de información relacionada que se registra en el almacenamiento secundario. Para nosotros —y para los sistemas operativos como Unix— los archivos no tienen estructura interna predefinida; para darles una, se puede incluir una extensión que indique su contenido:

- `archivo.txt` — archivo con contenido de texto.
- `archivo.tex` — archivo con código fuente de LaTeX.
- `archivo.c` — archivo con código fuente en C.

Además de almacenar información, los archivos son de propósito tan general que su uso se ha extendido más allá de sus límites originales. Por ejemplo, Unix, Linux y algunos otros sistemas operativos proporcionan un sistema de archivos **proc** que utiliza interfaces de sistema de archivos para brindar acceso a información del sistema en tiempo real.

---

### El sistema de archivos (File System)

Para administrar los archivos, el kernel incluye un módulo encargado de organizar la información en disco: el **sistema de archivos** o *file system*.

Algunos sistemas operativos soportan solo uno (por ejemplo, DOS solo soporta FAT), mientras que otros admiten varios (Windows soporta FAT, FAT32, NTFS, entre otros). En los Unix modernos, el soporte suele venir incluido para varios sistemas de archivos y, mediante módulos dinámicos de kernel, puede extenderse a casi cualquiera.

#### Responsabilidades del File System

Una de las responsabilidades más elementales es definir cómo se organizan lógicamente los archivos:

- **Organización interna:** cómo se estructura la información *dentro* de un archivo. Tanto Windows como Unix usan secuencias de bytes, dejando la responsabilidad de la estructura al usuario o la aplicación.
- **Organización externa:** cómo se ordenan los archivos entre sí. Hoy en día todos los sistemas de archivos soportan el concepto de **directorios**, lo que da lugar a una organización jerárquica con forma de árbol.

La mayoría también soporta la noción de **link**: un alias o nombre alternativo que apunta al mismo archivo. En Linux, se crean con el comando `ln`.

#### Nomenclatura de archivos

El sistema de archivos también determina las reglas para nombrar archivos, incluyendo:

- Caracteres de separación de directorio (`/` en Unix, `\` en Windows).
- Si los archivos tienen o no extensión.
- Restricciones de longitud y caracteres permitidos.
- Distinción o no entre mayúsculas y minúsculas (*case sensitivity*).
- Si el nombre está o no prefijado por el equipo donde se encuentra.
- Punto de montaje.

#### Aspectos importantes a tener en cuenta

Más allá de las decisiones anteriores, hay preguntas fundamentales que todo FS debe responder:

- ¿Cómo se representan los archivos en disco?
- ¿Cómo se gestiona el espacio libre?
- ¿Qué se hace con los metadatos?

Las respuestas a estas preguntas determinan las características del **FS**, especialmente en cuanto a rendimiento y confiabilidad.

---

### Atributos

Cuando hablamos de metadata, en general se incluyen los i-nodos (o la estructura de datos que use el **FS**), pero además hay mucha más información, como:

- Permisos (default y ACLs).
- Tamaños.
- Propietario/s.
- Fecha de modificación, creación y acceso.
- Bit de archivado.
- Tipo de archivo (regular, dispositivo, virtual, pipe, etc.).
- Flags.
- Conteo de referencias.
- CRC o similar.

---

### Representación de archivos

Para el **FS**, un archivo es esencialmente una **lista de bloques de datos más sus metadatos**. La pregunta clave es: ¿cómo organizamos esos bloques en el disco? A lo largo del tiempo surgieron distintos esquemas, cada uno intentando mejorar las limitaciones del anterior.

#### Esquema 1: Bloques contiguos

La idea más simple es almacenar todos los bloques de un archivo de forma contigua en el disco, uno al lado del otro.

**Ventaja:** las lecturas son extremadamente rápidas, ya que el cabezal del disco no necesita saltar entre posiciones.

**Problemas:**

- Si el archivo crece y no hay espacio contiguo disponible, no puede expandirse sin ser reubicado por completo.
- Con el tiempo, a medida que se crean y eliminan archivos, el disco se llena de huecos inutilizables: esto se conoce como **fragmentación externa**.

Por estas razones, este esquema no se usa en sistemas de archivos modernos.

#### Esquema 2: Lista enlazada de bloques

Para resolver los problemas anteriores, se pueden organizar los bloques como una **lista enlazada**: cada bloque contiene los datos y un puntero al siguiente bloque del archivo.

**Ventajas:** el archivo puede crecer libremente usando cualquier bloque libre del disco, y la fragmentación deja de ser un problema.

**Problemas:**

- Las **lecturas aleatorias son muy lentas**: para acceder al bloque N hay que recorrer todos los anteriores uno por uno, lo que implica una complejidad O(n).
- Se **desperdicia espacio** en cada bloque, ya que parte de él debe reservarse para almacenar el puntero al siguiente.

#### Esquema 3: Tabla de asignación de archivos (FAT)

Una mejora natural al esquema anterior es sacar los punteros de los bloques y concentrarlos en una **tabla separada**: la *File Allocation Table* o FAT. Esta tabla tiene una entrada por cada bloque del disco, y cada entrada indica cuál es el bloque siguiente en la cadena.

Veamos un ejemplo concreto. Supongamos que el archivo A ocupa los bloques 1, 2, 5, 7 y 9, y el archivo B ocupa los bloques 4, 3 y 8:

| Bloque | Siguiente  |
| ------ | ---------- |
| 0      | — (vacío)  |
| 1      | 2          |
| 2      | 5          |
| 3      | 8          |
| 4      | 3          |
| 5      | 7          |
| 6      | — (vacío)  |
| 7      | 9          |
| 8      | -1 (fin)   |
| 9      | -1 (fin)   |

Para leer el archivo A, el FS consulta la tabla: empieza en el bloque 1, que apunta al 2, luego al 5, luego al 7 y finalmente al 9 (donde encuentra -1, indicando el fin del archivo). Todo el recorrido se hace sobre la tabla, que reside en memoria RAM, sin necesidad de leer bloques del disco hasta buscar el dato real.

**Ventaja principal:** como la tabla está en memoria, las búsquedas son mucho más rápidas que con la lista enlazada pura; ya no es necesario acceder al disco para encontrar el bloque siguiente.

**Limitación:** la tabla debe cargarse completa en memoria. En discos grandes, esto puede consumir una cantidad significativa de RAM, lo cual es un problema en sistemas con recursos limitados.

#### Esquema 4: I-Nodes

Este es el método que emplea Unix. La idea central es asociar a cada archivo una estructura llamada **i-node** (*index node*), que cumple dos funciones: almacena los **atributos** del archivo (permisos, propietario, tamaño, fechas, etc.) y guarda las **direcciones de disco** de sus bloques de datos.

La estructura de un i-node es la siguiente:

- **Bloques directos:** las primeras entradas apuntan directamente a bloques de datos. Esto permite acceder a archivos pequeños de forma muy rápida, sin ningún nivel de indirección.
- **Single indirect block:** la siguiente entrada no apunta a un bloque de datos, sino a un bloque intermedio que contiene punteros a bloques de datos. Agrega un nivel de indirección y permite cubrir archivos de hasta ~16 MB.
- **Double indirect block:** apunta a un bloque de punteros a *single indirect blocks*. Con dos niveles de indirección se pueden cubrir archivos de hasta ~32 GB.
- **Triple indirect block:** agrega un tercer nivel, apuntando a un bloque de *double indirect blocks*. Permite cubrir archivos de hasta ~70 TB.

Cada nivel de indirección amplía el tamaño máximo soportado a costa de un acceso adicional a disco, pero en la práctica la mayoría de los archivos son pequeños y se resuelven con los bloques directos.

##### Ventaja frente a la FAT

La gran ventaja de los i-nodes sobre la tabla FAT es el **uso de memoria**. Recordemos que la FAT debe cargarse completa en RAM para poder funcionar. En cambio, un i-node solo necesita estar en memoria mientras el archivo correspondiente está **abierto**.

Si cada i-node ocupa `n` bytes y puede haber simultáneamente `k` archivos abiertos, en el peor caso se consumen `k * n` bytes de RAM. Este valor suele ser órdenes de magnitud menor que el espacio que ocupa una FAT completa para un disco grande.

##### El problema del crecimiento y su solución

Dado que cada i-node tiene espacio para un número fijo de entradas, surge una pregunta: ¿qué pasa cuando un archivo crece más allá del límite que cubren esas entradas?

La solución es precisamente el esquema de indirección descrito arriba: en lugar de guardar en la última entrada la dirección de un bloque de datos, se guarda la dirección de un bloque que contiene **más punteros a bloques**. Esto puede repetirse en múltiples niveles (single, double, triple), permitiendo que los archivos crezcan sin modificar la estructura del i-node en sí.

---

### Implementación de directorios

Una vez que tenemos archivos, necesitamos una forma de que el usuario pueda organizarlos de manera arbitraria — para eso existen los directorios. Pero ¿cómo se implementan internamente?

La implementación se apoya en el esquema de **i-nodos**. Los conceptos clave son:

**El directorio raíz (root):** El sistema operativo reserva un i-nodo específico (usualmente el i-nodo 2 en sistemas tipo Unix/Linux) como punto de entrada para el directorio raíz (`/`). A partir de este nodo, el kernel puede resolver cualquier ruta absoluta iniciando la búsqueda desde sus bloques de datos.

**Mapeo de entradas:** La función principal del directorio es realizar el mapeo entre el **nombre** (el string que escribe el usuario) y el **número de i-nodo** (la referencia numérica interna). El nombre del archivo no se guarda en el i-nodo, sino en la entrada del directorio.

**Estructura en bloques:** Un directorio es técnicamente un archivo especial cuyos bloques de datos contienen una lista de registros. Cada registro incluye:

- El número de i-nodo.
- La longitud de la entrada (para manejar nombres de longitud variable).
- El nombre del archivo o subdirectorio.
- *(Opcional)* Un campo de tipo de archivo para agilizar listados como `ls`.

**Entradas especiales de navegación:** Todo directorio, al ser creado, incluye automáticamente dos entradas:

- `.` (punto): referencia al i-nodo del propio directorio.
- `..` (punto punto): referencia al i-nodo del directorio padre. En el *root*, `..` apunta a sí mismo.

**Optimización de búsqueda:** La estrategia varía según el tamaño del directorio:

- **Lista lineal:** en directorios con pocos archivos, se usa una lista simple O(n). El SO lee y compara cada nombre secuencialmente hasta encontrar el buscado.
- **Estructuras indexadas (Hash / B-Trees):** en directorios con miles de archivos, los sistemas modernos (como ext4 o XFS) utilizan tablas hash o B-Trees, reduciendo el tiempo de búsqueda a O(1) o O(log n).

**Gestión de nombres de longitud variable:** Para no desperdiciar espacio, los sistemas actuales utilizan entradas de longitud variable. Cada entrada indica cuánto mide el nombre, permitiendo que archivos con nombres cortos y largos convivan en el mismo bloque de datos de forma compacta.

---

### ¿Qué es el punto de montaje?

Un punto de montaje es un directorio específico dentro del sistema de archivos actual sobre el cual se "conecta" o integra un sistema de archivos externo (como un disco duro, una memoria USB o una partición NVMe). Es el mecanismo que permite que distintos dispositivos de almacenamiento aparezcan como parte de un único árbol de directorios.

---

### Journaling

Aunque los sistemas de archivos estructurados por log son una idea interesante, no se utilizan ampliamente, en parte por ser altamente incompatibles con los sistemas existentes. No obstante, su robustez ante fallos puede aplicarse fácilmente a sistemas de archivos convencionales. La idea básica es mantener un **log** de lo que el sistema de archivos va a hacer *antes* de hacerlo. De este modo, si el sistema crashea antes de completar el trabajo planeado, al reiniciar puede consultar el log para completar la tarea pendiente.

Tales sistemas se llaman **sistemas de archivos con journaling** y son muy utilizados en la actualidad. El sistema **NTFS** de Microsoft y los sistemas **ext3** y **ReiserFS** de Linux utilizan este enfoque.

#### La naturaleza del problema: eliminación de un archivo

Consideremos una operación común: eliminar un archivo. En Unix, esto requiere tres pasos:

1. Eliminar el archivo de su directorio.
2. Liberar el i-nodo y ponerlo en la lista de i-nodos libres.
3. Devolver todos los bloques de disco a la lista de bloques libres.

Si ocurre un crash en medio de la operación, podría quedar el archivo eliminado del directorio pero sin haberse liberado el i-nodo ni los bloques que ocupaba, dejando el sistema de archivos en un estado inconsistente.

#### Cómo funciona el Journaling

Ante estos posibles fallos, el sistema escribe primero una entrada en el log listando las tres acciones a completar. Esta entrada se escribe directamente en el disco. Una vez confirmada la escritura, comienza la operación real. Solo cuando la tarea se completa por entero se elimina la entrada del log.

En caso de que el sistema falle, al recuperarse el sistema de archivos verifica el log para detectar operaciones pendientes y, de haberlas, las ejecuta nuevamente.

#### Idempotencia

Para que el journaling funcione correctamente, las operaciones deben ser **idempotentes**: esto significa que pueden repetirse tantas veces como sea necesario sin causar daño ni dejar el sistema en un estado diferente al esperado.

---

### Manejo del espacio libre

Además de representar los archivos, el FS debe llevar registro de qué bloques están disponibles. Hay dos enfoques principales:

**Mapa de bits:** se usa un vector donde cada bit representa un bloque del disco — en 1 significa libre. La ventaja es que si una palabra tiene todos los bits en 0 puede saltearse con una única comparación. La desventaja es que requiere mantener el vector completo en memoria.

**Lista enlazada de bloques libres:** en lugar de un vector, se encadena los bloques libres. Para no desperdiciar espacio, se clusteriza: si un bloque puede contener `n` punteros, los primeros `n-1` apuntan a bloques libres y el último apunta al siguiente nodo de la lista. Un refinamiento adicional consiste en que cada nodo indique cuántos bloques libres consecutivos hay a partir de él.

---

### Caché

Una manera de mejorar el rendimiento del FS es mediante un **caché**: una copia en memoria de bloques del disco. Se administra de forma muy similar a las páginas de memoria virtual.

Los sistemas operativos modernos mantienen un **caché unificado** para páginas y bloques de disco, ya que si fueran independientes, al mapear un archivo en memoria habría dos copias del mismo dato en RAM.

Una ventaja adicional del caché es que permite acumular escrituras y ordenarlas, de modo que el administrador de E/S pueda planificarlas más eficientemente. Las aplicaciones que necesitan garantías de persistencia pueden usar `fsync()` para forzar la escritura inmediata a disco, aunque esto es significativamente más lento.

---

### Consistencia

Si se corta la energía antes de que el caché se vuelque a disco, los cambios en vuelo se pierden y el sistema de archivos puede quedar en un estado inconsistente.

La solución tradicional es `fsck` (*file system check*): al arrancar, si el sistema detecta que no se apagó correctamente (mediante un bit de "apagado normal"), recorre todo el disco y por cada bloque verifica cuántos i-nodos le apuntan y cuántas veces aparece en la lista de bloques libres. Según los contadores, toma acciones correctivas. El problema es que este proceso puede ser muy lento y el sistema no puede operar hasta que termine.

Como alternativa más liviana existe **soft updates**: rastrea las dependencias entre cambios de metadata y los escribe solo cuando es necesario. Sigue requiriendo una recorrida de la lista de bloques libres, pero puede hacerse mientras el sistema está funcionando. La otra alternativa, más utilizada hoy en día, es el **journaling**.

---

### Performance

El rendimiento de un FS depende de múltiples factores: tecnología del disco, política de scheduling de E/S, tamaño de bloque, cachés del SO y de las controladoras, manejo de locking en el kernel, y el propio diseño del FS. En particular, la elección entre journaling y soft updates sigue siendo un tema de debate activo en la comunidad.

Un punto importante: optimizar hasta el último nanosegundo no siempre vale la pena si implica sacrificar mantenibilidad o robustez.

---

### NFS y el Virtual File System

El **NFS** (*Network File System*) es un protocolo que permite acceder a sistemas de archivos remotos como si fueran locales, usando RPC. Un FS remoto se monta en un punto del árbol de directorios local y las aplicaciones acceden a sus archivos sin saber que están en otra máquina.

Para soportar esto, los sistemas operativos incorporan una capa de abstracción llamada **VFS** (*Virtual File System*). El VFS mantiene *vnodes* por cada archivo abierto: si el archivo es local, el vnode se corresponde con un i-nodo; si es remoto, almacena la información necesaria para el protocolo de red. Así, cualquier pedido de E/S que llega al VFS se despacha al FS real o al cliente NFS según corresponda.

Vale notar que NFS no es completamente distribuido: todos los datos de un mismo directorio deben residir físicamente en el mismo servidor. Existen FS 100% distribuidos, como **AFS** o **Coda**, aunque han tenido un éxito relativo.

---

### Estructura interna: Ext2

Ext2 organiza el disco en **grupos de bloques**. Cada grupo contiene su propio superbloque, descriptores de grupo, mapas de bits y tabla de i-nodos, seguidos de los bloques de datos.

El **superbloque** contiene los metadatos críticos del FS: tamaño total, cantidad de bloques e i-nodos libres, tamaño de bloque, timestamps de montaje y escritura, entre otros. Si el superbloque se daña, el sistema pierde la capacidad de determinar qué partes del disco contienen información válida.

---

### LVM (Logical Volume Management)

LVM es un sistema de administración de volúmenes lógicos que agrega una capa de abstracción entre el hardware de almacenamiento y el sistema de archivos, ofreciendo mayor flexibilidad que las particiones tradicionales.

Sus tres componentes principales son:

- **Physical Volume (PV):** un disco o partición física.
- **Volume Group (VG):** una agrupación de uno o más PVs que forma un pool de almacenamiento.
- **Logical Volume (LV):** una partición lógica extraída del VG, sobre la cual se crea el FS.

Las principales ventajas son poder redimensionar volúmenes, crear snapshots, hacer mejor uso del espacio disponible y realizar todas estas operaciones en caliente, sin necesidad de detener el sistema.

Un ejemplo de uso básico:

```bash
# Crear un volumen físico
sudo pvcreate /dev/sdb1

# Crear un grupo de volúmenes
sudo vgcreate mi_vg /dev/sdb1

# Crear un volumen lógico de 10 GB
sudo lvcreate -L 10G -n mi_lv mi_vg

# Crear el filesystem y montarlo
sudo mkfs.ext4 /dev/mi_vg/mi_lv
sudo mount /dev/mi_vg/mi_lv /mnt

# Consultar el estado
pvdisplay
vgdisplay
lvdisplay
```
