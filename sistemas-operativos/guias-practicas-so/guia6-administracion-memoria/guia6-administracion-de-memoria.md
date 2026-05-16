# Practica 6: Administración de memoria

---
## Ejercicio 1

**Fragmentación interna:** Es cuando se asigna un bloque más grande de lo necesario, con lo cual se desperdicia parte del mismo.

**Fragmentación externa:** Aquí existe suficiente espacio de memoria para ser asignado, pero no es continuo en memoria.

---
## Ejercicio 2

Tenemos un disco de 16 MB de RAM, que cuenta con particiones de 8 MB, 1 MB, 4 MB, 512 KB, 512 KB y 2 MB en ese orden.

Se desea ejecutar 5 programas de los siguientes tamaños: 500 KB, 6 MB, 3 MB, 20 KB, 4 MB en ese orden.

### a) 

Vamos a ver cómo se asignan las particiones usando **best fit**, recordemos que el mismo busca el hueco donde el proceso entre más "justo":

| Memoria del Proceso | Partición             | Fragmentación interna |
| ------------------- | --------------------- | --------------------- |
| 500 KB              | 512 KB                | 12 KB                 |
| 6 MB                | 8 MB                  | 2 MB                  |
| 3MB                 | 4 MB                  | 1 MB                  |
| 20 KB               | 512 KB                | 492 KB                |
| 4 MB                | Fragmentación interna | -                     |

En total se desperdician 3 MB + 504 KB (o **3.670.016 bytes**), además de que tenemos fragmentación interna, ya que si asignamos de otra manera el último proceso sí se podría asignar.

### b) 

Bueno, la estrategia **best fit** produce que no se puedan ejecutar los 5 programas a la vez, pero además de esa vamos a analizar **worst fit y first fit**.

#### First fit

Busca en la primera partición de 8 MB, guarda los 500 KB y la parte en 2, por lo que quedan 4 MB libres, luego sigue con P2, pero como no hay ninguna lo suficientemente grande falla y no puede cargar P2.

#### Worst fit

Busca la partición más grande disponible:

1. **P1 (500 KB):** va a la de 8 MB.

2. **P2 (6 MB):** No hay ninguna partición libre de $\leq$ 6 MB.

En conclusión todas las estrategias fallan en ejecutar los 5 programas al mismo tiempo.

### c) 

Aquí el algoritmo más eficiente fue **best fit** el cual fue capaz de ejecutar 4 de 5 programas a la vez. Y tuvo el menor desperdicio (fragmentación interna) de memoria.

---
## Ejercicio 3

Tenemos un sistema con paginación por demanda donde los procesos están haciendo accesos secuenciales con los siguientes patrones de uso:

- Uso de CPU: 20%.
- El sistema hace **thrashing**.
- Uso del resto de los dispositivos de E/S: 10%.

> **NOTA:** recordemos que el thrashing es cuando el **SO** se la pasa intercambiando páginas de memoria a disco ida y vuelta.

Tenemos que indicar si con alguno de estos cambios mejoraría la utilización de CPU:

- **a)** Con este cambio no mejoraría debido a que el problema no es la velocidad de la CPU sino el porcentaje de utilización, con lo cual habría más cuello de botella, además de que la CPU pasará más tiempo ociosa ya que tiene que procesar las mismas instrucciones.

- **b)** Instalar páginas más grandes en un sistema con thrashing no es una solución mágica. Aunque podría reducir la cantidad total de fallos de página (porque cada fallo trae más datos), el costo de cada fallo aumenta y la eficiencia del uso de RAM disminuye. La CPU seguirá ociosa porque el cuello de botella (el disco) ahora tiene que trabajar más por cada petición.

- **c)** Este cambio empeora el problema. Si agregamos más procesos, habrá menos memoria disponible para cada uno, aumentando los fallos de páginas y el thrashing.

- **d)** En este caso sí mejoraría la utilización de CPU, debido a que habría menos procesos en memoria simultáneamente, por lo que los procesos que están en memoria reciben más marcos de página. Esto reduce los fallos de página y permite que la CPU trabaje más tiempo.

- **e)** Esta es la solución ideal ya que elimina el thrashing de raíz porque tenemos mucha más capacidad para tener procesos usando memoria simultáneamente, por lo tanto el procesador se utilizaría más.

- **f)** Ayudaría pero es un parche. La CPU pasará menos tiempo esperando que se resuelvan los fallos de página, aunque el thrashing técnicamente sigue ocurriendo.

- **g)** No, lo único que haría sería incrementar la fragmentación interna y aumentar el tiempo de transferencia por cada fallo de página.

- **h)** Similar al disco más rápido: acelera la comunicación entre el disco y la RAM, reduciendo el tiempo de espera de la CPU.

---
## Ejercicio 4

Un page fault puede producirse bajo varias circunstancias, aquí vamos a verlas todas:


1. Paginación por Demanda

En los sistemas modernos, el **SO** no carga todo el programa en la RAM al inicio, solo carga las páginas que requiere para comenzar y luego va cargando bajo demanda utilizando el bit de validez o presencia.


2. Página enviada al SWAP

Cuando la RAM se llena, el **SO** utiliza algoritmos de reemplazo para mover páginas que no se están usando mucho hacia el área de intercambio o swap en el disco.

3. Copy-on-Write

Es una técnica de optimización que usan sistemas como Linux cuando se crea un proceso hijo: se hace una copia de sus tablas de páginas, con el fin de ahorrar memoria, pero cuando alguno de los dos modifica alguna de las páginas compartidas, se invalida la del otro proceso, y cuando el que invalidó intenta acceder ocurre un page fault y se copia la página modificada.

Las acciones que realiza el sistema operativo se dan mediante la **MMU** y la **ISR**. Cuando la **MMU** detecta la invalidez de la página lanza una excepción que transfiere el control al kernel. Allí es donde entra en juego la **ISR** y activa el handler que resuelve la interrupción de page fault.

---
## Ejercicio 5

Consideremos la siguiente secuencia de referencias a páginas:

1, 2, 3, 4, 2, 1, 5, 6, 2, 1, 2, 3, 7, 6, 3, 2, 1, 2, 3, 6

> **Aclaración:** para simplificar el ejercicio vamos a hacerlo con 1, 3 y 7 frames.

### Con reemplazo LRU

Tenemos la siguiente tabla:

| Secuencia |    1 Frame    | 3 Frames          |           7 Frames            |
| :-------: | :-----------: | :---------------- | :---------------------------: |
|   **1**   |  `[1]` **F**  | `[1, , ]` **F**   | `[1,  ,  ,  ,  ,  ,  ]` **F** |
|   **2**   |  `[2]` **F**  | `[1, 2, ] ` **F** | `[1, 2,  ,  ,  ,  ,  ]` **F** |
|   **3**   |  `[3]` **F**  | `[1, 2, 3]` **F** | `[1, 2, 3,  ,  ,  ,  ]` **F** |
|   **4**   |  `[4]` **F**  | `[4, 2, 3]` **F** | `[1, 2, 3, 4,  ,  ,  ]` **F** |
|   **2**   |  `[2]` **F**  | `[4, 2, 3]` **H** | `[1, 2, 3, 4,  ,  ,  ]` **H** |
|   **1**   |  `[1]` **F**  | `[4, 2, 1]` **F** | `[1, 2, 3, 4,  ,  ,  ]` **H** |
|   **5**   |  `[5]` **F**  | `[5, 2, 1]` **F** | `[1, 2, 3, 4, 5,  ,  ]` **F** |
|   **6**   |  `[6]` **F**  | `[5, 6, 1]` **F** | `[1, 2, 3, 4, 5, 6,  ]` **F** |
|   **2**   |  `[2]` **F**  | `[5, 6, 2]` **F** | `[1, 2, 3, 4, 5, 6,  ]` **H** |
|   **1**   |  `[1]` **F**  | `[1, 6, 2]` **F** | `[1, 2, 3, 4, 5, 6,  ]` **H** |
|   **2**   |  `[2]` **F**  | `[1, 6, 2]` **H** | `[1, 2, 3, 4, 5, 6,  ]` **H** |
|   **3**   |  `[3]` **F**  | `[1, 3, 2]` **F** | `[1, 2, 3, 4, 5, 6, ]` **H**  |
|   **7**   |  `[7]` **F**  | `[7, 3, 2]` **F** | `[1, 2, 3, 4, 5, 6, 7]` **F** |
|   **6**   |  `[6]` **F**  | `[7, 3, 6]` **F** | `[1, 2, 3, 4, 5, 6, 7]` **H** |
|   **3**   |  `[3]` **F**  | `[7, 3, 6]` **H** | `[1, 2, 3, 4, 5, 6, 7]` **H** |
|   **2**   |  `[2]` **F**  | `[2, 3, 6]` **F** | `[1, 2, 3, 4, 5, 6, 7]` **H** |
|   **1**   |  `[1]` **F**  | `[2, 3, 1]` **F** | `[1, 2, 3, 4, 5, 6, 7]` **H** |
|   **2**   |  `[2]` **F**  | `[2, 3, 1]` **H** | `[1, 2, 3, 4, 5, 6, 7]` **H** |
|   **3**   |  `[3]` **F**  | `[2, 3, 1]` **H** | `[1, 2, 3, 4, 5, 6, 7]` **H** |
|   **6**   |  `[6]` **F**  | `[2, 3, 6]` **F** | `[1, 2, 3, 4, 5, 6, 7]` **H** |
| **TOTAL** | **20 Fallos** | **15 Fallos**     |         **7 Fallos**          |

### Con reemplazo FIFO

| Secuencia |    1 Frame    | 3 Frames          |           7 Frames            |
| :-------: | :-----------: | :---------------- | :---------------------------: |
|   **1**   |  `[1]` **F**  | `[1, , ]` **F**   | `[1,  ,  ,  ,  ,  ,  ]` **F** |
|   **2**   |  `[2]` **F**  | `[1, 2, ]` **F**  | `[1, 2,  ,  ,  ,  ,  ]` **F** |
|   **3**   |  `[3]` **F**  | `[1, 2, 3]` **F** | `[1, 2, 3,  ,  ,  ,  ]` **F** |
|   **4**   |  `[4]` **F**  | `[4, 2, 3]` **F** | `[1, 2, 3, 4,  ,  ,  ]` **F** |
|   **2**   |  `[2]` **F**  | `[4, 2, 3]` **H** | `[1, 2, 3, 4,  ,  ,  ]` **H** |
|   **1**   |  `[1]` **F**  | `[4, 1, 3]` **F** | `[1, 2, 3, 4,  ,  ,  ]` **H** |
|   **5**   |  `[5]` **F**  | `[4, 1, 5]` **F** | `[1, 2, 3, 4, 5,  ,  ]` **F** |
|   **6**   |  `[6]` **F**  | `[6, 1, 5]` **F** | `[1, 2, 3, 4, 5, 6,  ]` **F** |
|   **2**   |  `[2]` **F**  | `[6, 2, 5]` **F** | `[1, 2, 3, 4, 5, 6,  ]` **H** |
|   **1**   |  `[1]` **F**  | `[6, 2, 1]` **F** | `[1, 2, 3, 4, 5, 6,  ]` **H** |
|   **2**   |  `[2]` **F**  | `[6, 2, 1]` **H** | `[1, 2, 3, 4, 5, 6,  ]` **H** |
|   **3**   |  `[3]` **F**  | `[3, 2, 1]` **F** | `[1, 2, 3, 4, 5, 6, ]` **H**  |
|   **7**   |  `[7]` **F**  | `[3, 7, 1]` **F** | `[1, 2, 3, 4, 5, 6, 7]` **F** |
|   **6**   |  `[6]` **F**  | `[3, 7, 6]` **F** | `[1, 2, 3, 4, 5, 6, 7]` **H** |
|   **3**   |  `[3]` **F**  | `[3, 7, 6]` **H** | `[1, 2, 3, 4, 5, 6, 7]` **H** |
|   **2**   |  `[2]` **F**  | `[2, 7, 6]` **F** | `[1, 2, 3, 4, 5, 6, 7]` **H** |
|   **1**   |  `[1]` **F**  | `[2, 1, 6]` **F** | `[1, 2, 3, 4, 5, 6, 7]` **H** |
|   **2**   |  `[2]` **F**  | `[2, 1, 6]` **F** | `[1, 2, 3, 4, 5, 6, 7]` **H** |
|   **3**   |  `[3]` **F**  | `[2, 1, 3]` **F** | `[1, 2, 3, 4, 5, 6, 7]` **H** |
|   **6**   |  `[6]` **F**  | `[6, 1, 3]` **F** | `[1, 2, 3, 4, 5, 6, 7]` **H** |
| **TOTAL** | **20 Fallos** | **17 Fallos**     |         **7 Fallos**          |

### Reemplazo Second Chance

La simulación con 1 frame y con 7 frames es igual que los casos anteriores, vamos a ver el caso más interesante que es con 3 frames:

| Secuencia | RAM [Frame 1, 2, 3] | Bit de Ref  |    ¿Fallo?    |
| :-------: | :-----------------: | :---------: | :-----------: |
|   **1**   |     `[1,  ,  ]`     | `[1,  ,  ]` |     **F**     |
|   **2**   |     `[1, 2,  ]`     | `[1, 1,  ]` |     **F**     |
|   **3**   |     `[1, 2, 3]`     | `[1, 1, 1]` |     **F**     |
|   **4**   |     `[4, 2, 3]`     | `[1, 0, 0]` |     **F**     |
|   **2**   |     `[4, 2, 3]`     | `[1, 1, 0]` |     **H**     |
|   **1**   |     `[4, 2, 1]`     | `[1, 1, 1]` |     **F**     |
|   **5**   |     `[5, 2, 1]`     | `[1, 0, 0]` |     **F**     |
|   **6**   |     `[5, 6, 1]`     | `[1, 1, 0]` |     **F**     |
|   **2**   |     `[5, 6, 2]`     | `[1, 1, 1]` |     **F**     |
|   **1**   |     `[1, 6, 2]`     | `[1, 0, 0]` |     **F**     |
|   **2**   |     `[1, 6, 2]`     | `[1, 0, 1]` |     **H**     |
|   **3**   |     `[1, 3, 2]`     | `[1, 1, 1]` |     **F**     |
|   **7**   |     `[7, 3, 2]`     | `[1, 0, 0]` |     **F**     |
|   **6**   |     `[7, 6, 2]`     | `[1, 1, 0]` |     **F**     |
|   **3**   |     `[7, 6, 3]`     | `[1, 1, 1]` |     **F**     |
|   **2**   |     `[2, 6, 3]`     | `[1, 0, 0]` |     **F**     |
|   **1**   |     `[2, 1, 3]`     | `[1, 1, 0]` |     **F**     |
|   **2**   |     `[2, 1, 3]`     | `[1, 1, 0]` |     **H**     |
|   **3**   |     `[2, 1, 3]`     | `[1, 1, 1]` |     **H**     |
|   **6**   |     `[6, 1, 3]`     | `[1, 0, 0]` |     **F**     |
| **TOTAL** |                     |             | **16 Fallos** |

---
## Ejercicio 6

Supongamos que tenemos largas repeticiones de secuencias de referencias a páginas seguidas $0, 1, \cdots, 511$ y ocasionalmente aparecen las páginas 332 y 431, tenemos que responder unas preguntas:

### a)

Si tenemos que la cantidad de frames es menor que la longitud de la secuencia, entonces **LRU**, **FIFO** o **Second Chance** no serían efectivos por las siguientes razones:

- **LRU:** En una secuencia circular, la página que vas a necesitar a continuación es, por definición, la que usaste hace más tiempo en el ciclo anterior. Y si tenemos menos frames que longitud de secuencia, entonces LRU hace exactamente lo incorrecto: expulsa la página que vas a usar inmediatamente.

- **FIFO:** Sufre del mismo problema. La página que entró primero al principio del ciclo es la primera en ser reemplazada y la primera que se requiere al iniciar el ciclo, al sacarla garantizas un **page fault** en cada paso.

- **Second Chance:** Como todas las páginas de la secuencia $0, \cdots, 511$ se usaron una vez, todas tendrán su bit de referencia en 1. Cuando llegue la página 511, el puntero dará toda la vuelta, pondrá todos los bits en 0 y terminará sacando la más vieja, comportándose igual que FIFO.

### b) 

Suponiendo que tuviésemos exactamente 500 frames disponibles, tenemos que dar un algoritmo que se comporte mejor que los 3 anteriores.

El enfoque más práctico sería un algoritmo inverso a LRU, es decir Most Recently Used (MRU). ¿Por qué? Si miramos la secuencia, si desalojamos las más viejas entonces estaremos comprometiendo el ciclo de la secuencia, en cambio si desalojamos las páginas más nuevas, entonces mantenemos la integridad del ciclo, por lo tanto sería un enfoque más óptimo, teniendo en cuenta que tenemos menos frames que la longitud de la secuencia.

---
## Ejercicio 7

Tenemos que un proceso tiene 3 frames disponibles, y la cadena de referencias contiene números de página del conjunto $\{0,1,2,3\}$. Con esto debemos dar una secuencia de referencias a páginas donde la primera página seleccionada sea distinta en LRU y Second Chance.

$1,2,3,1,2,0$

| **Secuencia** | **LRU**           | **Second Chance** |
| ------------- | ----------------- | ----------------- |
| **1**         | `[1, , ]` **F**   | `[1, , ]` **F**   |
| **2**         | `[1, 2, ]` **F**  | `[1, 2, ]` **F**  |
| **3**         | `[1, 2, 3]` **F** | `[1, 2, 3]` **F** |
| **1**         | `[1, 2, 3]` **H** | `[1, 2, 3]` **H** |
| **2**         | `[1, 2, 3]` **H** | `[1, 2, 3]` **H** |
| **0**         | `[1, 2, 0]` **F** | `[0, 2, 3]` **F** |

---
## Ejercicio 8

### a)

**FIFO:** El atributo que utiliza FIFO es la antigüedad cronológica de entrada de la página a la memoria RAM. Para implementarlo el **SO** maneja una estructura de datos lineal simple (como una cola FIFO o un puntero circular que avanza linealmente por los frames).

**LRU:** Para LRU el atributo es el tiempo transcurrido desde el último acceso a la página.

**Second Chance:** Utiliza el mismo atributo que FIFO, junto con un bit de "supervivencia" que utiliza para no desalojar la página a la primera oportunidad.

### b)

Tenemos que pensar el algoritmo genérico el cual sirva para implementar los tres algoritmos:

```C
// Struct genérica de un marco de memoria (Frame)
struct Frame {
	int pagina_id;
	bool ocupado;
	void* atributo_remplazo;
};

// Algoritmo de reemplazo genérico
Frame* buscar_victima_generica(Frame tabla_frames[], int cantidad_frames) {
	Frame* victima = NULL;
	
	// Si hay algún frame libre, entonces no reemplazamos nada y utilizamos ese
	for (int i = 0; i < cantidad_frames; i++) {
		if (!tabla_frames[i].ocupado) {
			// Si no está ocupado lo ponemos ahí
			return &tabla_frames[i];
		}
	}
	
	// Si no hay libres, entonces tenemos que usar el criterio
	victima = aplicar_criterio_remplazo(tabla_frames, cantidad_frames);
	return victima;
}
```

---
## Ejercicio 9

Tenemos una computadora con 4 marcos de página. Y contamos con la siguiente tabla:

| **Page** | **Loaded** | **Last Ref.** | **R** |
| -------- | ---------- | ------------- | ----- |
| 0        | 126        | 280           | 1     |
| 1        | 230        | 265           | 0     |
| 2        | 140        | 270           | 0     |
| 3        | 110        | 285           | 1     |

Ahora tenemos que decidir qué página se reemplazará en cada algoritmo.

### a)

En el algoritmo FIFO la página que se reemplazará será la página 1, ya que tiene el mayor tiempo de carga y por lo tanto fue la primera en entrar, siguiendo el criterio FIFO esa será reemplazada.

### b)

En el algoritmo LRU la página que será reemplazada es la página 3, ya que tiene el mayor tiempo de acceso de las 4, entonces aplicando criterio LRU, es la menos probable que se use en el futuro próximo.

### c)

En el algoritmo Second Chance será la misma que en FIFO ya que tiene el mayor tiempo de carga y además tiene el bit R en 0, por lo tanto no tiene segunda oportunidad.

---
## Ejercicio 10

Tenemos una matriz de 100 * 100, que está cargada en la posición 200, en un sistema de memoria paginada con páginas de tamaño 200. Un proceso de manipulación de matrices se encuentra cargado en la primera página, de la posición 0 a 199, por lo que todo fetch de instrucciones es a la misma página.
Solo tenemos 3 frames, queremos ver cuántos fallos de páginas van a ser generados con el siguiente algoritmo utilizando un criterio LRU:

> **Nota:** podemos suponer que el programa se encuentra en el primer frame y los otros 2 están libres.

### a)

```C
for (int j = 0; j < 100; j++) {
	for (int i = 0; i < 100; i++) {
		A[i][j] = 0;
	}
}
```

Sabemos que el tamaño de un int es 4 bytes, y sabemos que cada fila de la matriz tiene 100 elementos, por lo tanto cada fila ocupa 400 bytes. En total la matriz ocupa 40.000 bytes, teniendo en cuenta que cada página tiene tamaño 200 bytes, en total la matriz ocupa 200 páginas, también `A[0][0]` está en la posición 200. Tenemos que la distribución de las páginas es así:

```plaintext
Página 1: A[0][0] ... A[0][49] (columnas 0-49 de fila 0) 
Página 2: A[0][50] ... A[0][99] (columnas 50-99 de fila 0) 
Página 3: A[1][0] ... A[1][49] 
Página 4: A[1][50] ... A[1][99] 
...
```

Por lo tanto cada fila ocupa 2 páginas. Cada página tiene 50 elementos consecutivos de la misma fila.
Viendo el for nos damos cuenta de que el acceso es el siguiente:

```plaintext
A[0][0], A[1][0], A[2][0], ... A[99][0],
A[0][1], A[1][1], A[2][1], ... A[99][1],
...
```

Para cada `A[i][j]`, la página accedida es:
`página = 1 + i*2 + (j >= 50 ? 1 : 0)`

Vamos con el conteo de fallos, tenemos lo siguiente:

- `A[0][0]` -> página 1 -> **FALLO** -> frames: {prog, p1, -}.
- `A[1][0]` -> página 3 -> **FALLO** -> frames: {prog, p1, p3}
- `A[2][0]` -> página 5 -> **FALLO** -> frames: {prog, p5, p3}
- `A[3][0]` -> página 7 -> **FALLO** -> frames: {prog, p5, p7}
- ...

Entonces para j = 0, contamos 100 **FALLOS**, es decir uno por cada fila, pero notemos que con j = 1 pasa lo mismo, entonces también uno por cada columna, por lo tanto tenemos 100 * 100 fallos = 10.000 fallos.

### b)

Ahora tenemos el siguiente ciclo:

```C
for (int i = 0; i < 100; i++) {
	for (int j = 0; j < 100; j++) {
		A[i][j] = 0;
	}
}
```

Es la misma idea que el anterior, analicemos los accesos:

```plaintext
A[0][0], A[0][1], A[0][2], ... , A[0][99].
A[1][0], A[1][1], A[1][2], ... , A[1][99].
A[2][0], A[2][1], A[2][2], ... , A[2][99].
...
A[99][0], A[99][1], A[99][2], ... , A[99][99].
```

Es decir primero accedemos a toda la fila y luego cambiamos de columna, entonces para cada `A[i][j]` la página accedida es:

`página = 1 + i*2 + (j >= 50 ? 1 : 0)`

Vamos con el conteo de fallos:

- `A[0][0]` -> página 1 -> **FALLO** -> frames: {prog, p1, -}.
- `A[0][1]` -> página 1 -> **HIT** -> frames: {prog, p1, -}.
- ...
- `A[0][50]` -> página 2 -> **FALLO** -> frames: {prog, p1, p2}.

Entonces notemos que cada vez que recorremos una fila completa tenemos 2 fallos, por lo tanto 2 fallos/fila * 100 filas = 200 fallos.

---
## Ejercicio 11

### 1. Llamadas al sistema a modificar

#### `fork()`

Es la llamada principal a modificar. Sin CoW, `fork()` copia todas las páginas del padre al hijo. Con CoW, en cambio:

- El hijo comparte las mismas páginas físicas que el padre.
- Ambas tablas de páginas (padre e hijo) apuntan a los mismos frames.
- Todas las páginas compartidas se marcan como **solo lectura** en ambas tablas.
- La copia física se posterga hasta que alguno de los dos procesos intente escribir.

#### `exec()`

Luego de un `fork()`, es común que el hijo llame a `exec()` para reemplazar su imagen. Con CoW, si el hijo ejecuta `exec()` antes de escribir en cualquier página, **nunca se realizó ninguna copia**, lo que hace que la combinación `fork()` + `exec()` sea muy eficiente.

#### Manejador de excepciones / page fault handler

Se debe modificar el manejador de fallos de página para distinguir entre:

- Un fallo por página no presente en memoria (caso habitual).
- Un fallo por intento de **escritura en página marcada como solo lectura** → esto indica que se debe realizar la copia CoW.

En este segundo caso, el handler debe:

1. Verificar que la página tiene el bit CoW activo.
2. Alojar un nuevo frame físico.
3. Copiar el contenido de la página original al nuevo frame.
4. Actualizar la tabla de páginas del proceso que escribió para apuntar al nuevo frame.
5. Marcar la nueva página como **lectura/escritura**.
6. Decrementar el contador de referencias de la página original.
7. Si el contador llega a 1 (solo queda un proceso usando esa página), quitarle la protección de solo lectura al otro proceso también.

---

### 2. Cambios de hardware

#### Bit de protección de escritura (Write-Protect bit)

El hardware de MMU debe soportar marcar páginas como **solo lectura**. En arquitecturas como x86 esto ya existe mediante el bit W/R en las entradas de la tabla de páginas (PTE). Si el hardware no lo soporta, no es posible implementar CoW sin emulación por software.

#### Generación de excepción por escritura en página protegida

Cuando un proceso intenta escribir en una página marcada como solo lectura, la MMU debe generar una **excepción de protección** (protection fault) que el SO pueda interceptar. Esta excepción es la que dispara el mecanismo CoW en el page fault handler.

#### TLB (Translation Lookaside Buffer)

Luego de realizar la copia y actualizar la PTE, es necesario **invalidar la entrada correspondiente en el TLB** para que la MMU no siga usando la traducción vieja. Esto puede hacerse con instrucciones específicas del hardware (ej: `invlpg` en x86).

---

### 3. Cambios en el manejo de páginas y segmentos

#### Bit CoW en la PTE

Se necesita un bit adicional en cada entrada de la tabla de páginas para indicar que esa página está bajo semántica CoW. Esto permite distinguir en el page fault handler si una escritura fallida es un error de acceso real o una copia CoW pendiente.

#### Contador de referencias por frame físico

Se debe mantener un **contador de referencias** por cada frame físico que indique cuántos procesos están mapeando ese frame. Esto es necesario para saber:

- Cuándo liberar el frame (cuando el contador llega a 0).
- Cuándo ya no es necesario proteger la página (cuando el contador llega a 1, el único proceso restante puede escribir libremente).

#### Tabla de páginas del hijo en `fork()`

Al hacer `fork()`, en lugar de copiar los frames:

1. Se copia la tabla de páginas del padre al hijo.
2. En ambas tablas, todas las páginas escribibles se marcan como **solo lectura + CoW**.
3. Se incrementa el contador de referencias de cada frame compartido.

#### Manejo de páginas ya de solo lectura

Las páginas que ya eran de solo lectura antes del `fork()` (por ejemplo, segmento de código) **no necesitan el bit CoW**, ya que ningún proceso puede escribir en ellas de todas formas. Se comparten directamente sin marcarlas como CoW.

#### Segmentos

- **Segmento de código (text):** ya es de solo lectura, se comparte sin CoW.
- **Segmento de datos y heap:** se marca con CoW, se copia al primer intento de escritura.
- **Stack:** se marca con CoW por cada página de stack activa al momento del `fork()`.

---
## Ejercicio 12

Tenemos 2 sistemas embebidos:

- **A:** Hace procesamiento secuencial de archivos. Los bloques que se leen, se procesan y se escriben.
- **B:** Medidor del clima. Contamos con un proceso principal que detecta fenómenos meteorológicos y lanza programas específicos para hacer mediciones apropiadas. El clima puede cambiar abruptamente.

Ahora debemos justificar cuál de las políticas de reemplazo serían o no apropiadas en cada caso.

### a)

En el sistema **A** los bloques de datos se leen, se procesan y se escriben de manera secuencial y lineal, con lo cual es muy probable que vuelva a necesitar el bloque anterior en el corto plazo. Con lo cual un algoritmo **MRU** es ideal en este esquema, ya que la inmediatamente anterior es poco probable que se vuelva a usar en el futuro cercano y es justo la mejor candidata a ser desalojada si el sistema se queda sin memoria.

En cambio en el sistema **B** es sumamente inapropiado. Para sistemas reactivos basados en ráfagas de eventos, se necesita proteger el "conjunto de trabajo" actual del proceso mediante políticas que respeten la localidad temporal.

### b)

Esta política es ideal para el sistema **B** ya que mantiene en memoria las páginas que forman parte del conjunto de trabajo del subproceso correspondiente al clima, esto asegura que lo que se está usando de manera más intensiva permanezca en memoria RAM.
En cambio con el sistema **A** pasa todo lo contrario, como ya expliqué en el inciso anterior, por lo tanto es una política sumamente inapropiada para este sistema.

### c) 

El diseño de políticas de reemplazo de páginas en sistemas embebidos depende enteramente del patrón de acceso a la memoria que requiera cada aplicación. En el **Sistema A**, orientado al procesamiento secuencial de archivos, el comportamiento es lineal y predecible: una vez que un bloque de datos se lee, se procesa y se escribe, el programa pasa al siguiente elemento y no vuelve a requerir la información anterior. Para este escenario, la política de **bajar la página más recientemente usada (MRU)** resulta óptima, ya que desaloja de inmediato la página que acaba de cumplir su ciclo de uso, dejando espacio libre para los nuevos bloques que ingresan secuencialmente.

Por el contrario, el **Sistema B** funciona como un medidor de clima reactivo, donde un proceso principal debe lanzar subprogramas específicos de manera inmediata ante cambios meteorológicos abruptos. En este caso, la política de **Segunda Oportunidad combinada con el uso de páginas estáticas** es la más adecuada. Por un lado, el mecanismo de segunda oportunidad protege el conjunto de trabajo activo evitando que el sistema expulse código que está en uso intensivo durante la medición. Por el otro, al priorizar el desalojo de páginas estáticas (aquellas de solo lectura que nunca fueron modificadas, como el segmento de código de tareas inactivas), el sistema operativo puede simplemente borrarlas de la RAM sin perder valiosos milisegundos escribiendo datos de descarte en el almacenamiento físico, garantizando así la respuesta inmediata que el entorno exige.

---
## Ejercicio 13

Supongamos que tenemos un sistema de 2 MB de RAM y se desea ejecutar un programa de 4 MB ubicado en un disco de 200 GB.

### a)

El mecanismo se basa en la **Memoria Virtual con Paginación por Demanda**. Permite la ejecución porque el programa nunca necesita sus 4 MB de instrucciones al mismo milisegundo; solo necesita un pequeño conjunto activo (llamado _Working Set_). El **Swapping** es el proceso de intercambio físico que usa el disco de 200 GB como una extensión "lenta" de la RAM para mover esas páginas hacia adentro y hacia afuera a medida que el programa las va demandando.

### b)

Teniendo que el tamaño del frame es de 4 KB y suponiendo que el programa ejecuta todo su código tarde o temprano, queremos ver cuántos fallos de página se producirán como mínimo. Veamos cuántas páginas ocupa el programa y cuántos frames tiene la RAM: el programa tiene 1024 páginas y la RAM tiene 512 frames de página. Entonces suponiendo una ejecución ideal que ejecute la página 0, 1, 2, ..., 1024 sin repetir ninguna, y suponiendo que la RAM comienza vacía, las primeras 512 páginas van a tener fallos, luego cuando llegue a la 512, va a haber un fallo para cada página sucesora secuencial, por lo tanto tendría 1024 fallos en el caso ideal (probablemente sean más).

### c) 

Vamos a ver los siguientes ejemplos:

#### 1. Ejecución de múltiples instancias del mismo programa

Por ejemplo tomemos como programa la terminal **st**, cuando abro $n$ terminales distintas, el código de instrucciones (en el segmento `.text`) es exactamente el mismo para todas las instancias. Como el código compilado es de solo lectura, no tiene ningún sentido duplicarlo en diferentes sectores de la RAM física.

La idea de cómo funciona es que el **SO** mapea las tablas de páginas de todos estos procesos independientes para que apunten a los mismos marcos (frames) físicos de memoria donde se cargó el código la primera vez.

#### 2. Optimización en la clonación de procesos

Cuando un proceso padre crea un hijo mediante `fork()`, el hijo hereda una copia idéntica de su memoria. En sistemas antiguos, el kernel copiaba físicamente toda la RAM del padre al hijo ($O(N)$), lo cual era sumamente ineficiente porque casi siempre el hijo ejecuta inmediatamente un `exec()` para cargar un programa nuevo, destruyendo toda la memoria recién copiada.
