# Práctica 2: Scheduling

> Los enunciados de los ejercicios se encuentran en el PDF aparte [Enunciados](p2.pdf).

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

Teniendo en cuenta este esquema y que no nos dicen el orden en el que se van a dar los procesos, un algoritmo por prioridad no convendria debido a que podria ser que el P2 se de primero lo que nos daria un tiempo de espera promedio muy elevado. Por otro lado podria ser conveniente porque las rafagas de E/S son cortas, pero con prioridad estatica P2 podria sufrir starving si P0 y P1 siempre tienen mayor prioridad, lo que seria otro motivo para descartarlo.
Tambien menciona que P1 se suele bloquear frecuentemente, esto seria un motivo para no poner por prioridad debido a que no podria seguir ejecutando mientras el proceso esta bloqueado. A mi parecer lo que convendria sabiendo todo esto es un algoritmo Round Robin esto ya que no sabemos el orden de los procesos en el que se van a dar, el frecuente bloqueo de P1 y la corta duracion de las rafagas E/S de P0 las cuales no se verian perjudicadas por la conmutacion de procesos. La unica desventaja seria que tardaria mas en terminar P2 debido a que dura mucho, pero en beneficio no se atrasan el resto de procesos.

## Ejercicio 3

Tenemos el siguiente diagrama de estados:

![Diagrama de estados](img/states.png)

Este diagrama por lo que podemos observar el un proceso que esta en estado **running** no puede pasar directamente a **ready** sino que antes debe pasar por **blocked**, eso no esta diciendo que un proceso siempre que se ejecute termina a menos que sea bloqueado por una interrupcion o esperando algun archivo. Por lo tanto parece que se trata de un scheduler **Cooperativo**. 

## Ejercicio 4

- a) **Round Robin** no genera starvation, debido a que va ciclando entre todos los procesos y a todos les asigna el mismo periodo de tiempo.

- b) **Por prioridad** en este caso si pueden sufrir de inanicion si los procesos con menos prioridad no aumentan la misma de alguna manera, por ejemplo a medida que un proceso envejece se le puede dar mas prioridad, tecnica conocida como **aging**.

- c) **SJF** es una variante de por prioridad asi que lo mismo, aunque en su version no preemptiva el starvation es menos probable, en la preemptiva (**SRTF**) es mas pronunciado.

- d) **SRTF** si puede sufrir starvation, si siempre llegan procesos con rafagas mas cortas, los procesos largos nunca llegan a ejecutarse.

- e) **FIFO** no sufre de starvation debido a que los procesos se ejecutan por orden de llegada.

- f) **Colas multinivel** si se utiliza un esquema de prioridades es decir cada cola representa una prioridad distinta podrian sufrir de starvation los procesos de la cola de menor prioridad, pero si se combina con **Round Robin** podria mitigarse o aumentar la prioridad de manera dinamica mediante **aging**.

- g) **Colas multinivel con feedback** no sufre de starvation justamente porque los procesos pueden moverse entre colas dinamicamente, si un proceso lleva mucho tiempo esperando sube de cola y eventualmente se ejecuta.

## Ejercicio 5

En este ejercicio se modifica **Round Robin** de tal manera que un mismo proceso puede estas encolado varias veces.

### a)

El impacto de la modificacion seria que cambiara el invariante de **Round Robin** el cual es que se le asgina el mismo segmento de tiempo a cada proceso, algunos procesos recibiran en proporcion **mas tiempo de CPU** rompiendo asi la equidad de **Round Robin**. 

### b) 

<div align="center">

| Ventajas | Desventajas |
|:--------:|:-----------:|
|Asignar mas tiempo de CPU a procesos mas demandantes y largos | Si un proceso termino y sigue encolado, se realizara el context switch |
| Mas flexible que **Round Robin** estandar | Pueden generar **starvation** en los procesos que sen encolaran una sola vez |
| Mas simple que un sistema de prioridades para procesos mas extensos | Mas dificil de gestionar para saber cuantas veces encolar el proceso|
| ----- | Pierda la equidad del **Round Robin** estandar|

</div>

### c)

Una modificacion posible para lo modificar la cantidad de entradas de un mismo proceso seria poder asignar mas de un quantum de tiempo al un proceso, entonces a los procesos que demanden mas tiempo de **CPU** se les asigna mas del mismo. Ademas no tenemos el overhead del context switch cada vez que cambiamos.

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

>Nota: Mientras mas chico el valor de prioridad, myor prioridad tiene. 

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

El algortimo con menor waiting time promedio es **SFJ** y el que obtiene el menor turnaround promedio **SFJ** 

## Ejercicio 7

Considerar el siguiente conjunto de procesos y el diagrama de Gantt de ejecucion. 

## Ejercicio 8

## Ejercicio 9

## Ejercicio 10

## Ejercicio 11

## Ejercicio 12

## Ejercicio 13

## Ejercicio 14

## Ejercicio 15

## Ejercicio 16

## Ejercicio 17
