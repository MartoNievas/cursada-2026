# Práctica 2: Scheduling

**Sistemas Operativos — FCEyN, Universidad de Buenos Aires**

---

> Enunciado: [PDF](p2.pdf)

---

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

---

## Ejercicio 2

Datos del ejercicio:

- **P0** tiene ráfagas cortas de **E/S** a ciertos dispositivos.

- **P1** se bloquea frecuentemente.

- **P2** ráfagas de alto consumo de **CPU** prolongadas y luego escritura en disco.

### a)

Teniendo en cuenta este esquema y que no nos dicen el orden en el que se van a dar los procesos, un algoritmo por prioridad estática sin desalojo (non-preemptive) no convendría debido a que podría ser que P2 (con ráfagas de CPU prolongadas) se dé primero, lo que nos daría un tiempo de espera promedio muy elevado por el efecto convoy. Sin embargo, en un esquema con desalojo (preemptive), el orden de llegada ya no es un inconveniente, puesto que P0 o P1 desalojarían inmediatamente a P2 al estar listos. Por otro lado, un esquema por prioridad sí podría ser conveniente para favorecer a P0 y P1 dándoles mayor prioridad por tener ráfagas cortas de CPU. Además, es muy improbable que con prioridad estática P2 sufra inanición (starvation), dado que P0 y P1 son altamente intensivos en E/S y pasan la mayor parte de su tiempo bloqueados, dejando la CPU libre para P2. Si fuera necesario, este riesgo de inanición se anularía usando prioridades dinámicas con envejecimiento (aging). El hecho de que P1 se bloquee frecuentemente por red no es un motivo para no usar prioridades, sino todo lo contrario: al bloquearse, pasa al estado waiting (bloqueado), liberando la CPU de inmediato para el resto de los procesos listos, lo que lo vuelve el candidato perfecto para recibir una alta prioridad debido a que consume muy poco procesador antes de volver a bloquearse. A mi parecer, lo que convendría sabiendo todo esto es un algoritmo Round Robin (RR), ya que no sabemos el orden de llegada, y ante el frecuente bloqueo de P1 y la corta duración de las ráfagas de CPU de P0, ambos procesos simplemente liberarían la CPU de manera voluntaria antes de agotar su quantum de tiempo, sin verse perjudicados por la conmutación de procesos. La única desventaja sería que tardaría más en terminar P2 debido a que dura mucho y sufriría constantes desalojos y cambios de contexto, pero en beneficio no se atrasan el resto de procesos.

---

## Ejercicio 3

Tenemos el siguiente diagrama de estados:

![Diagrama de estados](img/states.png)

Este diagrama por lo que podemos observar, un proceso que está en estado **running** no puede pasar directamente a **ready** sino que antes debe pasar por **blocked**, esto nos está diciendo que un proceso siempre que se ejecute termina a menos que sea bloqueado por una interrupción o esperando algún archivo. Por lo tanto parece que se trata de un scheduler **non-preemptive**.

---

## Ejercicio 4

- a) **Round Robin** no genera starvation, debido a que va ciclando entre todos los procesos y a todos les asigna el mismo período de tiempo.

- b) **Por prioridad** en este caso sí pueden sufrir de inanición si los procesos con menos prioridad no aumentan la misma de alguna manera, por ejemplo a medida que un proceso envejece se le puede dar más prioridad, técnica conocida como **aging**.

- c) **SJF** es una variante de por prioridad así que lo mismo, aunque en su versión non-preemptive el starvation es menos probable, en la preemptive (**SRTF**) es más pronunciado.

- d) **SRTF** sí puede sufrir starvation, si siempre llegan procesos con ráfagas más cortas, los procesos largos nunca llegan a ejecutarse.

- e) **FIFO** no sufre de starvation debido a que los procesos se ejecutan por orden de llegada.

- f) **Colas multinivel** si se utiliza un esquema de prioridades es decir cada cola representa una prioridad distinta podrían sufrir de starvation los procesos de la cola de menor prioridad, pero si se combina con **Round Robin** podría mitigarse o aumentar la prioridad de manera dinámica mediante **aging**.

- g) **Colas multinivel con feedback** no sufre de starvation justamente porque los procesos pueden moverse entre colas dinámicamente, si un proceso lleva mucho tiempo esperando sube de cola y eventualmente se ejecuta.

---

## Ejercicio 5

En este ejercicio se modifica **Round Robin** de tal manera que un mismo proceso puede estar encolado varias veces.

### a)

El impacto de la modificación sería que cambiaría el invariante de **Round Robin** el cual es que se le asigna el mismo segmento de tiempo a cada proceso, algunos procesos recibirán en proporción **más tiempo de CPU** rompiendo así la equidad de **Round Robin**.

En un mal caso que nos lleguen entradas consecutivas del mismo proceso es decir por ejemplo $P_1, P_1 \dots , P_3, P_3, \dots$ y asi con todos los procesos podria convertise en un **FCFS**.

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

Una modificación posible para no modificar la cantidad de entradas de un mismo proceso sería poder asignar más de un quantum de tiempo a un proceso, entonces a los procesos que demanden más tiempo de **CPU** se les asigna más del mismo. Además no tenemos el overhead del context switch cada vez que cambiamos. Hay que tener cuidado con esta opción ya que si le asignamos mucho tiempo podria convertirse en un **FCFS**.

---

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

El algoritmo que obtiene las mejores metricas en ambos casos es **SFJ**, esto se debe a que al priorizar las rafagas de CPU cortas se evita el **efecto convoy** por el proceso **P1**, minimizando el waiting time promedio y turnarround promedio. Ademas se logra completar mas procesos por unidad de tiempo lo que incrementa el throughtput del sistema y es una de las caracterisitcas que en un sistema se quiere maximizar.

---

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

El algoritmo presentado a partir de la tabla y diagrama de Gantt es la version preemptive de **SJF**, ya que en el momento que llega un proceso con menor duración el scheduler conmuta automáticamente al mismo. También conocido como **SRTF** (Shortest Remaining Time First).

---

## Ejercicio 8: Impacto del Efecto Convoy y Procesador Ocioso

Contamos con el siguiente conjunto de procesos para analizar:

| Proceso | Ráfaga de CPU | Instante de llegada |
|:-------:|:-------------:|:-------------------:|
| **P1**  |       8       |         0.0         |
| **P2**  |       4       |         0.4         |
| **P3**  |       1       |         1.0         |

---

### a) Algoritmo FCFS (First-Come, First-Served)

#### Diagrama de Gantt:

| 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 |
|---|---|---|---|---|---|---|---|---|---|----|----|----|
| P1  | P1  | P1  | P1  | P1  | P1  | P1  | P1   |  P2 | P2  | P2   | P2   | P3    |

#### Explicación detallada:
En el algoritmo FCFS, los procesos se ejecutan estrictamente según su orden de llegada a la cola de listos:
* **P1** inicia en $t = 0.0$ y finaliza en $t = 8.0$.
* **P2** inicia en $t = 8.0$ y finaliza en $t = 12.0$.
* **P3** inicia en $t = 12.0$ y finaliza en $t = 13.0$.

Calculamos las métricas individuales restando el instante de llegada de cada proceso:

* **Turnaround Time (TT = Fin - Llegada):**
  * **P1:** $8.0 - 0.0 = \mathbf{8.0}$ unidades de tiempo.
  * **P2:** $12.0 - 0.4 = \mathbf{11.6}$ unidades de tiempo.
  * **P3:** $13.0 - 1.0 = \mathbf{12.0}$ unidades de tiempo.
  * **TT Promedio:** 
    $$\text{TT Promedio} = \frac{8.0 + 11.6 + 12.0}{3} = \frac{31.6}{3} \approx \mathbf{10.53\text{ unidades de tiempo}}$$

* **Waiting Time (W = TT - Ráfaga):**
  * **P1:** $8.0 - 8 = \mathbf{0.0}$ unidades de tiempo (no esperó).
  * **P2:** $11.6 - 4 = \mathbf{7.6}$ unidades de tiempo.
  * **P3:** $12.0 - 1 = \mathbf{11.0}$ unidades de tiempo.
  * **W Promedio:** 
    $$\text{WT Promedio} = \frac{0.0 + 7.6 + 11.0}{3} = \frac{18.6}{3} = \mathbf{6.20\text{ unidades de tiempo}}$$

---

### b) Algoritmo SJF (Shortest Job First) sin desalojo

#### Diagrama de Gantt:

| 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 |
|---|---|---|---|---|---|---|---|---|---|----|----|----|
|  P1 | P1   | P1  |P1   |P1   |P1   |P1   |P1   |P3   |P2   |P2    |P2    |P2    |

#### Explicación detallada:
Dado que el algoritmo es **sin desalojo** (*non-preemptive*), una vez que un proceso toma el control de la CPU, ejecuta hasta terminar:
* En $t = 0.0$, el único proceso presente es **P1**, por lo que se le asigna la CPU y se ejecuta completo hasta $t = 8.0$.
* Durante la ejecución de P1, arriban **P2** (en $t = 0.4$) y **P3** (en $t = 1.0$).
* En $t = 8.0$, con P1 finalizado, el planificador evalúa la cola de listos y selecciona al proceso con la ráfaga de CPU más corta: **P3** (ráfaga de 1) por sobre **P2** (ráfaga de 4).
* **P3** ejecuta desde $t = 8.0$ hasta $t = 9.0$.
* **P2** ejecuta desde $t = 9.0$ hasta $t = 13.0$.

Calculamos las métricas correspondientes:

* **Turnaround Time (TT = Fin - Llegada):**
  * **P1:** $8.0 - 0.0 = \mathbf{8.0}$ unidades de tiempo.
  * **P3:** $9.0 - 1.0 = \mathbf{8.0}$ unidades de tiempo.
  * **P2:** $13.0 - 0.4 = \mathbf{12.6}$ unidades de tiempo.
  * **TT Promedio:** 
    $$\text{TT Promedio} = \frac{8.0 + 8.0 + 12.6}{3} = \frac{28.6}{3} \approx \mathbf{9.53\text{ unidades de tiempo}}$$

* **Waiting Time (W = TT - Ráfaga):**
  * **P1:** $8.0 - 8 = \mathbf{0.0}$ unidades de tiempo.
  * **P3:** $8.0 - 1 = \mathbf{7.0}$ unidades de tiempo.
  * **P2:** $12.6 - 4 = \mathbf{8.6}$ unidades de tiempo.
  * **W Promedio:** 
    $$\text{WT Promedio} = \frac{0.0 + 7.0 + 8.6}{3} = \frac{15.6}{3} = \mathbf{5.20\text{ unidades de tiempo}}$$

---

### c) Algoritmo SJF sin desalojo con IDLE inicial de 1 unidad

#### Diagrama de Gantt:

| 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13 |
|---|---|---|---|---|---|---|---|---|---|----|----|----|----|
| IDLE |  P3 |P2   |P2   |P2   |P2   |P1   |P1   |P1   |P1   |P1    |P1    |P1    |P1 |

#### Explicación detallada:
Forzamos artificialmente al procesador a permanecer ocioso (**idle**) durante la primera unidad de tiempo (intervalo de $t = 0.0$ a $t = 1.0$):
* Al llegar a $t = 1.0$, todos los procesos (**P1**, **P2** y **P3**) ya se encuentran en la cola de listos.
* Como el planificador ahora tiene un panorama completo de todos los trabajos que van a ingresar, los ordena de menor a mayor ráfaga: **P3** (ráfaga 1), **P2** (ráfaga 4) y finalmente **P1** (ráfaga 8).
* **P3** ejecuta de $t = 1.0$ a $t = 2.0$.
* **P2** ejecuta de $t = 2.0$ a $t = 6.0$.
* **P1** ejecuta de $t = 6.0$ a $t = 14.0$.

Calculamos las métricas individuales restando el instante de llegada original de cada proceso:

* **Turnaround Time (TT = Fin - Llegada):**
  * **P3:** $2.0 - 1.0 = \mathbf{1.0}$ unidad de tiempo.
  * **P2:** $6.0 - 0.4 = \mathbf{5.6}$ unidades de tiempo.
  * **P1:** $14.0 - 0.0 = \mathbf{14.0}$ unidades de tiempo.
  * **TT Promedio:** 
    $$\text{TT Promedio} = \frac{14.0 + 5.6 + 1.0}{3} = \frac{20.6}{3} \approx \mathbf{6.87\text{ unidades de tiempo}}$$

* **Waiting Time (W = TT - Ráfaga):**
  * **P3:** $1.0 - 1 = \mathbf{0.0}$ unidades de tiempo.
  * **P2:** $5.6 - 4 = \mathbf{1.6}$ unidades de tiempo.
  * **P1:** $14.0 - 8 = \mathbf{6.0}$ unidades de tiempo.
  * **W Promedio:** 
    $$\text{WT Promedio} = \frac{0.0 + 1.6 + 6.0}{3} = \frac{7.6}{3} \approx \mathbf{2.53\text{ unidades de tiempo}}$$

---

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

---

### a) Algoritmo FCFS (First-Come, First-Served)

#### Diagrama de Gantt:

| 0 - 5 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13 | 14 | 15 | 16 | 17 | 18 | 19 | 20 | 21 | 22 | 23 | 24 | 25 | 26 |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| **IDLE** | P1 | P2 | P2 | P2 | P2 | P2 | P2 | P2 | P2 | P2 | P2 | P3 | P4 | P4 | P4 | P4 | P4 | P4 | P4 | P4 | P4 | P4 |

*Nota: P1 ejecuta en el intervalo [5,6]; P2 en [6,16]; P3 en [16,17]; P4 en [17,27].*

#### Explicación detallada:
Los procesos se atienden estrictamente en orden de llegada:
* **P1** inicia en $t = 5$ y finaliza en $t = 6$.
* **P2** inicia en $t = 6$ y finaliza en $t = 16$.
* **P3** (llegado en $t = 7$) inicia en $t = 16$ y finaliza en $t = 17$.
* **P4** (llegado en $t = 8$) inicia en $t = 17$ y finaliza en $t = 27$.

#### Cálculos de Rendimiento:
* **Turnaround Time (TT = Fin - Llegada):**
  * **P1:** $6 - 5 = \mathbf{1}$ unidad de tiempo.
  * **P2:** $16 - 6 = \mathbf{10}$ unidades de tiempo.
  * **P3:** $17 - 7 = \mathbf{10}$ unidades de tiempo.
  * **P4:** $27 - 8 = \mathbf{19}$ unidades de tiempo.
  * **TT Promedio:** 
    $$\text{TT Promedio} = \frac{1 + 10 + 10 + 19}{4} = \frac{40}{4} = \mathbf{10.0\text{ unidades de tiempo}}$$

* **Waiting Time (W = TT - Ráfaga):**
  * **P1:** $1 - 1 = \mathbf{0}$ unidades de tiempo.
  * **P2:** $10 - 10 = \mathbf{0}$ unidades de tiempo.
  * **P3:** $10 - 1 = \mathbf{9}$ unidades de tiempo.
  * **P4:** $19 - 10 = \mathbf{9}$ unidades de tiempo.
  * **W Promedio:** 
    $$\text{W Promedio} = \frac{0 + 0 + 9 + 9}{4} = \frac{18}{4} = \mathbf{4.5\text{ unidades de tiempo}}$$

---

### b) Algoritmo Round Robin (Quantum = 10)

#### Diagrama de Gantt:
*(Idéntico al diagrama de FCFS)*

#### Explicación detallada:
En este caso, la duración del *quantum* ($q = 10$) es mayor o igual a las ráfagas de todos los procesos. Ningún proceso es desalojado por límite de tiempo:
* **P1** ejecuta $1$ unidad y libera la CPU voluntariamente al finalizar.
* **P2** ejecuta sus $10$ unidades completas justo en el límite del *quantum* y finaliza de forma natural.
* **P3** ejecuta $1$ unidad y finaliza.
* **P4** ejecuta sus $10$ unidades completas y finaliza.

Debido a que el orden de llegada coincide con el de ejecución y ningún proceso es interrumpido antes de terminar, **Round Robin ($q=10$) se comporta exactamente igual que FCFS**.

#### Cálculos de Rendimiento:
* **TT Promedio:** $\mathbf{10.0\text{ unidades de tiempo}}$
* **W Promedio:** $\mathbf{4.5\text{ unidades de tiempo}}$

---

### c) Algoritmo SJF (Shortest Job First) sin desalojo

#### Diagrama de Gantt:

  *(Idéntico al diagrama de FCFS)*

#### Explicación detallada:

A pesar de ser un algoritmo diseñado para priorizar ráfagas cortas, se comporta de manera idéntica a FCFS debido a la secuencialidad obligada de los arribos:
1. En $t = 5$, el único proceso listo es **P1** (ejecuta de 5 a 6).

2. En $t = 6$, con P1 terminado, el único proceso listo en el sistema es **P2** (P3 llega recién en $t = 7$). Por lo tanto, el planificador se ve forzado a asignarle la CPU a **P2** (ejecuta sin desalojo de 6 a 16).

3. En $t = 16$, con P2 terminado, ya llegaron tanto **P3** (en $t = 7$) como **P4** (en $t = 8$). El planificador compara sus ráfagas: P3 (ráfaga 1) y P4 (ráfaga 10). Selecciona el más corto, que es **P3** (ejecuta de 16 a 17).

4. Finalmente, ejecuta el restante **P4** (de 17 a 27).

Al coincidir las decisiones de planificación forzadas por la disponibilidad con las duraciones de las ráfagas, el orden de ejecución final es $P_1 \rightarrow P_2 \rightarrow P_3 \rightarrow P_4$, idéntico a FCFS.

#### Cálculos de Rendimiento:
* **TT Promedio:** $\mathbf{10.0\text{ unidades de tiempo}}$
* **W Promedio:** $\mathbf{4.5\text{ unidades de tiempo}}$

---

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

- **Round Robin**: empezamos con este, vamos a calcular el **TT** de cada proceso para luego calcular el promedio. 

  - $TT_{P1} = 13 - 0 = 13 $.
  - $TT_{P2} = 16 - 5 = 11$.
  - $TT_{P3} = 27 - 14 = 13$.
  - $TT_{P4} = 26 - 15 = 11$

  Teniendo todos estos numeros calculemos el promdio de la siguiente manera

  $$
  TT_{Promedio} = \frac{TT_{P1} + TT_{P2} + TT_{P3}  + TT_{P4}}{4} = \frac{13 + 11 + 13 + 11}{4} = \mathbf{12}
  $$


- **SRTF**: Seguimos el mismo método que en el inciso anterior. 

  - $TT_P1 = 8 - 0 = 8$.
  - $TT_P2 = 16 - 8 = 8$
  - $TT_P3 = 27 - 14 = 13$
  - $TT_P4 = 21 - 15 = 6$

  Teniendo todos estos numeros calculemos el promdio de la siguiente manera

  $$
  TT_{Promedio} = \frac{TT_{P1} + TT_{P2} + TT_{P3}  + TT_{P4}}{4} = \frac{8 + 8 + 13 + 6}{4} = \mathbf{8.75}
  $$


### d) 

A pesar de que **SRTF** es un algoritmo óptimo para minimizar el tiempo de espera promedio y de retorno (*turnaround*), su implementación práctica no siempre es viable ni deseable. La elección entre **SRTF** y **Round Robin (RR)** depende estrictamente del tipo de procesos y de los objetivos del sistema operativo:

#### 1. Sistemas Interactivos (Orientados al usuario)
En estos entornos (como un sistema de escritorio o una apliacion con interaccion del usuario), la métrica crítica a optimizar no es el *turnaround*, sino el **Response Time (tiempo de respuesta)**, definido como el tiempo transcurrido desde que un proceso se lanza hasta que ejecuta en la CPU por primera vez.

  * **Por qué se prefiere Round-Robin:** Al conceder a cada proceso un *quantum* acotado de tiempo de manera cíclica, RR asegura de forma equitativa que todos los procesos progresen y respondan periódicamente. Esto baja drásticamente el tiempo de respuesta percibido por el usuario. Además, RR no requiere predecir el futuro de las ráfagas para planificar.

  * **Desventajas de SRTF aquí:** SRTF es impracticable en sistemas de propósito general porque requiere conocer con precisión la duración de la próxima ráfaga de CPU de antemano, lo cual es teóricamente imposible en un entorno real. Asimismo, castiga de forma sistemática a los procesos de ráfaga larga, sometiéndolos a un riesgo crítico de **inanición (*starvation*)** si continúan arribando procesos cortos.

#### 2. Sistemas de Procesamiento por Lotes (Batch)
En entornos de procesamiento pesado en segundo plano (como cálculos científicos, renderizado o backups nocturnos), no existe un usuario interactuando activamente con el sistema.
  
  * **Por qué se prefiere SRTF (o SJF):** El objetivo principal en sistemas batch es maximizar el **throughput** (cantidad de trabajos finalizados por unidad de tiempo) y minimizar el **turnaround promedio**. Priorizar los trabajos más cortos permite vaciar la cola de listos rápidamente, minimizando la acumulación de tiempos de espera. El uso de Round Robin en este escenario penalizaría el rendimiento general debido al constante desperdicio de ciclos de CPU en **cambios de contexto** (*context switches*).

#### 3. Sistemas de Tiempo Real (Real-Time)
En estos sistemas (como el software de control industrial o dispositivos médicos), la prioridad absoluta es cumplir con **fechas límite (*deadlines*)** estrictas, donde ejecutar tarde una tarea equivale a no haberla ejecutado.

  * **Por qué no sirven ni RR ni SRTF:** Ninguno de estos algoritmos considera los requerimientos de tiempo del sistema externo. Round Robin es demasiado lento y carece de prioridades, mientras que SRTF prioriza ráfagas cortas pero podría dejar vencer el *deadline* de un proceso de ráfaga larga. En estos contextos se requiere una planificación especializada con desalojo basada en plazos, como el algoritmo **EDF (Earliest Deadline First)** o políticas de prioridades estáticas en las que los procesos críticos tienen prioridad absoluta sobre los interactivos y los batch.

---

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
- $TF_{P1} = 7$
- $TF_{P2} = 6$
- $TF_{P3} = 15$
- $TF_{P4} = 20$

**Turnaround Time (TT)**
- $TT_{P1} = 7 - 0 = 7 $
- $TT_{P2} = 6 - 0 = 6$
- $TT_{P3} = 15 - 0 = 15$
- $TT_{P4} = 20 - 10 = 10$

  $$
    TT_{Promedio} = \frac{7 + 6 + 15 + 10}{4} = \mathbf{9.5} 
  $$


---

**Waiting Time (WT)**
- $WT_{P1} = 7 - 4 = 3$
- $WT_{P2} = 6 - 3 = 3$
- $WT_{P3} =  15 - 8 = 7$
- $WT_{P4} = 10 - 5 = 5$

$$
WT_{Promedio} = \frac{3 + 3 + 7 + 5}{4} = \mathbf{4.5}
$$


---

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

---

## Ejercicio 12 (Práctica nueva 2026)

Contamos con la siguiente tabla de procesos:

> **Nota:** Se asume que el algoritmo es apropiativo o con desalojo o preemptive.

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

---

## Ejercicio 13

Tenemos que explicar qué algoritmos favorecen (o desfavorecen) a los trabajos más cortos:

- **a)** **FIFO:** En algunos casos este algoritmo de Scheduling desfavorece a los procesos más cortos si antes de los mismos vienen procesos considerablemente más largos, lo que aumenta el **WT** y **TT** promedio.

- **b) Round Robin (RR):**

  Este algoritmo no favorece particularmente a los procesos cortos, sino que distribuye el tiempo de CPU de manera equitativa entre todos los procesos mediante un quantum fijo.

  Cada proceso recibe CPU periódicamente, lo que garantiza buen tiempo de respuesta y evita starvation.

  Si bien los procesos cortos pueden terminar en pocas rondas, también pueden verse retrasados por cambios de contexto frecuentes y por tener que esperar su turno en la cola.

- **c) Multilevel feedback queue:** Este algoritmo favorece tanto a los procesos cortos como interactivos, pero sin dejar en inanición al resto, ya que los procesos comienzan por lo general en la más alta prioridad utilizando **Round Robin** pero si consumen todo el quantum se los baja de prioridad.

---

## Ejercicio 14

Empecemos con datos del problema: 

- El sistema tiene procesos interactivos y procesamiento de datos.

- Estos procesos de procesamiento de datos leen archivos inmensos, realizan pequeñas cuentas y luego escriben resultados.

- Lo deseado es que los procesos interactivos se perciban fluidos y no perjudicar el **throughput** del sistema.

Con esto en mente, los procesos que leen archivos muy grandes tienden a tener **ráfagas largas de CPU**, por lo que si uno de estos procesos se ejecuta antes que uno interactivo, puede generar una mala percepción de respuesta. Por otro lado, los procesos interactivos suelen tener **ráfagas cortas de CPU**, ya que frecuentemente se bloquean esperando operaciones de **E/S**.

Por lo tanto, lo más conveniente en este caso sería utilizar **Round Robin**, ya que asigna un tiempo equitativo a todos los procesos, permitiendo que los procesos interactivos accedan rápidamente a la CPU y mejoren su tiempo de respuesta. Si bien introduce cierto overhead por cambios de contexto (lo que puede afectar levemente el throughput), mantiene un buen equilibrio general, ya que los procesos largos continúan ejecutándose en múltiples quantums. Además de asignar un quantum razonable para minimizar el impacto en el throughput del sistema.

---

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

---

## Ejercicio 16

Vamos con los datos que tenemos sobre el problema:

- Tenemos procesos de detección y guardado de videos en un servidor. En el problema se menciona que evitemos algoritmos poco "justos". Estos son intensivos en **E/S**.
- Luego tenemos un proceso de alarma que es crítico que se active antes de una deadline determinada. Por lo tanto el proceso es **REAL TIME**.
- Por la noche se aplica un proceso de compresión de las grabaciones de las cámaras, y las cámaras se activan solo con movimiento en este período, lo que conlleva que los procesos de grabado sean muy escasos y con ráfagas cortas.

---

### Política de Scheduling

La política de scheduling que vamos a plantear es la siguiente: vamos a utilizar un algoritmo de **Colas Multinivel** con desalojo, con las siguientes colas:

> **Nota:** A menor número, mayor es la prioridad.

- **Cola de prioridad 0 (Tiempo Real / Crítica):** En esta cola unificada ubicamos tanto el proceso que detecta los riesgos y alerta a los operadores como el que dispara la alarma física. Al tratarse de un entorno de tiempo real estricto (Hard Real-Time) donde se deben cumplir plazos de ejecución rigurosos, se utilizará el algoritmo Earliest Deadline First (EDF). De esta manera, el planificador garantiza que, ante la presencia de múltiples eventos, siempre se ejecute primero el proceso con la fecha límite (deadline) más urgente (como el disparo inmediato de la alarma), evitando retrasos catastróficos que un algoritmo no planificado por plazos (como FIFO) podría ocasionar.

- **Cola de prioridad 1:** En esta cola van los procesos relacionados al procesamiento de video y detección de objetos, con un algoritmo **Round Robin** para que sea lo más justo posible con el tiempo de **CPU** de cada proceso, y un quantum de duración razonable, ya que uno muy corto podría generar un overhead debido al context switch, ya que el procesamiento de video es muy demandante en cuanto a **CPU**. La eleccion es debido a que tenemos procesos intensivos en **I/O** y en **CPU** por lo tanto **Round Robin** es la mejor opccion.

- **Cola de prioridad 2:** Por último, en esta cola vamos a tener los procesos que corren de noche para la compresión de video. Como de noche las grabaciones son pocas, las colas 1 y 2 van a estar casi vacías debido al modo de detección de movimiento, por lo tanto estos procesos van a poder ejecutarse sin inconvenientes. En caso de **aging** (envejecimiento de los procesos), van a poder escalar su prioridad, esto es necesario debido a que podría ocasionar **starvation**. Se utiliza una política **FCFS** ya que la compresión de video es demandante en cuanto a **CPU**.

Como mencioné anteriormente, se cuenta con desalojo porque ante la llegada de un proceso de mayor prioridad se pasa directamente a ejecutarlo. Vamos con un escenario que muestre la importancia del tipo de scheduler elegido:

Imaginemos que son las 3 de la mañana, **la cola de prioridad 2** está ejecutando un proceso de compresión de video. En ese momento una cámara detecta movimiento y dispara el proceso de alarma (Cola 0). Sin desalojo, el proceso de compresión seguiría ejecutándose hasta terminar su ráfaga de CPU, retrasando la alarma y potencialmente comprometiendo la seguridad. Con desalojo, el scheduler interrumpe inmediatamente la compresión y ejecuta el proceso de alarma, garantizando que se active dentro de su deadline.

---

## Ejercicio 17 (Guia Vieja es el ejercicio 14)

Vamos con los datos que tenemos sobre el problema:

- El sistema atiende tareas interactivas de varias sucursales bancarias, eso quiere decir que es intensivo en **E/S**.
- Por otro lado tenemos que frente a un caso de robo se genera un proceso que activa una alarma en la central.

Con eso en mente, nos  da una pista de que hay 2 o inclusive 3 prioridades.

### Algoritmo de Scheduling

Para este caso vamos a utilizar colas de prioridad multinivel preemptive, debido a que tenemos grandes distinciones y urgencias en los procesos que se ejecutan en el sistema.

Para el algritmo vamos a utilizar 2 niveles de prioriad a continuación describimos cada cola correspondiente:

- **Cola de prioridad 0 proceso de alarma:** En está primera cola solo van a estar todos los procesos correspondientes a las alarmas de las distintas sucursales, aqui vamos a utilizar el algiritmo **FCFS/FIFO** debido a que los pedido de alarma llegan en orden y se tienen que responder en el mismo, ya que el orden marca la urgencia de las mismas.

- **Cola de prioridad 1 procesos interactivos:** Aquí vamos a tener todos los procesos interactivos de todas las sucursales, en esta cola vamos a utilizar el algoritmo **Round Robin** ya que al tratarse de procesos interativos es decir intensos en rafagas de **E/S** necesitamos ser lo más justos posibles para tener un buen **tiempo de respuesta**.

Por otro lado, si nos paramos a mirar podemos sufrir de **starvation**, debido a que podria suceder que todos las sucursales disparan sus alarmas en el mismo momento entonces van a acaparar toda la **CPU**, pero verdaderamente es un comportamiento deseado asi que no nos preocupa.

Tambien podriamos añadir una cola más si tenemos procesos batch o intensivos en **CPU**, pero aqui si tendriamos que considerar el tema de la **statvation**, podriamos aplicar **agin** aqui mismo pero limitar la prioriadad hasta la cola 1 y que no suban a la cola de prioridad 0 que esta reservado solo para alarmas.

El algoritmo debe ser si o si preemptive debido a que si estamos ejecutando una tarea interactiva, puede pasar que llegue una alarma de otra sucursal y en ese caso nos gustaria poder dejar de ejecutar este proceso con menor prioridad debido a que es menos urgente.

