# Administración de Memoria

La administración de memoria presenta una serie de problemas, los cuales son los siguientes:

- Cómo nos aseguramos de que un proceso no lea los datos de otro.
- Cómo sabemos qué pedazos de memoria tenemos libres y en dónde conviene ubicar un programa.

Más concretamente, estos problemas son conocidos como:

- **Reubicación** (cambio de contexto, swapping).
- **Protección** (memoria privada de los procesos).
- **Manejo del espacio libre** (evitando la fragmentación).

Vamos de cabeza con esta última.

---

## Fragmentación de Memoria

La fragmentación es un problema ya que podría generar situaciones donde tenemos suficiente memoria para atender una solicitud, pero no es continua. Esto con el tiempo puede volverse muy grave, ya que básicamente se nos licuan los recursos del **SO**.

Una alternativa sería compactar, pero esto requiere reubicación, la cual es muy costosa en tiempo y en un **SO** RT es imposible.

En general tenemos 2 tipos de fragmentación:

| Tipo | Descripción |
|------|-------------|
| **Fragmentación Externa** | Existe suficiente espacio de memoria total pero no es continuo. |
| **Fragmentación Interna** | Se asigna un bloque más grande de lo necesario, desperdiciando parte del mismo. |

Uno de los primeros enfoques realistas, el cual es muy usado, consiste en organizar la memoria de la siguiente manera.

---

## Organización de Memoria

<p align="center">
  <img src="https://github.com/user-attachments/assets/84d9997d-19f2-41fd-a106-c0c210b3fa83" alt="Organización de memoria">
</p>

Esta organización se relaciona estrechamente con la fragmentación debido a que:

1. **Crecimiento opuesto:** El **Heap** crece hacia direcciones más altas y el **Stack** hacia direcciones más bajas, aprovechando mejor el espacio libre central.
2. **Fragmentación en el Heap:** La fragmentación ocurre principalmente dentro del **Heap**.
3. **Memoria Virtual:** Lo que vemos en la imagen no es más que una ilusión del **SO** hacia cada proceso. El proceso cree que tiene todo ese espacio continuo para él solo, pero en la memoria física real, esos pedazos (páginas) pueden estar separados.

---

## Cómo Organizar la Memoria

A continuación vamos a ver distintos métodos de organización de memoria. Para esta explicación me voy a basar en el libro **Modern Operating Systems, Andrew S. Tanenbaum**.

### Gestión de Memoria con Bitmaps

Con un bitmap, la memoria se divide en unidades de asignación tan pequeñas como unas pocas palabras o tan grandes como varios **KB**. A cada unidad le corresponde un bit en el bitmap: `0` si está libre, `1` si está ocupada.

<p align="center">
  <img src="https://github.com/user-attachments/assets/a4f5063a-074b-43e7-b03d-957adc0f6816" alt="Representación de un bitmap">
</p>

- **a)** Una parte de la memoria con cinco procesos y tres huecos. Las marcas (*ticks*) muestran las unidades de asignación. Las regiones sombreadas están libres.
- **b)** El mapa de bits correspondiente.
- **c)** La misma información representada como una lista.

El tamaño de la unidad de asignación es una cuestión de diseño importante. Con unidades de 4 bytes, una memoria de **32n** bits usará **n** bits del mapa (solo el 1/32 del total). Si la unidad es muy grande, el bitmap es más pequeño pero puede desperdiciar memoria apreciable.

> **Problema principal:** cuando se debe alojar un proceso de $k$ unidades, el gestor debe buscar en el bitmap una secuencia de $k$ bits libres consecutivos, lo cual es una operación lenta.

---

### Gestión de Memoria con Listas Enlazadas

Otra forma de llevar registro de la memoria es mantener una lista enlazada de segmentos asignados y libres, donde cada segmento contiene un proceso o un hueco vacío entre dos procesos.

> **Nota:** En la imagen anterior también se representa el bitmap como una lista enlazada.

La lista se mantiene ordenada por dirección, lo que facilita la actualización cuando un proceso termina o es movido al disco. Un proceso que termina normalmente tiene dos vecinos (procesos o huecos), dando lugar a las 4 combinaciones de la imagen.

<p align="center">
  <img src="https://github.com/user-attachments/assets/8e0c6061-f0cc-458f-8129-210e300ac574" alt="Representación de una lista enlazada">
</p>

- Liberar un bloque es $O(1)$: es una simple operación de punteros.
- Asignar es similar, pero hay que encontrar el lugar adecuado.

---

### Algoritmos de Asignación

Cuando los procesos y huecos se mantienen en una lista ordenada por dirección, se pueden usar varios algoritmos para asignar memoria:

**First Fit (Primer ajuste)**
El gestor escanea la lista buscando el primer hueco lo suficientemente grande, lo divide en dos (una parte para el proceso, otra queda libre) y termina. Es rápido porque busca lo menos posible.

**Next Fit (Siguiente ajuste)**
Igual que First Fit, pero recuerda dónde quedó la última búsqueda y comienza desde ahí la próxima vez.

> **Aclaración:** estas dos últimas las saqué de las diapos, no las encontré en el libro.

**Best Fit (Mejor ajuste)**
Busca el hueco donde el proceso entre más justo. Es más lento que First Fit y tampoco necesariamente mejor, ya que llena la memoria de pequeños bloques inservibles.

**Quick Fit (Ajuste rápido)**
Mantiene listas separadas de bloques libres por los tamaños más frecuentemente solicitados, permitiendo una búsqueda más directa.

**Buddy System**
Usa splitting de bloques en potencias de 2. Cuando se necesita un bloque de tamaño $n$, se divide el bloque disponible más pequeño que lo contenga. Al liberar, se fusionan bloques "buddies" adyacentes.

> Todos estos esquemas tienen sus limitaciones: algunos producen fragmentación externa, otros fragmentación interna, ninguno es perfecto.

---

## Memoria Virtual

Anteriormente mencionamos el problema de la **reubicación**, el cual va de la mano con otro: si tengo $N$ bytes de memoria y un programa de tamaño $M > N$ pero que no necesita más de $K < N$ bytes a la vez, debería poder correrlo. La solución es la **memoria virtual**.

Su implementación requiere ayuda del **HW**, más concretamente una unidad llamada **Memory Management Unit (MMU)**. De manera simplificada, así funciona el acceso a una celda con memoria virtual:

1. El **CPU** calcula la dirección según la arquitectura.
2. El **CPU** le pasa la dirección virtual a la **MMU**.
3. La **MMU** consulta la tabla de traducciones (que tiene un bit indicando si la página está en memoria o no) y calcula la dirección física.
4. La dirección física se pone en el bus que llega hasta la placa de memoria.
5. Se obtiene el contenido.

Con memoria virtual disponemos de "más" direcciones, ya que tenemos el tamaño de la memoria física más el swap. Además, la programación se hace íntegramente mediante direcciones virtuales.

---

### Detalles del Esquema de Memoria Virtual

- La memoria virtual está dividida en **páginas** de tamaño fijo. La **MMU** traduce páginas a *frames* interpretando las direcciones como `página + offset`, donde los $n$ bits más significativos identifican la página y el resto es el offset.
- Siempre se swappean páginas completas.
- Cuando una página no está en memoria, la **MMU** emite un **page fault** (interrupción del **SO**).
- El **SO** es el encargado del *replacement* de páginas, lo que introduce el problema de decidir cuál sacar.

A continuación un esquema de cómo se asignan las páginas:

<p align="center">
  <img src="https://github.com/user-attachments/assets/38c97dac-e406-4b8d-82e9-f9c0da8c6a30" alt="Asignación de páginas">
</p>

---

## Manejando la MMU

En esencia la **MMU** es la tabla de páginas que se usa para el mapeo. Lo ideal es que la búsqueda sea rápida y que la tabla no ocupe mucho espacio.

Imaginemos el caso donde tenemos 2 GB de RAM y 2 GB de swap, con páginas de 4 KB: necesitaríamos 1 millón de páginas en la tabla, lo cual es inviable tener todo en memoria.

**Solución: tabla de páginas multinivel.** Los primeros bits de la dirección apuntan a una tabla de primer nivel, y el resto opera igual que antes. La ventaja es que no necesitamos tener toda la tabla en memoria simultáneamente.

<p align="center">
  <img src="https://github.com/user-attachments/assets/cfeb43b8-af41-48c2-8742-c63bb590cc60" alt="Esquema de tabla multinivel">
</p>

La distribución de bits de la dirección física funciona así:

- **PT1:** apunta al *page directory*, que indica el comienzo de la *page table* a consultar.
- **PT2 + Offset:** ubica la página dentro de esa tabla y el byte dentro de la página.

---

### Entradas de la Tabla de Páginas

Cada entrada de una *page table* contiene:

| Campo | Descripción |
|-------|-------------|
| **Page frame** | La dirección del frame físico correspondiente. |
| **Bit de presencia/ausencia** | Indica si la página está cargada en memoria. |
| **Bits de protección** | Permisos de lectura, escritura y ejecución. |
| **Bit dirty (M)** | Indica que la página fue modificada desde que se cargó del disco. |
| **Bit de referencia (R)** | Indica si la página fue accedida desde que se cargó. Se usa para decidir qué página bajar a disco. |

---

## Memoria Asociativa (TLB)

**Problema:** Las tablas de páginas están en memoria RAM, por lo que acceder a ellas con demasiada frecuencia puede ser lento.

**Solución:** Agregar una pieza de **HW** caché conocida como *Translation Lookaside Buffer* (**TLB**).

La **TLB** es una memoria caché pequeña pero extremadamente rápida. Es **asociativa**, lo que significa que busca entre todas sus entradas en paralelo mediante una *Matching Unit* (que genera un alto consumo de energía). Se almacena dentro de la **CPU** y guarda las traducciones más recientes.

| Caso | Resultado |
|------|-----------|
| **TLB hit** | La traducción es instantánea. |
| **TLB miss** | Hay que ir a la tabla en RAM. |

La **TLB** funciona porque cumple con el principio de **localidad de referencia**: los programas tienden a acceder a las mismas páginas repetidamente en un período corto, por lo que las traducciones más recientes son las más probables de necesitarse de nuevo.

---

# Algoritmos de Reemplazo de Páginas

Una cuestión de diseño esencial es saber qué página desalojar para dar espacio a la siguiente. Esta decisión determina enormemente el rendimiento del **SO**.

---

## Óptimo (OPT)

Aunque no se puede implementar en la práctica, sirve como referencia teórica. La idea es reemplazar la página que **no se usará por el mayor tiempo en el futuro**. Para implementarlo habría que tener conocimiento del futuro, lo que es imposible en un sistema real. Sin embargo, es útil para comparar el rendimiento de otros algoritmos.

---

## FIFO (First In, First Out)

El de toda la vida: las páginas salen en el orden en que entraron. Se mantiene una cola donde la página más antigua es la primera en ser desalojada.

**Problema:** No tiene en cuenta con qué frecuencia se usó la página. Una página muy usada puede ser desalojada simplemente por ser la más vieja, generando muchos *page faults* innecesarios.

> **Anomalía de Bélády:** En ciertos casos, aumentar la cantidad de marcos de memoria disponibles puede *incrementar* la cantidad de *page faults*. Esto es una de las razones por las que FIFO no es muy usado en la práctica.

---

## FIFO Mejorado (Second Chance / Reloj)

El mismo enfoque que **FIFO**, pero antes de desalojar la página más antigua se revisa su **bit de referencia**. Si está encendido (fue referenciada recientemente), se le da una "segunda oportunidad": se apaga el bit, se la trata como si acabara de llegar y se pasa a la siguiente.

Esto respeta el **principio de localidad de referencia** y mejora notablemente el rendimiento. Una variante popular es el **algoritmo del reloj**, donde las páginas se organizan en un buffer circular y un puntero avanza buscando la primera página con bit de referencia apagado.

---

## NRU (Not Recently Used)

La idea es establecer una prioridad para desalojar según dos bits por página:

- **Bit R (Referenced):** se activa cuando la página es leída o escrita.
- **Bit M (Modified / Dirty):** se activa cuando la página es escrita.

Con estos dos bits se forman **4 clases**, ordenadas de menor a mayor costo de desalojo:

| Clase | Bit R | Bit M | Descripción |
|-------|:-----:|:-----:|-------------|
| 0 | 0 | 0 | No referenciada, no modificada → **mejor candidata** |
| 1 | 0 | 1 | No referenciada, modificada |
| 2 | 1 | 0 | Referenciada, no modificada |
| 3 | 1 | 1 | Referenciada, modificada → **peor candidata** |

El algoritmo desaloja una página de la clase más baja disponible. Los bits R se resetean periódicamente para que el sistema "olvide" referencias antiguas.

---

## LRU (Least Recently Used)

Es el que mejor funciona en la práctica, aunque es costoso de implementar. La idea es que la página que se usó **menos recientemente** tiene menor probabilidad de volver a usarse pronto, por lo que es la mejor candidata para desalojar.

**Implementación con contador global:** se mantiene un contador global que se incrementa con cada instrucción. Al acceder a una página, se la marca con el valor actual. Al desalojar, se busca la página con el valor más bajo. El problema es que actualizar ese contador en cada acceso a memoria es muy costoso en hardware real.

**Aproximaciones comunes:**

- **Bit de referencia con muestreo periódico:** se mantiene un registro de bits que se va desplazando con el tiempo. La página con el registro de bits más bajo numéricamente es la que se desaloja.
- **LRU con stack:** se mantiene una pila donde la página más recientemente usada siempre está en el tope. Al acceder a una página se mueve arriba; al desalojar, se saca del fondo.

---

## Comparación General

| Algoritmo | Costo de implementación | Rendimiento | Observaciones |
|-----------|:-----------------------:|:-----------:|---------------|
| OPT | Imposible | Óptimo | Solo sirve como referencia teórica |
| FIFO | Muy bajo | Bajo | Sufre la anomalía de Bélády |
| FIFO Mejorado | Bajo | Moderado | La variante del reloj es muy usada |
| NRU | Bajo | Moderado | Simple y razonablemente eficiente |
| LRU | Alto | Muy alto | Mejor en la práctica, difícil en HW |

> **Nota:** En la práctica, los **SO** modernos suelen usar variantes del algoritmo del reloj (FIFO mejorado) por su buen balance entre costo de implementación y rendimiento. LRU puro rara vez se implementa directamente en hardware.

## Thrashing 

El thrashing es cuando el **SO** se la paso intercambiando páginas de memoria a disco ida y vuelta...

Es una situación no deseable ya que se la pasa haciendo mantenimiento en lugar de trabajo productivo.

## Protección y reubicación

Todavia no resolvimos el problema de la protección y reubicación. Para el primer problema hay una solucion facíl, la cual es asignar a cada proceso su propia tabla de páginas. Y no hay manera de acceder a la tabla de páginas de otro proceso, para eso podemos hacer que cada proceso tenga su propio espacio de memoria. Cada uno de estos espacios se llama segmentos

## Copy-on-write


El Copy-on-Write es una técnica de optimización que se utiliza principalmente durante la llamada al sistema fork().

Cuando un proceso padre crea un proceso hijo, en lugar de duplicar toda la memoria física (que sería lentísimo y llenaría la RAM), el SO hace que ambos procesos compartan las mismas páginas físicas.
¿Cómo funciona?

1. Mapeo Compartido: Inicialmente, las tablas de páginas del padre y del hijo apuntan a los mismos frames en memoria física.

2. Solo Lectura: El SO marca todas esas páginas compartidas como de solo lectura (read-only) en la MMU.

3. La Excepción (El "Grito"): Si cualquiera de los dos procesos intenta escribir en una de esas páginas, el hardware detecta la violación de escritura y dispara un Page Fault.

4. La Copia Real: El SO intercepta ese fallo, se da cuenta de que es una página CoW, y recién ahí:

    - Crea una copia física del frame.

    - Actualiza la tabla de páginas del proceso que intentó escribir para que apunte a la nueva copia.

    - Marca la página como lectura/escritura.
