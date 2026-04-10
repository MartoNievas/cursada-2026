# Práctica 2: Scheduling

> Los enunciados de los ejercicios se encuentran en el PDF aparte [Enunciados](p2.pdf).


> Aclaración: **turnaround** lo abrevio con **TT**.

> Aclaración: waiting lo abrevio con **WT**.

---

## Ejercicio 1

Contamos con la siguiente tabla que describe la forma en la que se utiliza el procesador: 

<div align="center">

| Tiempo | Evento |
|:------:|:-------|
| 0 | *load store* |
| 1 | *add store* |
| 2 | *read* de archivo |
| 3 | espera E/S |
| .. | .. |
| 10 | espera E/S |
| 11 | *store increment* |
| 12 | inc |
| 13 | *write* en archivo |
| 14 | espera E/S |
| .. | ... |
| 20 | espera E/S |
| 21 | *load store* |
| 22 | *add store* |

</div>

### a)
   Vamos a describir las ráfagas de **CPU** y **E/S**:
    
- **Ráfagas de CPU**: tiempos 0-1, 11-12, 21-22. 

- **Ráfagas de E/S**: tiempos 2-10, 13-20

### b)
  Ahora vamos con la duración de ráfagas:

<div align="center">

| Ráfaga | Tipo | Duración |
|:------:|:----:|:--------:|
| 1 | CPU | 3 |
| 1 | E/S | 8 |
| 2 | CPU | 3 |
| 2 | E/S | 8 |
| 3 | CPU | 2 |

</div>

## Ejercicio 2

Datos del ejercicio:

- **P0** tiene ráfagas cortas de **E/S** a ciertos dispositivos.

- **P1** se bloquea frecuentemente.

- **P2** ráfagas de alto consumo de **CPU** prolongadas y luego escritura en disco.

### a)

Teniendo en cuenta este esquema y que no nos dicen el orden en el que se van a dar los procesos, un algoritmo por prioridad no convendría debido a que podría ser que el P2 se dé primero lo que nos daría un tiempo de espera promedio muy elevado. Por otro lado podría ser conveniente porque las ráfagas de E/S son cortas, pero con prioridad estática P2 podría sufrir starvation si P0 y P1 siempre tienen mayor prioridad, lo que sería otro motivo para descartarlo.
También menciona que P1 se suele bloquear frecuentemente, esto sería un motivo para no usar prioridad debido a que no podría seguir ejecutando mientras el proceso está bloqueado. A mi parecer lo que convendría sabiendo todo esto es un algoritmo Round Robin, ya que no sabemos el orden de los procesos en el que se van a dar, el frecuente bloqueo de P1 y la corta duración de las ráfagas E/S de P0 las cuales no se verían perjudicadas por la conmutación de procesos. La única desventaja sería que tardaría más en terminar P2 debido a que dura mucho, pero en beneficio no se atrasan el resto de procesos.

## Ejercicio 3

Tenemos el siguiente diagrama de estados:

![Diagrama de estados](img/states.png)

Este diagrama por lo que podemos observar, un proceso que está en estado **running** no puede pasar directamente a **ready** sino que antes debe pasar por **blocked**, esto nos está diciendo que un proceso siempre que se ejecute termina a menos que sea bloqueado por una interrupción o esperando algún archivo. Por lo tanto parece que se trata de un scheduler **Cooperativo**. 

## Ejercicio 4

- a) **Round Robin** no genera starvation, debido a que va ciclando entre todos los procesos y a todos les asigna el mismo período de tiempo.

- b) **Por prioridad** en este caso sí pueden sufrir de inanición si los procesos con menos prioridad no aumentan la misma de alguna manera, por ejemplo a medida que un proceso envejece se le puede dar más prioridad, técnica conocida como **aging**.

- c) **SJF** es una variante de por prioridad así que lo mismo, aunque en su versión no preemptiva el starvation es menos probable, en la preemptiva (**SRTF**) es más pronunciado.

- d) **SRTF** sí puede sufrir starvation, si siempre llegan procesos con ráfagas más cortas, los procesos largos nunca llegan a ejecutarse.

- e) **FIFO** no sufre de starvation debido a que los procesos se ejecutan por orden de llegada.

- f) **Colas multinivel** si se utiliza un esquema de prioridades es decir cada cola representa una prioridad distinta podrían sufrir de starvation los procesos de la cola de menor prioridad, pero si se combina con **Round Robin** podría mitigarse o aumentar la prioridad de manera dinámica mediante **aging**.

- g) **Colas multinivel con feedback** no sufre de starvation justamente porque los procesos pueden moverse entre colas dinámicamente, si un proceso lleva mucho tiempo esperando sube de cola y eventualmente se ejecuta.

## Ejercicio 5

En este ejercicio se modifica **Round Robin** de tal manera que un mismo proceso puede estar encolado varias veces.

### a)

El impacto de la modificación sería que cambiaría el invariante de **Round Robin** el cual es que se le asigna el mismo segmento de tiempo a cada proceso, algunos procesos recibirán en proporción **más tiempo de CPU** rompiendo así la equidad de **Round Robin**. 

### b) 

<div align="center">

| Ventajas | Desventajas |
|:--------:|:-----------:|
|Asignar más tiempo de CPU a procesos más demandantes y largos | Si un proceso terminó y sigue encolado, se realizará el context switch |
| Más flexible que **Round Robin** estándar | Pueden generar **starvation** en los procesos que se encolarán una sola vez |
| Más simple que un sistema de prioridades para procesos más extensos | Más difícil de gestionar para saber cuántas veces encolar el proceso|
| ----- | Pierde la equidad del **Round Robin** estándar|

</div>

### c)

Una modificación posible para no modificar la cantidad de entradas de un mismo proceso sería poder asignar más de un quantum de tiempo a un proceso, entonces a los procesos que demanden más tiempo de **CPU** se les asigna más del mismo. Además no tenemos el overhead del context switch cada vez que cambiamos.

## Ejercicio 6

Tenemos el siguiente conjunto de procesos que llegan en el orden dado en el instante 0.

<div align="center">

| Proceso | Ráfaga de CPU | Prioridad |
|:-------:|:-------------:|:---------:|
| P1 | 10 | 3 |
| P2 | 1 | 1 |
| P3 | 2 | 3 |
| P4 | 1 | 4 |
| P5 | 5 | 2 |

</div>

> Nota: Mientras más chico el valor de prioridad, mayor prioridad tiene. 

> Nota: Un quantum dura una unidad de tiempo.

### a) 

Diagrama de Gantt **FCFS**: 

| 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13 | 14 | 15 | 16 | 17 | 18 |
|---|---|---|---|---|---|---|---|---|---|----|----|----|----|----|----|----|----|----|
|P1   |P1   |P1   |P1   |P1   |P1   |P1   |P1   |P1   |P1   |P2    |P3    |P3    |P4    |P5    |P5    |P5    |P5    |P5   |


Diagrama de Gantt **SJF**:

| 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13 | 14 | 15 | 16 | 17 | 18 |
|---|---|---|---|---|---|---|---|---|---|----|----|----|----|----|----|----|----|----|
|P2   |P4   |P3   |P3   |P5   |P5   |P5   |P5   |P5   |P1   |P1    |P1    |P1    |P1    |P1    |P1    |P1    |P1    |P1    |


Diagrama de Gantt **con prioridad sin desalojo**:

| 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13 | 14 | 15 | 16 | 17 | 18 |
|---|---|---|---|---|---|---|---|---|---|----|----|----|----|----|----|----|----|----|
|P2   |P5   |P5   |P5   |P5   |P5   |P1   |P1   |P1   |P1   |P1    |P1    |P1    |P1    |P1    |P1    |P3    |P3    |P4    |

Diagrama de Gantt **Round Robin**:

| 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13 | 14 | 15 | 16 | 17 | 18 |
|---|---|---|---|---|---|---|---|---|---|----|----|----|----|----|----|----|----|----|
|P1   |P2   |P3   |P4   |P5   |P1   |P3   |P5   |P1   |P5   |P1    |P5    |P1    |P5    |P1    |P1    |P1    |P1    |P1    |

### b) 

Ahora vamos con el waiting time y turnaround promedio de cada algoritmo:

<div align="center">

| Proceso | FCFS TT | FCFS W | SJF TT | SJF W | Prior. TT | Prior. W | RR TT | RR W |
|:-------:|:-------:|:------:|:------:|:-----:|:---------:|:--------:|:-----:|:----:|
| P1 |10 |0 |19 |9 |16 |6 |19 |9 |
| P2 |11 |10 |1 |0 |1 |0 |2 |1 |
| P3 |13 |11 |4 |2 |18 |16 |7 |5 |
| P4 |14 |13 |2 |1 |19 |18 |4 |3 |
| P5 |19 |14 |9 |4 |6 |1 |14 |9 |
| **Promedio** |13.4 |9.6 |7 |3.2 |12 |8.2 |9.2 |5.4 |

</div>

### c) 

El algoritmo con menor waiting time promedio es **SJF** y el que obtiene el menor turnaround promedio también es **SJF**. 

## Ejercicio 7

Considerar el siguiente conjunto de procesos y el diagrama de Gantt de ejecución. 

<div align="center">

| Proceso | Ráfaga de CPU | Instante de llegada (ms) |
|:-------:|:-------------:|:------------------------:|
| P1 | 3 | 0 |
| P2 | 6 | 2 |
| P3 | 4 | 4 |
| P4 | 5 | 6 |
| P5 | 2 | 8 |

| P1 | P2 | P3 | P5 | P2 | P4 |
|:--:|:--:|:--:|:--:|:--:|:--:|
| 0 - 3 | 3 - 4 | 4 - 8 | 8 - 10 | 10 - 15 | 15 - 20 |

</div>

### a) 
Vamos con el cálculo del **waiting time** y **turnaround** promedio:

<div align="center">

| Proceso | Llegada | Finalización | TT | WT |
|:-------:|:-------:|:------------:|:--:|:--:|
| P1 | 0 | 3 | 3 | 0 |
| P2 | 2 | 15 | 13 | 7 |
| P3 | 4 | 8 | 4 | 0 |
| P4 | 6 | 20 | 14 | 9 |
| P5 | 8 | 10 | 2 | 0 |
| **Promedio** | | | **7.2** | **3.2** |

</div>

### b) 

El algoritmo presentado a partir de la tabla y diagrama de Gantt es un **SJF** pero con desalojo, ya que en el momento que llega un proceso con menor duración el scheduler conmuta automáticamente al mismo. También conocido como **SRTF** (Shortest Remaining Time First).

## Ejercicio 8

Contamos con el siguiente conjunto de procesos:

<div align="center">

| Proceso | Ráfaga de CPU | Instante de llegada |
|:-------:|:-------------:|:-------------------:|
| P1 | 8 | 0.0 |
| P2 | 4 | 0.4 |
| P3 | 1 | 1.0 |

</div>


### a) 

El **turnaround** promedio para estos procesos utilizando el algoritmo **FCFS** es el siguiente, tenemos que el proceso **P1** finaliza en el instante 8, luego el proceso **P2** finaliza en el instante 12 y por último **P3** finaliza en el instante 13. Luego esto nos da un **TT** = (8 + 12 + 13) / 3 = 11 unidades de tiempo.

### b) 

Si ahora para el cálculo del **turnaround** promedio tomamos el algoritmo **SJF** asumiendo que es sin desalojo sería el siguiente, para el **P1** termina en el instante 8, luego para ese momento ya entraron **P2** y **P3**, por lo tanto se ejecuta **P3** que dura una unidad de tiempo, por lo tanto finaliza en el instante 9, por último **P2** finaliza en el instante 13. Eso nos da un **TT** = (8 + 9 + 13) / 3 = 10 unidades de tiempo.

### c) 

Ahora tenemos que calcular el **TT** del algoritmo **SJF** dejando el procesador en **idle** una unidad de tiempo, luego ya todos los procesos entraron a la cola de **ready**, se ejecuta **P3** que finaliza en el instante 2, continuamos con **P2** que finaliza en el instante 6, por último se ejecuta **P1** que finaliza en el instante 14. El **TT** se calcula restando el instante de llegada, por lo que nos queda un **TT** promedio = ((2-1) + (6-0.4) + (14-0)) / 3 = (1 + 5.6 + 14) / 3 = 6.87 unidades de tiempo.

## Ejercicio 9

Consideramos el siguiente conjunto de procesos, con sus ráfagas de **CPU** e instantes de llegada:

> Nota: El **TT** de un proceso es = Finalización - Llegada.
<div align="center">

| Proceso | Ráfaga de CPU | Instante de llegada |
|:-------:|:-------------:|:-------------------:|
| P1 | 1 | 5 |
| P2 | 10 | 6 |
| P3 | 1 | 7 |
| P4 | 10 | 8 |

</div>

> **Nota:** Notemos que el **CPU** está en **idle** por 5 unidades de tiempo.

Ahora vamos a calcular el **TT** promedio y **WT** promedio, para los siguientes algoritmos:

- **FCFS**: Lo más ilustrativo sería una tabla, pero vamos con los cálculos en crudo, el **P1** llega en t = 5, y finaliza en t = 6, por lo que su **TT_P1** = 1, luego el **TT_P2** = 16 - 6 = 10, luego **TT_P3** = 17 - 7 = 10, por último el **TT_P4** = 27 - 8 = 19. Para finalizar el **TT** promedio = (1 + 10 + 10 + 19) / 4 = 10 unidades de tiempo. 

- **RR (quantum = 10)**: Procedemos de la misma manera que el anterior, **TT_P1** = 6 - 5 = 1, ahora vamos con el **TT_P2** = 16 - 6 = 10, seguimos con el **TT_P3** = 17 - 7 = 10, por último **TT_P4** = 27 - 8 = 19. Por lo tanto el **TT** promedio es (1 + 10 + 10 + 19) / 4 = 10 unidades de tiempo. 

- **SJF (sin desalojo)**: Notemos que el **TT** promedio acá también va a ser de 10, debido a que los procesos ingresan de manera secuencial por lo que el algoritmo termina comportándose como **FCFS**.

## Ejercicio 10

Contamos con el siguiente conjunto de procesos:

<div align="center">

| Proceso | Ráfaga de CPU | Instante de llegada |
|:------:|:-------------:|:-------------------:|
| P1     | 8             | 0                   |
| P2     | 8             | 5                   |
| P3     | 6             | 14                  |
| P4     | 5             | 15                  |

</div>

### a)

Vamos a realizar el diagrama de Gantt de los procesos, con el algoritmo **Round Robin** con un quantum de 5 unidades de tiempo:

| 0 |  1 |  2 |  3 |  4 |  5 |  6 |  7 |  8 |  9 | 10 | 11 | 12 | 13 | 14 | 15 | 16 | 17 | 18 | 19 | 20 | 21 | 22 | 23 | 24 | 25 | 26 |
|:------:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
|P1    |P1    |P1    |P1    |P1    |P2    |P2    |P2    |P2    |P2    |P1    |P1    |P1    |P2    |P2    |P2    |P3    |P3    |P3    |P3    |P3    |P4    |P4    |P4    |P4    |P4    |P3 |

### b)

Ahora vamos con el algoritmo de **Shortest Remaining Time First (SRTF)** el cual es una variante de **SJF** con desalojo, es decir que si a la cola de ready entra un proceso más corto conmuta:

|  0 |  1 |  2 |  3 |  4 |  5 |  6 |  7 |  8 |  9 | 10 | 11 | 12 | 13 | 14 | 15 | 16 | 17 | 18 | 19 | 20 | 21 | 22 | 23 | 24 | 25 | 26 | 
|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
|P1    |P1    |P1    |P1    |P1    |P1    |P1    |P1    |P2    |P2    |P2    |P2    |P2    |P2    |P2    |P2      |P4    |P4    |P4    |P4    |P4    |P3    |P3    |P3    |P3    |P3    |P3    |

### c) 
Ahora vamos con **TT** promedio de ambos algoritmos:

- **Round Robin**: empezamos con este, vamos a calcular el **TT** de cada proceso para luego calcular el promedio. Empezamos por el **TT_P1** = 13 - 0 = 13, seguimos con el **TT_P2** = 16 - 5 = 11, a continuación vamos con el **TT_P3** = 27 - 14 = 13, por último el **TT_P4** = 26 - 15 = 11. Por lo tanto el **TT** promedio = (13 + 11 + 13 + 11) / 4 = 12.

- **SRTF**: Seguimos el mismo método que en el inciso anterior. Empezamos con el **TT_P1** = 8 - 0 = 8, seguimos con el **TT_P2** = 16 - 8 = 8, a continuación con el **TT_P3** = 27 - 14 = 13 y por último con el **TT_P4** = 21 - 15 = 6. Por lo tanto el **TT** promedio = (8 + 8 + 13 + 6) / 4 = 8.75 unidades de tiempo.

### d) 

Aunque SRTF minimiza el turnaround promedio, Round Robin puede ser preferible en sistemas interactivos porque garantiza equidad y tiempos de respuesta acotados para todos los procesos. SRTF puede provocar starvation y es menos predecible, mientras que RR asegura que cada proceso reciba CPU periódicamente, lo cual es clave en entornos donde la experiencia del usuario es importante.

## Ejercicio 11

Contamos con el siguiente conjunto de procesos y 2 colas, la cola 1 tiene mayor prioridad que la 2:

La cola 1 funciona con **Round Robin** con un quantum de 1 unidad de tiempo y la cola 2 se usa **FCFS** y la cola 1 tiene desalojo.

### a)

<div align="center">

| Proceso | Ráfaga de CPU | Instante de llegada | Cola asignada |
|:------:|:-------------:|:-------------------:|:-------------:|
| P1     | 4             | 0                   | 1             |
| P2     | 3             | 0                   | 1             |
| P3     | 8             | 0                   | 2             |
| P4     | 5             | 10                  | 2             |

</div>

Vamos con el diagrama de Gantt usando el sistema de colas multinivel feedback (Asumiendo que el feedback ya fue construido):

| 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13 | 14 | 15 | 16 | 17 | 18 | 19 |
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
|P1|P2|P1|P2|P1|P2|P1|P3|P3|P3|P3 |P3 |P3 |P3 |P3 |P4 |P4 |P4 |P4 |P4 |

### b) 

A continuación calcularemos el **TT** y **WT** promedio:

**Tiempos de finalización**
- P1: 7
- P2: 6
- P3: 15
- P4: 20

**Turnaround Time (TT)**
- P1: 7 - 0 = 7
- P2: 6 - 0 = 6
- P3: 15 - 0 = 15
- P4: 20 - 10 = 10

**TT promedio**
(7 + 6 + 15 + 10) / 4 = **9.5**

---

**Waiting Time (WT)**
- P1: 7 - 4 = 3
- P2: 6 - 3 = 3
- P3: 15 - 8 = 7
- P4: 10 - 5 = 5

**WT promedio**
(3 + 3 + 7 + 5) / 4 = **4.5**

## Ejercicio 12

El algoritmo favorece a los procesos que han utilizado menos CPU en el pasado reciente.

Los procesos que realizan muchas E/S (I/O-bound):
- Ejecutan ráfagas cortas de CPU y luego se bloquean esperando E/S
- Como pasan mucho tiempo bloqueados, su uso reciente de CPU es bajo
→ El scheduler los selecciona con mayor prioridad
→ Por eso son favorecidos

Los procesos intensivos en CPU (CPU-bound):
- Utilizan el procesador durante largos períodos
- Inicialmente tienen menor prioridad porque su uso reciente es alto

Sin embargo, no entran en starvation porque:
- Mientras los procesos de E/S están bloqueados, los CPU-bound pueden ejecutarse
- Al no ejecutarse durante un tiempo, su uso reciente disminuye
- Eventualmente pasan a ser de los que menos CPU usaron recientemente
→ Recuperan prioridad y son planificados

Conclusión:
El algoritmo prioriza naturalmente a los procesos I/O-bound por su bajo uso reciente de CPU,
pero evita starvation en los CPU-bound porque su prioridad mejora cuando dejan de ejecutarse.

## Ejercicio 12 (Práctica nueva 2026)

Contamos con la siguiente tabla de procesos:

> **Nota:** Se asume que el algoritmo es apropiativo o con desalojo.

> **Nota:** También se toma el **deadline absoluto** = deadline dado + tiempo de llegada.

<div align="center">

| Tarea | Tiempo de llegada | Tiempo de ejecución | Deadline |
|:-----:|:-----------------:|:-------------------:|:--------:|
| P1 | 0 | 3 | 16 |
| P2 | 2 | 1 | 7 |
| P3 | 0 | 6 | 8 |
| P4 | 8 | 2 | 11 |
| P5 | 13 | 3 | 18 |

</div>

Vamos con el diagrama de Gantt en base al algoritmo **Earliest Deadline First (EDF)**, luego con el cálculo del **TT** y **WT** promedio:

| 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13 | 14 | 15 | 16 |
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:--:|:--:|:--:|:--:|:--:|:--:|:-:|
|P3   |P3   |P3   |P3   |P3   |P3   |P2   |P2   |P2   |P1   |P1    |P1    |P4    |P4    |P5    |P5    |P5 |

Por último vamos con el cálculo del **TT** y **WT** promedio:

- Para el **TT** promedio tenemos que es = (6 + 9 + 12 + 15 + 17) / 5 = 11.8 unidades de tiempo.

- Para el **WT** promedio tenemos que es = (0 + 6 + 9 + 12 + 14) / 5 = 8.2 unidades de tiempo.

## Ejercicio 13

Tenemos que explicar qué algoritmos favorecen (o desfavorecen) a los trabajos más cortos:

- **a)** **FIFO:** En algunos casos este algoritmo de Scheduling desfavorece a los procesos más cortos si antes de los mismos vienen procesos considerablemente más largos, lo que aumenta el **WT** y **TT** promedio.

- **b) Round Robin (RR):**

  Este algoritmo no favorece particularmente a los procesos cortos, sino que distribuye el tiempo de CPU de manera equitativa entre todos los procesos mediante un quantum fijo.

  Cada proceso recibe CPU periódicamente, lo que garantiza buen tiempo de respuesta y evita starvation.

  Si bien los procesos cortos pueden terminar en pocas rondas, también pueden verse retrasados por cambios de contexto frecuentes y por tener que esperar su turno en la cola.

- **c) Multilevel feedback queue:** Este algoritmo favorece tanto a los procesos cortos como interactivos, pero sin dejar en inanición al resto, ya que los procesos comienzan por lo general en la más alta prioridad utilizando **Round Robin** pero si consumen todo el quantum se los baja de prioridad.

## Ejercicio 14

Empecemos con datos del problema: 

- El sistema tiene procesos interactivos y procesamiento de datos.

- Estos procesos de procesamiento de datos leen archivos inmensos, realizan pequeñas cuentas y luego escriben resultados.

- Lo deseado es que los procesos interactivos se perciban fluidos y no perjudicar el **throughput** del sistema.

Con esto en mente, los procesos que leen archivos muy grandes tienden a tener **ráfagas largas de CPU**, por lo que si uno de estos procesos se ejecuta antes que uno interactivo, puede generar una mala percepción de respuesta. Por otro lado, los procesos interactivos suelen tener **ráfagas cortas de CPU**, ya que frecuentemente se bloquean esperando operaciones de **E/S**.

Por lo tanto, lo más conveniente en este caso sería utilizar **Round Robin**, ya que asigna un tiempo equitativo a todos los procesos, permitiendo que los procesos interactivos accedan rápidamente a la CPU y mejoren su tiempo de respuesta. Si bien introduce cierto overhead por cambios de contexto (lo que puede afectar levemente el throughput), mantiene un buen equilibrio general, ya que los procesos largos continúan ejecutándose en múltiples quantums. Además de asignar un quantum razonable para minimizar el impacto en el throughput del sistema.

## Ejercicio 15

En el problema tenemos los siguientes procesos:
- Uno genera las imágenes digitales.
- Uno responde a los botones de zoom (E/S).
- Uno responde a los botones de paneo (E/S).

Tenemos 2 procesos que son interactivos es decir son **E/S** y otro proceso que es **REAL TIME**, este último debería ser más prioritario ya que está en juego la integridad del paciente.

La mejor política para este caso sería una **Cola Multinivel** con desalojo.

La justificación es la siguiente, vamos a tener 2 colas:

- **Cola 1:** En esta se van a poner los procesos **REAL TIME**, es decir el procesamiento de imágenes. La misma va a tener la mayor prioridad debido a ser en tiempo real. Se le asignará un algoritmo **Earliest Deadline First**.

- **Cola 2:** En esta se van a poner ambos procesos **E/S**, que se van a ejecutar cuando la **Cola 1** esté vacía, en las ventanas de tiempo en las que el hardware de rayos X no emita valores al sistema. Por otro lado, como estos procesos son de corta duración, también se van a ejecutar en el posible tiempo ocioso que tenga la **CPU**. Esta cola se gestionaría con un algoritmo **Round Robin** para asegurar una buena respuesta a los procesos interactivos.

Por último, la razón del desalojo es que queremos priorizar la fluidez de la imagen antes que la interacción. Imaginemos el escenario en el que la **Cola 1** está vacía, comienza la ejecución de un proceso de aumento de zoom y en el mismo instante o una unidad de tiempo después ingresa un proceso **RT**. Sin desalojo, la imagen se vería descontinuada o lageada, por lo tanto es necesario desalojar el proceso actual para correr el de mayor prioridad.

## Ejercicio 16

Vamos con los datos que tenemos sobre el problema:

- Tenemos procesos de detección y guardado de videos en un servidor. En el problema se menciona que evitemos algoritmos poco "justos". Estos son intensivos en **E/S**.
- Luego tenemos un proceso de alarma que es crítico que se active antes de una deadline determinada. Por lo tanto el proceso es **REAL TIME**.
- Por la noche se aplica un proceso de compresión de las grabaciones de las cámaras, y las cámaras se activan solo con movimiento en este período, lo que conlleva que los procesos de grabado sean muy escasos y con ráfagas cortas.

---

### Política de Scheduling

La política de scheduling que vamos a plantear es la siguiente: vamos a utilizar un algoritmo de **Colas Multinivel** con desalojo, con las siguientes colas:

> **Nota:** A menor número, mayor es la prioridad.

- **Cola de prioridad 0:** Acá vamos a tener el proceso que dispara la alarma, ya que es un proceso **REAL TIME** y es crítico. Se usará un algoritmo **Earliest Deadline First**, aunque también podría ser **FIFO** ya que es un único proceso que se va a disparar una sola vez.

- **Cola de prioridad 1:** Esta cola está reservada para el proceso de detección de riesgos y alerta a los operadores, con un algoritmo **FIFO**.

- **Cola de prioridad 2:** En esta cola van los procesos relacionados al procesamiento de video y detección de objetos, con un algoritmo **Round Robin** para que sea lo más justo posible con el tiempo de **CPU** de cada proceso, y un quantum de duración razonable, ya que uno muy corto podría generar un overhead debido al context switch, ya que el procesamiento de video es muy demandante en cuanto a **CPU**.

- **Cola de prioridad 3:** Por último, en esta cola vamos a tener los procesos que corren de noche para la compresión de video. Como de noche las grabaciones son pocas, las colas 1 y 2 van a estar casi vacías debido al modo de detección de movimiento, por lo tanto estos procesos van a poder ejecutarse sin inconvenientes. En caso de **aging** (envejecimiento de los procesos), van a poder escalar su prioridad, esto es necesario debido a que podría ocasionar **starvation**. Se utiliza una política **FCFS** ya que la compresión de video es demandante en cuanto a **CPU**.

Como mencioné anteriormente, se cuenta con desalojo porque ante la llegada de un proceso de mayor prioridad se pasa directamente a ejecutarlo. Vamos con un escenario que muestre la importancia del tipo de scheduler elegido:

Imaginemos que son las 3 de la mañana, la cola de prioridad 3 está ejecutando un proceso de compresión de video. En ese momento una cámara detecta movimiento y dispara el proceso de alarma (Cola 0). Sin desalojo, el proceso de compresión seguiría ejecutándose hasta terminar su ráfaga de CPU, retrasando la alarma y potencialmente comprometiendo la seguridad. Con desalojo, el scheduler interrumpe inmediatamente la compresión y ejecuta el proceso de alarma, garantizando que se active dentro de su deadline.
