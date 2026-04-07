# Práctica 2: Scheduling

> Los enunciados de los ejercicios se encuentran en el PDF aparte [Enunciados](p2.pdf).


> Aclaracion: **turnaround** lo abrevio con **TT**.

> Aclaracion: waiting lo abrevio con **WT**.

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
   Vamos a describir las rafagas de **CPU** y **E/S**:
    
- **Rafagas de CPU**: tiempos 0-1, 11-12, 21-22. 

- **Rafagas de E/S**: tiempos 2-10, 13-20

### b)
  Ahora vamos con la duracion de rafagas:

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

- **P0** tiene rafagas cortas de **E/S** a ciertos dispositivos.

- **P1** se bloquea frecuentemente.

- **P2** rafagas de alto consumo de **CPU** prolongadas y luego escritura en disco.

### a)

Teniendo en cuenta este esquema y que no nos dicen el orden en el que se van a dar los procesos, un algoritmo por prioridad no convendria debido a que podria ser que el P2 se de primero lo que nos daria un tiempo de espera promedio muy elevado. Por otro lado podria ser conveniente porque las rafagas de E/S son cortas, pero con prioridad estatica P2 podria sufrir starvation si P0 y P1 siempre tienen mayor prioridad, lo que seria otro motivo para descartarlo.
Tambien menciona que P1 se suele bloquear frecuentemente, esto seria un motivo para no usar prioridad debido a que no podria seguir ejecutando mientras el proceso esta bloqueado. A mi parecer lo que convendria sabiendo todo esto es un algoritmo Round Robin, ya que no sabemos el orden de los procesos en el que se van a dar, el frecuente bloqueo de P1 y la corta duracion de las rafagas E/S de P0 las cuales no se verian perjudicadas por la conmutacion de procesos. La unica desventaja seria que tardaria mas en terminar P2 debido a que dura mucho, pero en beneficio no se atrasan el resto de procesos.

## Ejercicio 3

Tenemos el siguiente diagrama de estados:

![Diagrama de estados](img/states.png)

Este diagrama por lo que podemos observar, un proceso que esta en estado **running** no puede pasar directamente a **ready** sino que antes debe pasar por **blocked**, esto nos esta diciendo que un proceso siempre que se ejecute termina a menos que sea bloqueado por una interrupcion o esperando algun archivo. Por lo tanto parece que se trata de un scheduler **Cooperativo**. 

## Ejercicio 4

- a) **Round Robin** no genera starvation, debido a que va ciclando entre todos los procesos y a todos les asigna el mismo periodo de tiempo.

- b) **Por prioridad** en este caso si pueden sufrir de inanicion si los procesos con menos prioridad no aumentan la misma de alguna manera, por ejemplo a medida que un proceso envejece se le puede dar mas prioridad, tecnica conocida como **aging**.

- c) **SJF** es una variante de por prioridad asi que lo mismo, aunque en su version no preemptiva el starvation es menos probable, en la preemptiva (**SRTF**) es mas pronunciado.

- d) **SRTF** si puede sufrir starvation, si siempre llegan procesos con rafagas mas cortas, los procesos largos nunca llegan a ejecutarse.

- e) **FIFO** no sufre de starvation debido a que los procesos se ejecutan por orden de llegada.

- f) **Colas multinivel** si se utiliza un esquema de prioridades es decir cada cola representa una prioridad distinta podrian sufrir de starvation los procesos de la cola de menor prioridad, pero si se combina con **Round Robin** podria mitigarse o aumentar la prioridad de manera dinamica mediante **aging**.

- g) **Colas multinivel con feedback** no sufre de starvation justamente porque los procesos pueden moverse entre colas dinamicamente, si un proceso lleva mucho tiempo esperando sube de cola y eventualmente se ejecuta.

## Ejercicio 5

En este ejercicio se modifica **Round Robin** de tal manera que un mismo proceso puede estar encolado varias veces.

### a)

El impacto de la modificacion seria que cambiaria el invariante de **Round Robin** el cual es que se le asigna el mismo segmento de tiempo a cada proceso, algunos procesos recibiran en proporcion **mas tiempo de CPU** rompiendo asi la equidad de **Round Robin**. 

### b) 

<div align="center">

| Ventajas | Desventajas |
|:--------:|:-----------:|
|Asignar mas tiempo de CPU a procesos mas demandantes y largos | Si un proceso termino y sigue encolado, se realizara el context switch |
| Mas flexible que **Round Robin** estandar | Pueden generar **starvation** en los procesos que se encolaran una sola vez |
| Mas simple que un sistema de prioridades para procesos mas extensos | Mas dificil de gestionar para saber cuantas veces encolar el proceso|
| ----- | Pierde la equidad del **Round Robin** estandar|

</div>

### c)

Una modificacion posible para no modificar la cantidad de entradas de un mismo proceso seria poder asignar mas de un quantum de tiempo a un proceso, entonces a los procesos que demanden mas tiempo de **CPU** se les asigna mas del mismo. Ademas no tenemos el overhead del context switch cada vez que cambiamos.

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

>Nota: Mientras mas chico el valor de prioridad, mayor prioridad tiene. 

>Nota: Un quantum dura una unidad de tiempo.

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

El algoritmo con menor waiting time promedio es **SJF** y el que obtiene el menor turnaround promedio tambien es **SJF**. 

## Ejercicio 7

Considerar el siguiente conjunto de procesos y el diagrama de Gantt de ejecucion. 

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
Vamos con el calculo del **waiting time** y **turnaround** promedio:

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

El algoritmo presentado a partir de la tabla y diagrama de Gantt es un **SJF** pero con desalojo, ya que en el momento que llega un proceso con menor duracion el scheduler conmuta automaticamente al mismo. Tambien conocido como **SRTF** (Shortest Remaining Time First).

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

El **turnaround** promedio para estos procesos utilizando el algoritmo **FCFS** es el siguiente, tenemos que el proceso **P1** finaliza en el instante 8, luego el proceso **P2** finaliza en el instante 12 y por ultimo **P3** finaliza en el instante 13. Luego esto nos da un **TT** = (8 + 12 + 13) / 3 = 11 unidades de tiempo.

### b) 

Si ahora para el calculo del **turnaround** promedio tomamos el algoritmo **SJF** asumiendo que es sin desalojo seria el siguiente, para el **P1** termina en el instante 8, luego para ese momento ya entraron **P2** y **P3**, por lo tanto se ejecuta **P3** que dura una unidad de tiempo, por lo tanto finaliza en el instante 9, por ultimo **P2** finaliza en el instante 13. Eso nos da un **TT** = (8 + 9 + 13) / 3 = 10 unidades de tiempo.

### c) 

Ahora tenemos que calcular el **TT** del algoritmo **SJF** dejando el procesador en **idle** una unidad de tiempo, luego ya todos los procesos entraron a la cola de **ready**, se ejecuta **P3** que finaliza en el instante 2, continuamos con **P2** que finaliza en el instante 6, por ultimo se ejecuta **P1** que finaliza en el instante 14. El **TT** se calcula restando el instante de llegada, por lo que nos queda un **TT** promedio = ((2-1) + (6-0.4) + (14-0)) / 3 = (1 + 5.6 + 14) / 3 = 6.87 unidades de tiempo.

## Ejercicio 9

Consideramos el siguiente conjunto de procesos, con sus rafagas de **CPU** e instantes de llegada:

> Nota: El **TT** de un proceso es = Finalización - Llegada.
<div align="center">

| Proceso | Ráfaga de CPU | Instante de llegada |
|:-------:|:-------------:|:-------------------:|
| P1 | 1 | 5 |
| P2 | 10 | 6 |
| P3 | 1 | 7 |
| P4 | 10 | 8 |

</div>

> **Nota:** Notemos que el **CPU** esta en **idle** por 5 unidades de tiempo.

Ahora vamos a calcular el **TT** promedio y **WT** promedio, para los siguientes algoritmos:

- **FCFS**: Lo mas ilustrativo seria una tabla, pero vamos con los calculos en crudo, el **P1** llega en t = 5, y finaliza en t = 6, por lo que su **TT_P1** = 1, luego el **TT_P2** = 16 - 6 = 10, luego **TT_P3** = 17 - 7 = 10, por ultimo el **TT_P4** = 27 - 8 = 19. Para finalizar el **TT** promedio = (1 + 10 + 10 + 19) / 4 = 10 unidades de tiempo. 

- **RR (quantum = 10)**: Procedemos de la misma manera que el anterior, **TT_P1** = 6 - 5 = 1, ahora vamos con el **TT_P2** = 16 - 6 = 10, seguimos con el **TT_P3** = 17 - 7 = 10, por ultimo **TT_P4** = 27 - 8 = 19. Por lo tanto el **TT** promedio es (1 + 10 + 10 + 19) / 4 = 10 unidades de tiempo. 

- **SJF (sin desalojo)**: Notemos que el **TT** promedio aqui tambien va a ser de 10, debido a que los procesos ingresan de manera secuencial por lo que el algoritmo termina comportandose como **FCFS**.

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

Ahora vamos con el algoritmo de **Shortest Remaining Time First (SRTF)** el cual es una variante de **SJF** con desalojo, es decir que si a la cola de ready entra un proceso mas corto conmuta:

|  0 |  1 |  2 |  3 |  4 |  5 |  6 |  7 |  8 |  9 | 10 | 11 | 12 | 13 | 14 | 15 | 16 | 17 | 18 | 19 | 20 | 21 | 22 | 23 | 24 | 25 | 26 | 
|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
|P1    |P1    |P1    |P1    |P1    |P1    |P1    |P1    |P2    |P2    |P2    |P2    |P2    |P2    |P2    |P2      |P4    |P4    |P4    |P4    |P4    |P3    |P3    |P3    |P3    |P3    |P3    |

### c) 
Ahora vamos con **TT** promedio de ambos algoritmos:

- **Round Robin**: empezamos con este, vamos a calcular el **TT** de cada proceso para luego calcular el promedio. Empezamos por el **TT_P1** = 13 - 0 = 13, seguimos con el **TT_P2** = 16 - 5 = 11, a continuacion vamos con el **TT_P3** = 27 - 14 = 13, por ultimo el **TT_P4** = 26 - 15 = 11. Por lo tanto el **TT** promedio =  (13 + 11 + 13 + 11) / 4 = 12.

- **SRTF**: Seguimos el mismo metodo que en el inciso anterior. Empezamos con el **TT_P1** = 8 - 0 = 8, seguimos con el **TT_P2** = 16 - 8 = 8, a continuacion con el **TT_P3** = 27 - 14 = 13 y por ultimo con el **TT_P4** = 21 - 15 = 6. Por lo tanto el **TT** promedio = (8 + 8 + 13 + 6) / 4 = 8.75 unidades de tiempo.

### d) 

Aunque SRTF minimiza el turnaround promedio, Round Robin puede ser preferible en sistemas interactivos porque garantiza equidad y tiempos de respuesta acotados para todos los procesos. SRTF puede provocar starvation y es menos predecible, mientras que RR asegura que cada proceso reciba CPU periodicamente, lo cual es clave en entornos donde la experiencia del usuario es importante.

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

A continuacion calcularemos el **TT** y **WT** promedio:

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
- Ejecutan rafagas cortas de CPU y luego se bloquean esperando E/S
- Como pasan mucho tiempo bloqueados, su uso reciente de CPU es bajo
→ El scheduler los selecciona con mayor prioridad
→ Por eso son favorecidos

Los procesos intensivos en CPU (CPU-bound):
- Utilizan el procesador durante largos periodos
- Inicialmente tienen menor prioridad porque su uso reciente es alto

Sin embargo, no entran en starvation porque:
- Mientras los procesos de E/S estan bloqueados, los CPU-bound pueden ejecutarse
- Al no ejecutarse durante un tiempo, su uso reciente disminuye
- Eventualmente pasan a ser de los que menos CPU usaron recientemente
→ Recuperan prioridad y son planificados

Conclusion:
El algoritmo prioriza naturalmente a los procesos I/O-bound por su bajo uso reciente de CPU,
pero evita starvation en los CPU-bound porque su prioridad mejora cuando dejan de ejecutarse.

## Ejercicio 13

Tenemos que explicar que algoritmos favorecen (o desfavorecen) a los trabajos mas cortos:

- **a)** **FIFO:** En algunos casos este algoritmo de Scheduling desfavorece a los procesos mas cortos si antes de los mismos vienen procesos considerablemente mas largos, lo que aumenta el **WT** y **TT** promedio.

- **b) Round Robin (RR):**

  Este algoritmo no favorece particularmente a los procesos cortos, sino que distribuye el tiempo de CPU de manera equitativa entre todos los procesos mediante un quantum fijo.

  Cada proceso recibe CPU periodicamente, lo que garantiza buen tiempo de respuesta y evita starvation.

  Si bien los procesos cortos pueden terminar en pocas rondas, tambien pueden verse retrasados por cambios de contexto frecuentes y por tener que esperar su turno en la cola.

- **c) Multilevel feedback queue:** Este algoritmo favorece tanto a los procesos cortos como interactivos, pero sin dejar en inanicion al resto, ya que los procesos comienzan por lo general en la mas alta prioridad utilizando **Round Robin** pero si consumen todo el quantum se los baja de prioridad.

## Ejercicio 14


## Ejercicio 15

## Ejercicio 16

## Ejercicio 17
