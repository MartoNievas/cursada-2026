# Practica 5: Sistema de archivos

> Los enunciados de los ejercicios se encuentran en el PDF aparte [Enunciados](p5.pdf).
## Ejercicio 1

Recordemos que el esquema FAT consta de la File Allocation Table la cual guarda el par (bloque, siguiente), y tiene tantas entradas como bloques tenga el sistema, en esta caso tendría $N$ entradas.
Queremos llegar al último bloque de un archivo, recordemos que la tabla no se encuentra en memoria y ademas no hay memoria cache, por lo que todos van a ser accesos al disco.
Asumiendo que solo quiero llegar al último sin leer ninguno, tendría que hacer un acceso al disco de la entrada actual sea $i$, para ver el campo de siguiente, lo mismo para $i+1$ y así hasta $N$, por lo que tendría que hacer $N-1$ accesos totales.
En cambio si leyera todos los archivos, serian un acceso a la FAT para saber cual es el siguiente y lectura del bloque actual, eso con $N$ bloque se resume a $2N$ accesos.

## Ejercicio 2

Para empezar tenemos los siguientes datos sobre el disco, bloques del sistema y entradas de la FAT:

- Tenemos un disco con capacidad de 128 GB.
- Los bloques tienen un tamaño de 8 KB.
- La tabla se ubica en la posición 0 y cada entrada ocupa 24 B.

### a)

Como bien sabemos la FAT tiene tantas entradas como bloques tenga el sistema, asi que calculemos la cantidad de entradas y con eso tenemos nuestra respuesta. Primero sabemos que el disco tiene capacidad de 128 GB = $128 \times 1024 B \times 1024 B \times 1024 B$ = $137438953472 B$, entonces sabiendo que bloque ocupa 8 KB tenemos \#bloques = $137438953472 B / 8182 B$ = $16777216$ bloques.
Como todo bloque ocupa 24 B, eso quiere decir que la FAT ocupa $24 B$ $\times$ $2^{24}$ bloques que son $384 MB$. 

### b) 

Ahora tenemos que calcular cuantos archivos de $10 MB$ es posible almacenar en el disco. Sabemos  
Tenemos: 
- Disco: 128 GB
- Bloques: 8 KB
- FAT: 384 MB
Entonces el espacio útil para archivos es:

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

Como cada archivo ocupa 10 MB, la cantidad total seria $130688 / 10$ = 13068 archivos de 10 MB.

### c)

Tenemos que un archivo comienza en el bloque 20, y nos dan la siguiente **FAT**, tenemos que indicar el tamaño de dicho archivo

| Bloque    | 0   | 1   | 2   | 3   | 4   | 5   | 6   | ... | 20  | 21  | 22  | ... |
| --------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Siguiente | EOF | 2   | 23  | 4   | 5   | 0   | 7   | ... | 21  | 22  | 3   | ... |

Para hacer eso tenemos que llegar a que el siguiente en la tabla sea EOF o -1, sabiendo que cada bloque ocupa 8 KB, podemos contar de bloques que componen el archivo, mirando la tabla sabemos que la cadena es $20 \rightarrow 21 \rightarrow 22 \rightarrow 3 \rightarrow 4 \rightarrow 5 \rightarrow 0 \rightarrow EOF$ vemos que la longitud de la cadena sin contar EOF es de 7 bloques, por lo tanto el archivo ocupa 8 KB $\times$ 7 bloques = 56 KB.

## Ejercicio 3

Tenemos un sistema de archivos de Unix, similar a **ext2**, que cuenta con las siguiente especificaciones:

- Tamaño de los bloques 4 KB.
- El direccionamiento a bloque de disco (LBA) es de 8 B.
- Cada **inodo** cuenta con 5 entradas directas, dos indirectas y una doblemente indirecta.
### a) 

Queremos saber cuál es el tamaño máximo de archivo que soporta el sistema de archivos. 
Esto depende de la cantidad de bloques de datos que puede direccionar un inodo mediante sus entradas directas, indirectas y doblemente indirectas.
Recordemos entradas directas, indirectas y doblemente indirectas.

- **Entrada directa:** Cada una apunta a un bloque de datos en esta cada tenemos 5 bloques de 4 KB por lo que nos da como resultado un tamaño total de 20 KB hasta el momento.
- **Entradas indirectas:** Cada entrada indirecta apunta a un bloque de punteros (direcciones) de bloques datos, ahora tenemos 2 entradas indirectas simples, un bloque de 4 KB y el direccionamiento a bloque de disco que es de 8 B. Primero que nada debemos calcular cuantas direcciones entran en un bloque que es fácil son 4096 B / 8 B = 512 direcciones por bloque, luego tenemos 2 entradas indirectas simples lo que nos da 1024 direcciones de bloques de datos, por ultimo multiplicamos por el tamaño de un bloque de datos 1024 direcciones $\times$ 4 KB lo que nos da 4096 KB + 20 KB con un total acumulado hasta ahora de 4116 KB como máximo.
- **Entradas doblemente indirectas:** Aquí lo pasa es que cada entrada doblemente indirecta apunta a un bloque de punteros de entradas indirectas simples, entonces tenemos 512 direcciones de entradas indirectas simples, que a su vez cada una tienen 512 direcciones a bloques de datos cada una por lo tanto tenemos 512 $\times$ 512 es nos da que tenemos 262144 bloques da datos teniendo en cuenta que cada uno ocupa 4 KB nos da 262144 $\times$ 4 KB  que son 1048576 KB + 4116 KB que teníamos acumulados el tamaño máximo de un archivo son 1052692 KB que son un poco mas de archivos de 1 GB.

### b)

Imaginemos que el disco tiene el siguiente estada:

- El 50% del espacio en disco está ocupado por archivos de 2 KB.
- El 25% por archivos de 4 KB.
- Y por último el 25% restante por archivos de 8 KB.

Queremos responder a la pregunta de que porcentaje del espacio en disco se esta desperdiciando. Recordemos que por mas que un archivo solo ocupe un porcentaje del bloque, se apropia de la totalidad del espacio del bloque.
El tamaño del bloque es de 4 KB, entonces los únicos archivos que desperdician con los de 2 KB, en particular desperdician el 50% cada uno, el resto el/los bloque que toman los usan la 100%.
Entonces como el 50% del disco desperdician el 50% de su espacio eso quiere decir que se esta desperdiciando el 25% del disco total.

### c)

Tenemos que calcular cuantos bloques hace falta acceder para procesar completo un archivo de 5 MB.

Recordemos cómo está compuesto cada inodo:

- 5 entradas directas
- 2 entradas indirectas simples
- 1 entrada doblemente indirecta

Cada bloque ocupa 4 KB.

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

Como todavía faltan 1004 KB:

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
5 + 2 + 1024 + 1 + 1 + 251 = 1284
$$

bloques.

## Ejercicio 4

Supongamos que tenemos un sistema de archivos basado en inodos como  **ext2** y con bloques de 4 KB.

### a)

Tenemos un archivo de 40 KB y queremos saber cuantos bloques es necesario leer para procesarlo completamente, pero esta pregunta depende mucho de las entradas verdaderamente. Para fines prácticos voy a asumir que tenemos el mismo esquema que el ejercicio anterior.

Entonces con las 5 entradas directas tenemos 20 KB por lo que nos faltarían otros 20 KB y procesamos 5 bloques, ahora vamos a la un bloque de una de las entradas indirectas con eso sumamos 6, por ultimo tenemos que leer 5 bloques de la entrada indirecta simple, con eso nos da un total de 11 bloques para procesar completamente el archivo.

### b)

Usando el mismo esquema, si para 40 KB usamos 11, podemos seguir a partir de eso, seguimos en la entrada indirecta simple, leemos 10 punteros mas de la entrada que eso equivale a 10 bloques mas para cubrir los 40 KB que nos faltaban con un total de 21 bloques para procesar el archivo de 80 KB completamente.

## Ejercicio 5

Consideremos un sistema de archivos **ext2** con las siguientes especificaciones:

- 12 entradas directas, 3 indirectas simples, 1 doble indirecta y 1 triple indirecta.

y también tengamos en mente un sistema basado en **FAT**. 

Se puede considerar que si un bloque se lee dos veces, se queda cargado en memoria por lo que se busca una sola vez en disco y también se conoce el bloque inicial (en **FAT**) y el número de inodo (en **ext2**).

> **Aclaración:** las secuencias de números que se muestran en en enunciado realmente son los cadenas de bloques que componen al archivo, no distintas cantidad de bloques.

Vamos a hacer los análisis por separado.

#### FAT

1. Considerando que la **FAT** esta en memoria, tendríamos que leer  bloques ya que corresponde a la longitud de la cadena de bloques que componen el archivo.
2. Análogo al anterior serian 7 bloques los que tenemos que leer
3. Ídem anterior 3 bloques.
4. Y por último y para sorpresa de nadie serian 37 ya que los extremos se leen.

#### EXT2

Acá la cosa se pone más internaste, también podemos asumir que el inodo esta en memoria osea no requerimos accesos extra al disco.

> **Aclaración:** los bloques que puedo leer de manera directa son las numerados del 1 al 12, el resto debo usar entradas indirectas. 

1.  Aquí puedo leer los bloques del 1 hasta el 11 de manera directa osea que tendría que acceder a 6 bloques,  

> Faltan datos para este ejercicio como por ejemplo tamaño de la dirección de las LBA's, tamaño del bloque.

## Ejercicio 6

Consideremos la siguiente ruta a un archivo: **/home/aprobar.txt**.

### a) 

En un sistema basado en **FAT** queremos calcular cuantos bloques de disco se deben acceder para llegar a los bloques de datos de este archivo. 
Recordemos que tanto en **FAT** como **inodos** el directorio raíz esta distinguido, lo primero que hacemos es buscar en la **FAT** la entrada correspondiente al root, luego en el root debemos acceder al home, por lo tanto la cantidad de acceso a bloques de disco son 2, en caso de querer leerlo serian 3.

### b)

Ahora en un sistema de archivos basado en **ext2** lo que hacemos para leer /pepe.txt, el cual es un enlace simbólico del archivo mencionado antes arriba.
Como primer paso se lee el directorio root `/` tenemos que acceder al bloque distinguido, luego leemos el enlace simbólico del volver a `/` leer el bloque del home y por ultimo leer el bloque de `aprobado.txt` con lo cual accedemos a 5 bloques del disco. 

> **Aclaración:** como el ejercicio no dice que se cuanta con caché para los bloques debemos leer 2 veces el root en caso de que si hubiera serian 4 accesos a bloques ya que `/` estaría en memoria.

## Ejercicio 7

Vamos a mencionar cual es el enfoque de sistema de archivos más conveniente para los siguiente requerimientos:

1. Aquí el mejor enfoque e inclusive el único es basado en inodos ya que en un sistema basado en **FAT** no existen los enlaces simbólicos, por lo que nuestra única alternativa es basado en inodos.
2. Como requerimos que el espacio de estructuras auxiliares sea acotada nos conviene un enfoque con inodos, ya que en su conjunto los inodos resultan muchísimo más baratos en cuanto a espacio requerido, la tabla crece, ya que depende de la cantidad de bloques.
3. Como queremos que el tamaño del archivo sólo esté limitado por el tamaño del disco, es mejor un esquema **FAT** ya que un archivo puede usar tanto bloques como quiera, siempre y cuando estén disponibles, en cambio un sistema de archivos basado en inodos depende de las entradas directas, indirectas, etc.
4. Si usamos un enfoque **FAT** lo que pasa es que tenemos la información de todos los archivos del sistema de archivos. En cambio con un enfoque basado en inodos basta con tener en memoria solo los que están abierto es ese instante por lo tanto seria $O(kn)$ espacial donde $k$ es la cantidad de archivos y $n$ lo que ocupan en el peor caso. 

## Ejercicio 8

Bueno vamos con el contexto del ejercicio, tenemos los siguientes datos:

- Un disco rígido de 16 GB de espacio, el cual tiene sectores de 1 KB.
- Se desea usar el sistema de archivos **HashFS**, el cual es basado en **FAT**, el funcionamiento es que no existen directorios, ni archivos, si no que dado un path, se calcula el hash del nombre y éste indica cuál es el archivo buscado.

En cuanto al sistema de archivos utilizado tiene las siguientes particularidades:

- Se puede configurar el tamaño del bloque: 2, 4 u 8 sectores.
- Tamaño de identificadores del bloque: 8, 16, 24 o 32 bits.
- Y por último el tamaño del hash: 8, 16, 24 o 32 bits.

### a) 

En éste inciso tenemos que:

- 2 sectores por bloque, lo que nos da un bloque de 2 KB
- Un identificador de bloque de 24 bits.
- Y un hash de 16 bits.
Y nos piden que respondamos varias preguntas.

Para calcular el tamaño que ocupa la FAT tenemos que conocer cuantos bloques va a tener el sistema, teniendo en cuanta que ocupan 2 sectores de 1 KB cada uno y ademas tenemos 16 GB = 16777216 KB, eso nos da que tenemos 8388608 bloques (es la cantidad de entradas de la FAT) de 2 KB, ahora para el tamaño que ocupa la **FAT** cada entrada ocupa  24 bits, entonces son 24 bits $\times$ 8388608 bloques = 24 MB.
Para la tabla de archivos tenemos el hash ocupa 16 bits y tenemos una entrada por cada bloque de disco que son $2^{23}$  bloques por otro lado tenemos que cada entrada ocupa 16 bits o 2 bytes. Por lo tanto el tamaño total es de 16777216 bytes o 16 MB.
Por último nos preguntan cuanto disco queda libre para archivos y la respuesta es restar lo que ocupan las estructuras del **FS** a la cantidad total de disco. Por lo tanto es 16384 MB - 24 MB - 16 MB = 16344 MB libre para archivos.

### b)

Primero tenemos que detectar cuales son los puntos más importantes para la maximizar la cantidad de archivos, primero debemos minimizar la fragmentación interna los bloque serán de 2 sectores de 1 KB, es decir 2 KB, ya que si ponemos algunos mas grandes estaríamos desaprovechando espacio, ya que en promedio los archivos son de 1 KB.
En segundo lugar tenemos que maximizar los archivos eso depende exclusivamente de las entradas de la tabla hash, entre más entradas más archivos, entonces elegimos un hash de 32 bits.
Y por último para que sea posible direccionar la cantidad de bloques que resulta de particionarlo en en ¨pedazos" de 2 KB, es necesario tener los identificadores de 24 bits, teniendo en cuenta que habría $2^{23}$ bloques seria le mejor opción. 

### c)

Primero aquí nos va a convenir tener bloques más grandes, 8 sectores en este caso, lo que nos da bloques de 8 KB con esto reducimos la cantidad de bloques necesarios para almacenar un archivo, ademas de reducir el tamaño de la **FAT**, dejando más espacio libre en el disco para datos.
En segundo lugar lugar tenemos que elegir un tamaño de hash apropiado, como tenemos 16 GB ($2^{14}$ MB) de espacio de disco, y cada archivo en promedio mide 16 MB, por lo que no necesitamos un hash extremadamente, con 16 bits seria mas que suficiente, ya que si todos midieran 16 MB podría haber $2^{10}$ archivos, con 16 bits tendríamos $2^{16}$ entradas en la tabla de hash.
Por último tenemos que elegir una tamaño de identificador de bloque, teniendo en cuenta los 16 GB ($2^{34}$ Bytes) de disco, con bloques de 8 KB ($2^{13}$ Bytes), lo que nos da $2^{21}$ bloques en el sistema asi que con un hash de 24 bits seria más que suficiente.

## Ejercicio 9

Tenemos que escribir un pseudocódigo que nos permita obtener el nombre del directorio (home) a partir del descriptor de archivo recibido.

```C
char* obtenerNombre(fd_recibido) {
	// Paso 1: obtener número de inodo del archivo abierto
	mi_inodo_num = fstat(fd_recibido);
	mi_inodo = load_inode(mi_inodo_num);
	
	// Paso 2: tenemos que buscar el padre en la entrada ".."
	padre_inodo_num = buscar_padre_inodo(mi_inodo);
	pade_inodo = load_inode(padre_inodo_num);
	
	// Paso 3: buscar mi nombre en el directorio padre
	bloques_padre = padre_inodo.blocks;
	nro_bloques = padre.blocks_size;
	
	for (size_t i = 0; i < nro_bloques; i++) {
		if bloques_padre[i].inode_number == mi_inodo_num {
			return bloques_padre[i].filename;
		}
	}
	
	return NULL;
}
```

## Ejercicio 10

Primero que nada estamos ante un sistema de archivos de tipo **FAT**, ademas contamos con las siguientes funciones auxiliares:

- `FAT_entry(block_address)`: devuelve la entrada de la tabla **FAT** de la posición **block_address**.
- `raw_data = read_blocks(block_address1, block_address2,...)`: lee del disco todos los bloques que se le indiquen, en orden.
- `parse_directory_entries(raw_data)`: devuelve una lista de **struct_entrada_directorio**, donde cada elemento representa los subdirectorios del directorio pasado en raw_data.
- `raw_data = root_table()`: devuelve los datos de la tabla de directorios de root.

### a) 

Tenemos que enumerar 3 capos que debe tener **struct_entrada_directorio** podemos definir los siguientes:

- char nombre[], que indique el nombre del directorio actual.
- unsigned int tamaño
- numero de bloque inicial.

### b)

Ahora debemos escribir el pseudo-código de la función **cargar_archivo**:

```C
void* cargar_archivo(char directorios[], size_t size) {
	
	// primero obtenemos la tabla de directorios del root
	void* raw_data_root = root_table();
	
	// Ahora parseamos lo bytes crudos que nos devolvio la función anterioro
	
	struct entrada_directorio* entries = parse_directory_entries(raw_data_too);
	
	int first_block = -1;
	int j = 0;
	
	for (size_t i = 0; i < size; i++) {
		
		char* nombre_buscado = directorios[i];
		
		
		int primer_bloque = -1;
		int j = 0;
		while (entradas[j].nombre != NULL) {
			if (strcmp(entradas[j].nombre,nombre_buscado) == 0) {
				primer_bloque = entradas[j].primer_bloque;
				break;
			}
			j++
		}
		
		if (primer_bloque == -1) {
			return NULL;
		}
		
		int lista_bloques[MAX_BLOCKS];
		int idx = 0;
		int actual = primer_bloque;
		
		while (actual != EOF) {
			lista_bloques[idx] = actual;
			actual = FAT_entry(actual);
			idx++;
		}
		
		raw_data = read_blocks(lista_bloques);
	}
	
	return raw_data;
}
```