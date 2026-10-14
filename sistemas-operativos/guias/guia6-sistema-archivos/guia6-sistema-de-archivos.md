# Práctica 6: Sistema de archivos

**Sistemas Operativos — FCEyN, Universidad de Buenos Aires**

---

> Enunciado: [PDF](p6.pdf)

---

## Ejercicio 1

Recordemos que el esquema FAT consta de la File Allocation Table, la cual guarda el par (bloque, siguiente) y tiene tantas entradas como bloques tenga el sistema; en este caso tendría $N$ entradas.
Queremos llegar al último bloque de un archivo. Recordemos que la tabla no se encuentra en memoria y, además, no hay memoria caché, por lo que todos van a ser accesos al disco.
Asumiendo que solo quiero llegar al último sin leer ninguno, tendría que hacer un acceso al disco de la entrada actual, sea $i$, para ver el campo siguiente, lo mismo para $i+1$ y así hasta $N$, por lo que tendría que hacer $N-1$ accesos totales.
En cambio, si leyera todos los archivos, serían un acceso a la FAT para saber cuál es el siguiente y la lectura del bloque actual; eso, con $N$ bloques, se resume en $2N$ accesos.

---

## Ejercicio 2

Para empezar, tenemos los siguientes datos sobre el disco, los bloques del sistema y las entradas de la FAT:

- Tenemos un disco con capacidad de $128 GB$ = $2^{37} B$.
- Los bloques tienen un tamaño de $8 KB$ = $2^{13}B$.
- La tabla se ubica en la posición 0 y cada entrada ocupa 24 B.

### a)

Como bien sabemos, la FAT tiene tantas entradas como bloques tenga el sistema, así que calculemos la cantidad de entradas y con eso tenemos nuestra respuesta. Primero, sabemos que el disco tiene capacidad de: $$128 GB = 128 \times 1024 B \times 1024 B \times 1024 B = 137438953472 B$$ 

Entonces, sabiendo que cada bloque ocupa $8 KB$ tenemos: $$
\#bloques = 137438953472 B / 8192 B = 16777216  $$

Como cada entrada ocupa $24 B$, eso quiere decir que la FAT ocupa $24 B$ $\times$ $2^{24}$ entradas, que son $384 MB$. 

### b) 

Ahora tenemos que calcular cuántos archivos de $10 MB$ es posible almacenar en el disco. Entonces, teniendo en cuenta el ejercicio anterior, el espacio útil para archivos es:

$$
128 \space GB \space - \space 384 \space MB
$$
Pasando todo a MB:

$$
128 \space GB \space = \space 128 \space \cdot \space 1024 \space MB \space = \space 131072 \space MB
$$
Entonces:

$$
131072 \space MB \space - \space 384 \space MB \space = \space 130688 \space
$$

Como cada archivo ocupa 10 MB, la cantidad total sería $\frac{130688}{10}$ = 13068 archivos de 10 MB.

### c)

Tenemos que un archivo comienza en el bloque 20, y nos dan la siguiente **FAT**; tenemos que indicar el tamaño de dicho archivo.

| Bloque    | 0   | 1   | 2   | 3   | 4   | 5   | 6   | ... | 20  | 21  | 22  | ... |
| --------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Siguiente | EOF | 2   | 23  | 4   | 5   | 0   | 7   | ... | 21  | 22  | 3   | ... |

Para hacer eso tenemos que llegar a que el siguiente en la tabla sea EOF o -1. Sabiendo que cada bloque ocupa $8 KB$, podemos contar los bloques que componen el archivo; mirando la tabla sabemos que la cadena es: 

$$20 \rightarrow 21 \rightarrow 22 \rightarrow 3 \rightarrow 4 \rightarrow 5 \rightarrow 0 \rightarrow EOF$$

Vemos que la longitud de la cadena sin contar EOF es de 7 bloques, por lo tanto el archivo ocupa $8 KB $\times$ 7 bloques = $56 KB$.

---

## Ejercicio 3

Tenemos un sistema de archivos de Unix, similar a **ext2**, que cuenta con las siguientes especificaciones:

- Tamaño de los bloques $4 \text{ KB} = 2^{12} \text{ B}$.
- El direccionamiento a bloque de disco (LBA) es de $8 \text{ B} = 2^3 \text{ B}$.
- Cada **inodo** cuenta con 5 entradas directas, dos indirectas y una doblemente indirecta.

### a) 

Queremos saber cuál es el tamaño máximo de archivo que soporta el sistema de archivos. Esto depende de la cantidad de bloques de datos que puede direccionar un inodo mediante sus entradas directas, indirectas y doblemente indirectas.

Primero calculamos cuántas direcciones (punteros) entran en un único bloque de punteros:

$$\text{Punteros por bloque} = \frac{4096 \text{ B}}{8 \text{ B}} = \frac{2^{12} \text{ B}}{2^3 \text{ B}} = 512 \text{ direcciones} = 2^9$$

Analizamos la capacidad que aporta cada nivel:

- **Entradas directas:** Cada una apunta directamente a un bloque de datos. Al ser 5 entradas, tenemos $5 \times 4 \text{ KB} = 20 \text{ KB}$.
- **Entradas indirectas:** Cada una apunta a un bloque de punteros a datos. Como son 2 entradas indirectas, direccionan $2 \times 512 = 1024 \text{ bloques}$ ($2^{10}$). Multiplicando por el tamaño de bloque: $1024 \times 4 \text{ KB} = 4096 \text{ KB}$ ($4 \text{ MB}$).
- **Entradas doblemente indirectas:** La entrada apunta a un bloque de punteros que referencia a otros bloques de punteros a datos. Direcciona $1 \times 512 \times 512 = 262.144 \text{ bloques}$ ($2^{18}$). Multiplicando por el tamaño de bloque: $262.144 \times 4 \text{ KB} = 1.048.576 \text{ KB}$ ($1 \text{ GB}$).

Sumando el aporte de todos los niveles obtenemos el tamaño máximo:

$$\text{Total de bloques} = 5 + 1.024 + 262.144 = 263.173 \text{ bloques}$$

$$\text{Tamaño máximo} = 20 \text{ KB} + 4.096 \text{ KB} + 1.048.576 \text{ KB} = 1.052.692 \text{ KB} \approx 1{,}004 \text{ GB}$$

### b)

Imaginemos que el disco tiene el siguiente estado:

- El 50% del espacio en disco está ocupado por archivos de $2 KB$.
- El 25% por archivos de $4 KB$.
- Y por último, el 25% restante por archivos de $8 KB$.

Queremos responder a la pregunta de qué porcentaje del espacio en disco se está desperdiciando. Recordemos que, por más que un archivo solo ocupe un porcentaje del bloque, se apropia de la totalidad del espacio del bloque.
El tamaño del bloque es de $4 KB$, entonces los únicos archivos que desperdician son los de $2 KB$, en particular desperdician el 50% cada uno; el resto usa el bloque o los bloques que toma al 100%.
Entonces, como el 50% del disco desperdicia el 50% de su espacio, eso quiere decir que se está desperdiciando el 25% del disco total.

### c)

Tenemos que calcular cuántos bloques hace falta acceder para procesar completo un archivo de 5 MB.

Recordemos cómo está compuesto cada inodo:

- 5 entradas directas
- 2 entradas indirectas simples
- 1 entrada doblemente indirecta

Cada bloque ocupa $4 KB$.

Las 5 entradas directas nos permiten acceder directamente a:

$$
5 \times 4\ \text{KB} = 20\ \text{KB}
$$

Todavía nos faltan:

$$
5 \times 1024\ \text{KB} - 20\ \text{KB} = 5100\ \text{KB}
$$

Ahora usamos las entradas indirectas simples.

Cada bloque de punteros indirectos puede almacenar:

$$
4096\ \text{B} / 8\ \text{B} = 512
$$

direcciones a bloques de datos.

Como tenemos 2 entradas indirectas simples:

$$
2 \times 512 = 1024
$$

bloques de datos direccionables.

Eso equivale a:

$$
1024 \times 4\ \text{KB} = 4096\ \text{KB}
$$

Todavía nos faltan:

$$
5100\ \text{KB} - 4096\ \text{KB} = 1004\ \text{KB}
$$

Hasta ahora llevamos:

- 5 bloques de datos de entradas directas
- 2 bloques de punteros indirectos
- 1024 bloques de datos de las entradas indirectas simples

Ahora tenemos que usar la entrada doblemente indirecta.

Como todavía faltan $1004 KB$:

$$
1004\ \text{KB} / 4\ \text{KB} = 251
$$

bloques de datos.

Para acceder a esos bloques necesitamos:

- 1 bloque doblemente indirecto
- 1 bloque indirecto simple
- 251 bloques de datos

Por lo tanto, la cantidad total de bloques accedidos es:

$$
\#bloques\_accedidos \space = \space 5 + 2 + 1024 + 1 + 1 + 251 = 1284 \space bloques
$$

---

## Ejercicio 4

Supongamos que tenemos un sistema de archivos basado en inodos como **ext2** y con bloques de $4 KB$.

### a)

Tenemos un archivo de $40 KB$ y queremos saber cuántos bloques es necesario leer para procesarlo completamente, pero esta pregunta depende mucho de las entradas, verdaderamente. Para fines prácticos, voy a asumir que tenemos el mismo esquema que el ejercicio anterior.

Entonces, con las 5 entradas directas tenemos $20 KB$, por lo que nos faltarían otros $20 KB$ y procesamos 5 bloques. Ahora vamos a un bloque de una de las entradas indirectas, con eso sumamos 6. Por último, tenemos que leer 5 bloques de la entrada indirecta simple; con eso nos da un total de 11 bloques para procesar completamente el archivo.

### b)

Usando el mismo esquema, si para $40 KB$ usamos 11, podemos seguir a partir de eso: seguimos en la entrada indirecta simple, leemos 10 punteros más de la entrada, que equivalen a 10 bloques más para cubrir los $40 KB$ que nos faltaban, con un total de 21 bloques para procesar el archivo de $80 KB$ completamente.

---

## Ejercicio 6

Consideremos la siguiente ruta a un archivo: **/home/aprobar.txt**.

### a) 

En un sistema basado en **FAT**, los directorios guardan directamente el nombre del archivo y el bloque inicial donde empiezan sus datos. Para llegar a los datos de `/home/aprobar.txt`:

1. Se accede al bloque del directorio raíz `/` para buscar la entrada `"home"` y obtener su bloque.
2. Se accede al bloque del directorio `/home` para buscar la entrada `"aprobar.txt"` y obtener el bloque donde inician sus datos.

Por lo tanto, se deben acceder a **2 bloques de disco** para llegar a los bloques de datos (y **3 accesos** si contamos leer el bloque de datos de `aprobar.txt`).

### b)

En **ext2**, para leer un enlace simbólico como un archivo regular, debemos acceder tanto al directorio que lo contiene como al propio bloque de datos del enlace para leer la ruta a la que apunta, y luego resolver esa nueva ruta desde el inicio.

1. **Lectura del enlace `/pepe.txt`:**
   - Se accede al bloque del directorio raíz `/` para buscar `"pepe.txt"`.
   - Se accede al bloque de datos de `pepe.txt` para leer el texto del enlace (la ruta `"/home/aprobar.txt"`).

2. **Resolución de la ruta destino `/home/aprobar.txt`:**
   - Se accede nuevamente al bloque del directorio raíz `/` (al no haber caché) para buscar `"home"`.
   - Se accede al bloque del directorio `/home` para buscar `"aprobar.txt"`.

Con esto ya se llegó a los bloques de datos del archivo referenciado.

Total: **4 accesos a bloques de disco** (y **5 accesos** si se incluye la lectura del primer bloque de datos de `aprobar.txt`).

> **Aclaración:** Si se asumiera que el sistema cuenta con memoria caché de bloques, la segunda lectura del directorio raíz `/` no iría a disco, quedando en **3 accesos** para llegar a los datos.

---

## Ejercicio 7

Vamos a mencionar cuál es el enfoque de sistema de archivos más conveniente para los siguientes requerimientos:

1. **Recomendación: Basado en Inodos.**
	Aquí el mejor enfoque, e incluso el único, es el basado en inodos, ya que en un sistema basado en **FAT** no existen los enlaces simbólicos, por lo que nuestra única alternativa es el basado en inodos.
2. **Recomendación: Basado en Inodos.**
	Como requerimos que el espacio de estructuras auxiliares sea acotado, nos conviene un enfoque con inodos, ya que en su conjunto los inodos no dependen del tamaño del disco, sino que por lo general se trabaja con un *pool* constante de inodos. En cambio, la **FAT** crece linealmente con respecto al tamaño del disco, por lo que no se puede independizar.
3. **Recomendación: Basado en FAT.**
	Como queremos que el tamaño del archivo solo esté limitado por el tamaño del disco, es mejor un esquema **FAT**, ya que un archivo puede usar tantos bloques como quiera, siempre y cuando estén disponibles. En cambio, un sistema de archivos basado en inodos depende de las entradas directas, indirectas, etc.
4. **Recomendación: Basado en Inodos.**
	Si usamos un enfoque **FAT**, lo que pasa es que tenemos en memoria la información de todos los archivos del sistema de archivos. En cambio, con un enfoque basado en inodos basta con tener en memoria solo los que están abiertos en ese instante, por lo tanto sería $O(kn)$ espacial, donde $k$ es la cantidad de archivos y $n$ lo que ocupan en el peor caso.

---

## Ejercicio 8

Bueno, vamos con el contexto del ejercicio. Tenemos los siguientes datos:

- Un disco rígido de 16 GB de espacio, el cual tiene sectores de $1 KB$.
- Se desea usar el sistema de archivos **HashFS**, el cual es basado en **FAT**. El funcionamiento es que no existen directorios ni archivos, sino que, dado un path, se calcula el hash del nombre y este indica cuál es el archivo buscado.

En cuanto al sistema de archivos utilizado, tiene las siguientes particularidades:

- Se puede configurar el tamaño del bloque: 2, 4 u 8 sectores.
- Tamaño de identificadores del bloque: 8, 16, 24 o 32 bits.
- Y por último, el tamaño del hash: 8, 16, 24 o 32 bits.

### a)

En este inciso tenemos que:

- 2 sectores por bloque, lo que nos da un bloque de $2\ KB$ (sectores de $1\ KB$).
- Un identificador de bloque de 24 bits.
- Un hash de 16 bits.

Y nos piden que respondamos varias preguntas.

**Tamaño de la FAT**

Para calcular el tamaño que ocupa la FAT tenemos que conocer cuántos bloques va a tener el sistema. Como el disco es de $16\ GB = 16777216\ KB$ y cada bloque ocupa $2\ KB$, tenemos:

$$
Entradas_{FAT} = \frac{16777216\ KB}{2\ KB} = 8388608 = 2^{23}\ bloques
$$

Cada entrada de la FAT ocupa 24 bits, entonces:

$$
Tamaño_{FAT} = 24\ bits \times 8388608\ bloques = 3\ bytes \times 2^{23} = 24\ MB
$$

**Tamaño de la tabla de archivos**

El hash ocupa 16 bits (2 bytes) y tenemos una entrada por cada bloque de disco, es decir, $2^{23}$ entradas. Por lo tanto:

$$
Tamaño_{tabla} = 2\ bytes \times 2^{23} = 16777216\ bytes = 16\ MB
$$

**Espacio libre para archivos**

Para saber cuánto disco queda libre, restamos lo que ocupan las estructuras del FS al total del disco:

$$
16384\ MB - 24\ MB - 16\ MB = 16344\ MB
$$

Quedan **16344 MB** libres para archivos.

### b)

Para maximizar la cantidad de archivos tenemos que detectar cuáles son los puntos más importantes:

1. **Minimizar la fragmentación interna.** Los bloques serán de 2 sectores de $1\ KB$, es decir, de $2\ KB$, ya que si los elegimos más grandes estaríamos desaprovechando espacio: en promedio los archivos son de $1\ KB$.

2. **Maximizar la cantidad de entradas de la tabla hash.** La cantidad de archivos depende exclusivamente de las entradas de la tabla hash: cuantas más entradas, más archivos. Por lo tanto, elegimos un hash de **32 bits**.

3. **Poder direccionar todos los bloques.** Al particionar el disco en "pedazos" de $2\ KB$ obtenemos $2^{23}$ bloques, por lo que es necesario que los identificadores sean de **24 bits**, que es la mejor opción disponible. 

### c)

Con archivos de 16 MB en promedio conviene lo siguiente:

1. **Tamaño de bloque: 8 sectores.** Con bloques de $8\ KB$ ($8 \times 1\ KB$) reducimos la cantidad de bloques necesarios para almacenar un archivo, y además reducimos el tamaño de la FAT, dejando más espacio libre en el disco para datos. La fragmentación interna deja de ser un problema, ya que es despreciable frente a archivos de $16\ MB$.

2. **Tamaño del hash: 16 bits.** El disco es de $16\ GB = 2^{14}\ MB$ y cada archivo mide en promedio $16\ MB = 2^4\ MB$, por lo que, en el mejor caso, caben como máximo:

$$
\frac{2^{14}\ MB}{2^{4}\ MB} = 2^{10}\ archivos
$$

   No necesitamos un hash demasiado grande: con 16 bits tenemos $2^{16}$ entradas en la tabla de hash, más que suficiente para los $2^{10}$ archivos posibles.

3. **Tamaño del identificador de bloque: 24 bits.** El disco tiene $16\ GB = 2^{34}\ bytes$ y los bloques son de $8\ KB = 2^{13}\ bytes$, lo que nos da:

$$
\frac{2^{34}\ bytes}{2^{13}\ bytes} = 2^{21}\ bloques
$$

   Necesitamos identificar $2^{21}$ bloques, por lo que 16 bits no alcanzan y el siguiente tamaño disponible, **24 bits**, es suficiente.

---

## Ejercicio 9

Tenemos que escribir un pseudocódigo que nos permita obtener el nombre del directorio (home) a partir del descriptor de archivo recibido.

```C
// Busca en el directorio la entrada que cumple el criterio
Entry* buscar_entrada(Ext2FSInode dir, criterio) {
	for (int i = 0; i < cantidad_bloques(dir); i++) {
		bloque = read_block(dir.block[i]);
		int offset = 0;
		while (offset < BLOCK_SIZE) {
			entry = (Entry*) (bloque + offset);
			if (entry->inode != 0 && criterio(entry))
				return entry;
			offset += entry->rec_len;
		}
	}
	return NULL;
}

char* obtener_nombre(int fd_recibido) {
	// Paso 1: número de inodo del directorio abierto
	struct stat st;
	fstat(fd_recibido, &st);
	mi_inodo_num = st.st_ino;
	mi_inodo = load_inode(mi_inodo_num);

	// Paso 2: inodo padre, a través de la entrada ".."
	entry_padre = buscar_entrada(mi_inodo, entry->name == "..");
	padre_inodo_num = entry_padre->inode;
	padre_inodo = load_inode(padre_inodo_num);

	// Paso 3: en el padre, buscar la entrada que apunta a mi inodo
	entry_mia = buscar_entrada(padre_inodo, entry->inode == mi_inodo_num);
	if (entry_mia == NULL) return NULL;

	return copiar(entry_mia->name, entry_mia->name_len);  // el name no termina en '\0'
}
```

---

## Ejercicio 10

Primero que nada, estamos ante un sistema de archivos de tipo **FAT**; además, contamos con las siguientes funciones auxiliares:

- `FAT_entry(block_address)`: devuelve la entrada de la tabla **FAT** de la posición **block_address**.
- `raw_data = read_blocks(block_address1, block_address2,...)`: lee del disco todos los bloques que se le indiquen, en orden.
- `parse_directory_entries(raw_data)`: devuelve una lista de **struct_entrada_directorio**, donde cada elemento representa los subdirectorios del directorio pasado en raw_data.
- `raw_data = root_table()`: devuelve los datos de la tabla de directorios de root.

### a) 

Tenemos que enumerar 3 campos que debe tener **struct_entrada_directorio**. Podemos definir los siguientes:

- `char nombre[]`: que indique el nombre del directorio actual.
- `unsigned int tamaño`: tamaño en bytes.
- `unsigned int primer_bloque`: número del bloque inicial, desde donde se sigue la cadena en la **FAT**.

> Opcionalmente se podría agregar un campo de atributos que indique si la entrada es un archivo o un directorio.


### b)

Ahora debemos escribir el pseudocódigo de la función 
**cargar_archivo**:

La idea es, para cada nombre de la ruta: buscarlo en las entradas del directorio actual, recorrer su cadena de bloques en la FAT y leer sus datos. Si es un directorio intermedio, esos datos se parsean para obtener las entradas del siguiente nivel. Si es el último nombre, esos datos son el contenido del archivo.

```C
void* cargar_archivo(char* directorios[], size_t size) {
	// Paso 1: Entradas del directorio actual, empezando por el root
	raw_data = root_table();
	entradas = parse_directory_entries(raw_data);

	for (size_t i = 0; i < size; i++) {
		char* nombre_buscado = directorios[i];

		// Paso 2: Buscar el nombre en el directorio actual
		int primer_bloque = -1;
		for (size_t j = 0; j < entradas.length; j++) {
			if (strcmp(entradas[j].nombre, nombre_buscado) == 0) {
				primer_bloque = entradas[j].primer_bloque;
				break;
			}
		}
		if (primer_bloque == -1) return NULL; // No existe

		// Paso 3: Recorrer la cadena de bloques de la FAT
		int lista_bloques[MAX_BLOCKS];
		int idx = 0;
		int actual = primer_bloque;
		while (actual != EOF) {
			lista_bloques[idx++] = actual;
			actual = FAT_entry(actual);
		}

		// Paso 4: Leer los datos de esos bloques
		raw_data = read_blocks(lista_bloques[0], ..., lista_bloques[idx - 1]);

		// Paso 5: Si no es el último, es un directorio: bajamos un nivel
		if (i < size - 1) {
			entradas = parse_directory_entries(raw_data);
		}

	}

	return raw_data; // Contenido del archivo
}
```

---

## Ejercicio 11

Tenemos un sistema de archivos **ext2**, y se nos pide:

### a)

Implementar la función `find_file_less_size(char* dir, int min_bytes, char* arch_name)`, la cual toma el path del directorio y devuelve la lista con todos los archivos que tengan un tamaño menor a **min_bytes**, cuyo nombre sea **arch_name**.

> **Aclaración:** La búsqueda deberá también considerar los subdirectorios del directorio dado (excepto '.' y '..').

Vamos con el pseudocódigo:

```C

struct FileNode* find_file_less_size(char* dir, int min_bytes, char* arch_name) {
	struct FileNode* res = NULL;
	find(dir, min_bytes, arch_name, &resultado);
	return FileNode;
}

void find(char* dir, int min_bytes, char* arch_name, struct FileNode* res) {
	// Paso 1: buscar el inodo correspondiente al directorio
	struct Ext2FSInode* inode_dir = Ext2FS::inode_for_path(dir);
	unsigned char buffer[BLOCK_SIZE];
	unsigned int num_blocks = (inode_dir->size + BLOCK_SIZE -1);

	for (unsigned int n = 0; n < num_blocks; n++) {
		unsigned int dir_block = Ext2FS::get_block_address(inode_dir);
		Ext2FS::read_block(dir_block, buffer);

		unsigned int offset = 0;

		while (offset < BLOCK_SIZE) {
			struct Ext2FSDirEntry* entry = (struct Ext2FSDirEntry*) (buffer + offset);

			if (entry->inode != 0 && is_valid_entry(entry)) {
				struct Ext2FSInode* inode = Ext2FS::load_inode(entry->inode);
				
				if (same_name(entry,arch_name) && inode->size < min_bytes) {
					struct FileNode* new = malloc(sizeof(struct FileNode));
					new->type = inode->mode && 0xF000;
					new->mtime = inode->mtime;
					new->size = inode->size;
					new->user = nombre_propietario(inode->uid);
					append(&res,new);
				}
			}

			// Si es un directorio, bajamos un nivel
			if ((inode->mode & 0XF000) == S_IFDIR) {
				char* subpath = concat(dir, "/", entry->name, entry->name_length);
				find(subpath, min_bytes, arch_name, &res);
			}
			offset += entry->record_length;
		}
	}
}
```

### b)

La lista es una lista enlazada simple. Cada nodo guarda la información pedida de un archivo encontrado:

```C
struct FileNode {
	unsigned short type;
	unsigned int mtime;
	unsigned int size;
	char* user;
	struct FileNode* next;
};
```

- El **type** sale de **mode** del inodo.
- La **fecha** y el **tamaño** salen de `mtime` y `size` del inodo.
- El **propietario** se obtiene con la función `nombre_propietario(inode->uid)`.

### c)

Si la búsqueda considera también los enlaces simbólicos, pueden ocurrir estos problemas:

1. **Ciclos infinitos.** Un enlace simbólico a un directorio puede apuntar a uno de sus ancestros (por ejemplo, `/a/b/link -> /a`). Al seguirlo, la recursión vuelve a recorrer `/a` y nunca termina.
2. **Archivos repetidos.** Un mismo archivo puede alcanzarse por varios caminos (el original y uno o más enlaces), por lo que podría aparecer varias veces en el resultado.
3. **Salirse del directorio de búsqueda.** Un enlace puede apuntar fuera de `dir`, y la búsqueda terminaría recorriendo zonas del sistema de archivos que no se pidieron.
4. **Enlaces rotos.** Si el destino no existe, `inode_for_path` falla o devuelve `NULL`, y la función debe manejarlo.
5. **Tamaño engañoso.** El `size` de un enlace simbólico es el largo del path al que apunta, no el tamaño del archivo destino. Un enlace llamado `arch_name` podría entrar en la lista por un tamaño que no es el del archivo real.

**Posibles soluciones:** no seguir los enlaces simbólicos (detectarlos con `(mode & 0xF000) == S_IFLNK` y no recursar), o bien mantener un conjunto de números de inodo ya visitados para no recorrer dos veces el mismo directorio.