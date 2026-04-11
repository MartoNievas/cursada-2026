# Scheduling (Planificación de Procesos)

**Sistemas Operativos — FCEyN, Universidad de Buenos Aires**

---

## 1. ¿Qué es el Scheduling?

El **scheduling** es la política que determina a qué proceso le corresponde ejecutar en cada momento. Es una de las principales "huellas de identidad" de un sistema operativo.

- Es tan importante que algunos SO proveen **más de una** política configurable
- Buena parte del esfuerzo por optimizar el rendimiento de un SO se gasta en la política de scheduling
- Pocas cosas tienen mayor impacto en el rendimiento de un SO que su política de scheduling

### El Scheduler

El **scheduler** (planificador) es el componente del kernel responsable de implementar esta política:
- Mantiene la **tabla de procesos** (lista de PCBs)
- Decide qué proceso pasa de estado **LISTO** a estado **CORRIENDO**
- Se activa en cada interrupción del clock, en syscalls, y en cambios de estado de procesos

---

## 2. Estados de un Proceso (Repaso)

```
    nuevo ──admitted──> LISTO <──── I/O completada ────── ESPERANDO
                          |                                    ↑
                   scheduler dispatch                    I/O o evento
                          ↓                                    |
                       CORRIENDO ─────────────────────────────>
                          |
                        exit
                          ↓
                       TERMINADO
                          ↑
                    interrupt (preemption)
                    (vuelve a LISTO)
```

---

## 3. Objetivos de la Política de Scheduling

El scheduler debe optimizar una **función objetivo** que combina múltiples metas, muchas de ellas contradictorias:

| Objetivo | Descripción |
|----------|-------------|
| **Ecuanimidad (fairness)** | Cada proceso recibe una dosis "justa" de CPU |
| **Eficiencia** | La CPU está ocupada todo el tiempo |
| **Carga del sistema** | Minimizar la cantidad de procesos listos esperando CPU |
| **Tiempo de respuesta** | Minimizar el tiempo percibido por usuarios interactivos |
| **Latencia** | Minimizar el tiempo para que un proceso empiece a dar resultados |
| **Tiempo de ejecución (turnaround)** | Minimizar el tiempo total de ejecución de un proceso |
| **Throughput** | Maximizar el número de procesos terminados por unidad de tiempo |
| **Liberación de recursos** | Hacer que terminen antes los procesos que tienen más recursos reservados |

> **Nota:** Muchos de estos objetivos son **contradictorios**. No se puede tener todo a la vez. Cada política busca maximizar una combinación de estas metas.

### Métricas clave

Para comparar algoritmos usaremos:

- **Tiempo de llegada (arrival time):** cuándo llega el proceso al sistema
- **Tiempo de burst (burst time):** cuánto tiempo de CPU necesita
- **Tiempo de finalización (completion time):** cuándo termina
- **Turnaround time:** `completion time - arrival time` (tiempo total en el sistema)
- **Waiting time:** `turnaround time - burst time` (tiempo esperando en la cola de listos)
- **Response time:** tiempo hasta la primera respuesta (útil para sistemas interactivos)

---

## 4. Cuándo actúa el Scheduler

El scheduling puede ser **cooperativo** o **con desalojo (preemptive)**.

### 4.1 Scheduling Cooperativo (Non-preemptive)

- El scheduler actúa cuando el **kernel toma control** (en syscalls)
- Especialmente cuando el proceso hace E/S
- A veces se proveen llamadas explícitas para ceder la CPU (`sched_yield()`)
- El proceso no puede ser interrumpido en medio de su quantum

**Problema:** un proceso puede monopolizar la CPU si no hace syscalls ni E/S.

### 4.2 Scheduling con Desalojo (Preemptive)

- El scheduler puede **interrumpir** un proceso en cualquier momento
- Se vale de la **interrupción del clock** (que ocurre 50-60 veces por segundo)
- Cuando el clock interrumpe, el SO decide si el proceso actual sigue o le toca a otro
- Es más justo y responsivo, pero tiene overhead

**Limitaciones del scheduling con desalojo:**
- Requiere un clock con interrupciones (puede no estar disponible en procesadores embebidos)
- No le da garantías de continuidad a los procesos (problema en SO de tiempo real)

> En la práctica, los schedulers modernos **combinan ambos enfoques**: usan desalojo por clock, pero también analizan la situación en cada syscall.

---

## 5. Algoritmos de Scheduling

### 5.1 FCFS — First Come, First Served (FIFO)

**Idea:** los procesos se atienden en el **orden de llegada**, sin importar cuánto CPU necesitan.

**Características:**
- Simple de implementar (cola FIFO)
- **No tiene desalojo** (non-preemptive)
- Supone que todos los procesos son iguales
- **Problema:** el "efecto convoy" — un proceso largo bloquea a todos los cortos

---

#### Ejemplo FCFS

Procesos con sus tiempos de llegada y burst:

| Proceso | Llegada | Burst |
|---------|---------|-------|
| P1 | 0 | 10 |
| P2 | 1 | 5 |
| P3 | 2 | 8 |

**Diagrama de Gantt:**

```
  0         10        15              23
  |─────────|─────────|───────────────|
  |   P1    |   P2    |      P3       |
  └─────────┴─────────┴───────────────┘
  0        10        15              23
```

**Cálculo:**

| Proceso | Llegada | Burst | Finalización | Turnaround | Waiting |
|---------|---------|-------|--------------|------------|---------|
| P1 | 0 | 10 | 10 | 10 - 0 = **10** | 10 - 10 = **0** |
| P2 | 1 | 5 | 15 | 15 - 1 = **14** | 14 - 5 = **9** |
| P3 | 2 | 8 | 23 | 23 - 2 = **21** | 21 - 8 = **13** |

- **Turnaround promedio:** (10 + 14 + 21) / 3 = **15 unidades**
- **Waiting time promedio:** (0 + 9 + 13) / 3 = **7.33 unidades**

**Problema del efecto convoy:** P2 y P3 son mucho más cortos que P1, pero deben esperar que P1 (largo) termine. Esto es ineficiente.

---

### 5.2 SJF — Shortest Job First (Trabajo más corto primero)

**Idea:** siempre ejecutar el proceso que **necesita menos CPU** entre los disponibles.

**Características:**
- Está ideado para sistemas con trabajos **batch**
- Orientada a **maximizar el throughput** y minimizar la latencia promedio
- Si se conocen las duraciones de antemano, es **óptimo** en cuanto a latencia promedio
- Puede ser preemptive (SRTF) o non-preemptive
- **Problema principal:** ¿cómo saber cuánta CPU va a necesitar un proceso?

**Solución al problema de predicción:** usar el historial pasado. Si el proceso usó en promedio T unidades de CPU antes, se predice que usará T de nuevo (exponential averaging).

---

#### Ejemplo SJF (Non-preemptive)

| Proceso | Llegada | Burst |
|---------|---------|-------|
| P1 | 0 | 7 |
| P2 | 2 | 4 |
| P3 | 4 | 1 |
| P4 | 5 | 4 |

**Razonamiento paso a paso:**
- t=0: Solo P1 disponible → ejecuta P1 (no puede elegir nada más)
- t=7: Disponibles: P2(4), P3(1), P4(4) → elige P3 (burst más corto = 1)
- t=8: Disponibles: P2(4), P4(4) → empate, elige P2 (llegó antes)
- t=12: Disponibles: P4(4) → ejecuta P4
- t=16: Fin

**Diagrama de Gantt:**

```
  0              7   8    12            16
  |──────────────|───|─────|────────────|
  |     P1       | P3|  P2 |     P4     |
  └──────────────┴───┴─────┴────────────┘
```

**Cálculo:**

| Proceso | Llegada | Burst | Inicio | Finalización | Turnaround | Waiting |
|---------|---------|-------|--------|--------------|------------|---------|
| P1 | 0 | 7 | 0 | 7 | 7 - 0 = **7** | 7 - 7 = **0** |
| P2 | 2 | 4 | 8 | 12 | 12 - 2 = **10** | 10 - 4 = **6** |
| P3 | 4 | 1 | 7 | 8 | 8 - 4 = **4** | 4 - 1 = **3** |
| P4 | 5 | 4 | 12 | 16 | 16 - 5 = **11** | 11 - 4 = **7** |

- **Turnaround promedio:** (7 + 10 + 4 + 11) / 4 = **8 unidades**
- **Waiting time promedio:** (0 + 6 + 3 + 7) / 4 = **4 unidades**

---

#### Ejemplo SRTF — Shortest Remaining Time First (SJF Preemptive)

El mismo conjunto de procesos, pero ahora el scheduler puede desalojar si llega un proceso con burst más corto que el restante del actual.

| Proceso | Llegada | Burst |
|---------|---------|-------|
| P1 | 0 | 7 |
| P2 | 2 | 4 |
| P3 | 4 | 1 |
| P4 | 5 | 4 |

**Razonamiento paso a paso:**
- t=0: Llega P1(7) → ejecuta P1. Restante P1 = 7
- t=2: Llega P2(4). Restante P1 = 5. 4 < 5 → desaloja P1, ejecuta P2
- t=4: Llega P3(1). Restante P2 = 2. 1 < 2 → desaloja P2, ejecuta P3
- t=5: Llega P4(4). P3 aún tiene 0 restante (termina en t=5). Disponibles: P1(5), P2(2), P4(4). Elige P2(2)
- t=7: P2 termina. Disponibles: P1(5), P4(4). Elige P4(4)... espera, P1 restante=5, P4=4 → elige P4
- t=11: P4 termina. Solo P1(5) → ejecuta P1
- t=16: P1 termina

**Diagrama de Gantt:**

```
  0   2   4 5   7           11            16
  |───|───|─|───|────────────|─────────────|
  |P1 |P2 |P3|P2|    P4      |     P1      |
  └───┴───┴─┴───┴────────────┴─────────────┘
```

**Cálculo:**

| Proceso | Llegada | Burst | Finalización | Turnaround | Waiting |
|---------|---------|-------|--------------|------------|---------|
| P1 | 0 | 7 | 16 | 16 - 0 = **16** | 16 - 7 = **9** |
| P2 | 2 | 4 | 7 | 7 - 2 = **5** | 5 - 4 = **1** |
| P3 | 4 | 1 | 5 | 5 - 4 = **1** | 1 - 1 = **0** |
| P4 | 5 | 4 | 11 | 11 - 5 = **6** | 6 - 4 = **2** |

- **Turnaround promedio:** (16 + 5 + 1 + 6) / 4 = **7 unidades**
- **Waiting time promedio:** (9 + 1 + 0 + 2) / 4 = **3 unidades**

> SRTF logra menor turnaround y waiting que SJF non-preemptive, pero tiene mayor overhead por los context switches adicionales.

---

### 5.3 Scheduling por Prioridades

**Idea:** asignar una **prioridad** a cada proceso. El scheduler siempre elige el de mayor prioridad.

**Puede ser:**
- **Preemptive:** si llega un proceso de mayor prioridad, desaloja al actual
- **Non-preemptive:** el proceso de mayor prioridad corre hasta que se bloquea o termina

**Problema crítico: Inanición (Starvation)**
> Los procesos de mayor prioridad pueden demorar **indefinidamente** a los de menor prioridad, que nunca se ejecutan.

**Solución: Aging (envejecimiento)**
- Aumentar la prioridad de los procesos a medida que **envejecen** (más tiempo esperando = mayor prioridad)
- Garantiza que eventualmente todos los procesos ejecuten

> **Principio general:** cualquier esquema de prioridades **fijas** corre riesgo de inanición.

---

#### Ejemplo Scheduling por Prioridades (Non-preemptive)

Convención: **menor número = mayor prioridad**

| Proceso | Llegada | Burst | Prioridad |
|---------|---------|-------|-----------|
| P1 | 0 | 10 | 3 |
| P2 | 0 | 1 | 1 |
| P3 | 0 | 2 | 4 |
| P4 | 0 | 1 | 5 |
| P5 | 0 | 5 | 2 |

Todos llegan en t=0. Orden de ejecución por prioridad: P2(1) → P5(2) → P1(3) → P3(4) → P4(5)

**Diagrama de Gantt:**

```
  0 1     6              16    18   19
  |─|─────|──────────────|─────|────|
  |P2| P5 |      P1      |  P3 | P4 |
  └─┴─────┴──────────────┴─────┴────┘
```

**Cálculo:**

| Proceso | Llegada | Burst | Prioridad | Finalización | Turnaround | Waiting |
|---------|---------|-------|-----------|--------------|------------|---------|
| P1 | 0 | 10 | 3 | 16 | 16 | 6 |
| P2 | 0 | 1 | 1 | 1 | 1 | 0 |
| P3 | 0 | 2 | 4 | 18 | 18 | 16 |
| P4 | 0 | 1 | 5 | 19 | 19 | 18 |
| P5 | 0 | 5 | 2 | 6 | 6 | 1 |

- **Turnaround promedio:** (16 + 1 + 18 + 19 + 6) / 5 = **12 unidades**
- **Waiting time promedio:** (6 + 0 + 16 + 18 + 1) / 5 = **8.2 unidades**

**Observación:** P3 y P4 (baja prioridad) tienen tiempos de espera muy altos. Si continuamente llegaran procesos de alta prioridad, nunca ejecutarían → inanición.

---

### 5.4 Round Robin (RR)

**Idea:** dar un **quantum** (ventana de tiempo) a cada proceso, e ir alternando entre ellos en orden circular. Es el algoritmo más usado en sistemas de propósito general.

**Características:**
- **Preemptive por naturaleza**
- Ecuánime: cada proceso recibe la misma dosis de CPU
- Se combina frecuentemente con prioridades
- Los procesos que hacen E/S suelen recibir crédito extra (son "buenos compañeros")

**Elección del quantum:**

| Quantum muy largo | Quantum muy corto |
|-------------------|-------------------|
| Degenera en FCFS | Overhead de context switch es significativo |
| Mala respuesta interactiva | Sistema pasa mucho tiempo en "mantenimiento" |

**Regla práctica:** el quantum debe ser mayor que el 80% de los tiempos de burst de los procesos. Valores típicos: 10-100 ms.

---

#### Ejemplo Round Robin (quantum = 4)

| Proceso | Llegada | Burst |
|---------|---------|-------|
| P1 | 0 | 10 |
| P2 | 1 | 5 |
| P3 | 2 | 8 |

**Simulación paso a paso:**

Cola de listos (en orden de llegada):

- **t=0:** Cola = [P1]. Ejecuta P1 por 4 unidades.
- **t=4:** P1 usó 4 de 10 (restante: 6). Cola = [P2, P3, P1]. Ejecuta P2.
- **t=8:** P2 usó 4 de 5 (restante: 1). Cola = [P3, P1, P2]. Ejecuta P3.
- **t=12:** P3 usó 4 de 8 (restante: 4). Cola = [P1, P2, P3]. Ejecuta P1.
- **t=16:** P1 usó 4 de 6 (restante: 2). Cola = [P2, P3, P1]. Ejecuta P2.
- **t=17:** P2 usó 1 de 1 → **P2 termina**. Cola = [P3, P1]. Ejecuta P3.
- **t=21:** P3 usó 4 de 4 → **P3 termina**. Cola = [P1]. Ejecuta P1.
- **t=23:** P1 usó 2 de 2 → **P1 termina**.

**Diagrama de Gantt:**

```
  0       4       8       12      16 17    21    23
  |───────|───────|───────|───────|──|─────|─────|
  |   P1  |  P2   |   P3  |  P1   |P2| P3  |  P1 |
  └───────┴───────┴───────┴───────┴──┴─────┴─────┘
```

**Cálculo:**

| Proceso | Llegada | Burst | Finalización | Turnaround | Waiting |
|---------|---------|-------|--------------|------------|---------|
| P1 | 0 | 10 | 23 | 23 - 0 = **23** | 23 - 10 = **13** |
| P2 | 1 | 5 | 17 | 17 - 1 = **16** | 16 - 5 = **11** |
| P3 | 2 | 8 | 21 | 21 - 2 = **19** | 19 - 8 = **11** |

- **Turnaround promedio:** (23 + 16 + 19) / 3 = **19.33 unidades**
- **Waiting time promedio:** (13 + 11 + 11) / 3 = **11.67 unidades**

**Comparación con FCFS para los mismos procesos:**
- FCFS turnaround: 15.0 | RR turnaround: 19.33
- FCFS waiting: 7.33 | RR waiting: 11.67

> Round Robin tiene **peor turnaround** que FCFS (aquí), pero mucho mejor **tiempo de respuesta** para los procesos cortos: P2 empieza a ejecutar en t=4 en lugar de t=10.

---

#### Ejemplo Round Robin con quantum = 2

Mismo conjunto de procesos para mostrar el impacto del quantum:

| Proceso | Llegada | Burst |
|---------|---------|-------|
| P1 | 0 | 10 |
| P2 | 1 | 5 |
| P3 | 2 | 8 |

**Diagrama de Gantt (quantum=2):**

```
  0  2  4  6  8 10 12 14 16 17 19 21 23
  |──|──|──|──|──|──|──|──|──|──|──|──|
  |P1|P1|P2|P3|P1|P2|P3|P1|P2|P3|P1|P1|
  └──┴──┴──┴──┴──┴──┴──┴──┴──┴──┴──┴──┘
```

> Con quantum más corto, hay más context switches (mayor overhead), pero mejor tiempo de respuesta.

---

### 5.5 Round Robin con Prioridades

Se combina Round Robin con niveles de prioridad. Dentro de cada nivel, los procesos rotan con un quantum. Los procesos de mayor prioridad siempre se atienden antes que los de menor prioridad.

**La prioridad puede decrecer** a medida que el proceso recibe su quantum (para evitar inanición).

---

### 5.6 Múltiples Colas (Multilevel Queue)

**Idea:** tener varias colas, cada una con diferente prioridad y quantum.

**Ejemplo clásico:** colas con 1, 2, 4, 8 quanta c/u.

```
Cola 1 (prioridad máxima): quantum = 1  ← procesos interactivos, nueva llegada
Cola 2: quantum = 2
Cola 3: quantum = 4
Cola 4: quantum = 8  ← procesos de cómputo largo
```

**Reglas:**

1. La prioridad la tiene siempre la cola con **menos quanta** (cola 1 primero)
2. Cuando a un proceso **no le alcanza** su cuota de CPU, pasa a la cola siguiente (disminuye su prioridad, pero recibe más tiempo en el próximo turno)
3. Un proceso que termina de hacer E/S **vuelve a la cola de máxima prioridad** (se supone que volverá a ser interactivo)

**Objetivo:** minimizar el tiempo de respuesta para procesos interactivos, suponiendo que los cómputos largos son menos sensibles a demoras.

---

#### Ejemplo Múltiples Colas (quantum inicial = 2, luego 4, luego 8)

| Proceso | Llegada | Burst |
|---------|---------|-------|
| P1 | 0 | 10 |
| P2 | 0 | 3 |
| P3 | 0 | 6 |

**Simulación:**
- t=0: P1, P2, P3 en cola Q1 (quantum=2)
- t=0-2: ejecuta P1. Usó 2 de 10. Pasa a Q2 (quantum=4). Restante P1=8
- t=2-4: ejecuta P2. Usó 2 de 3. Pasa a Q2. Restante P2=1
- t=4-6: ejecuta P3. Usó 2 de 6. Pasa a Q2. Restante P3=4
- Q1 vacía, pasamos a Q2
- t=6-10: ejecuta P1 (quantum=4). Usó 4 de 8. Pasa a Q3. Restante P1=4
- t=10-11: ejecuta P2 (quantum=4, pero solo le falta 1). **P2 termina**
- t=11-15: ejecuta P3 (quantum=4). Usó 4 de 4. **P3 termina**
- Q2 vacía, pasamos a Q3
- t=15-19: ejecuta P1 (quantum=8, pero solo le falta 4). **P1 termina**

**Diagrama de Gantt:**

```
  0   2   4   6       10  11      15          19
  |───|───|───|───────|───|───────|───────────|
  |P1 |P2 |P3 |  P1   |P2 |  P3  |    P1     |
  |Q1 |Q1 |Q1 |  Q2   |Q2 |  Q2  |    Q3     |
  └───┴───┴───┴───────┴───┴───────┴───────────┘
```

**Cálculo:**

| Proceso | Llegada | Burst | Finalización | Turnaround | Waiting |
|---------|---------|-------|--------------|------------|---------|
| P1 | 0 | 10 | 19 | **19** | **9** |
| P2 | 0 | 3 | 11 | **11** | **8** |
| P3 | 0 | 6 | 15 | **15** | **9** |

- **Turnaround promedio:** (19 + 11 + 15) / 3 = **15 unidades**
- **Waiting time promedio:** (9 + 8 + 9) / 3 = **8.67 unidades**

---

### 5.7 Scheduling para Tiempo Real (EDF)

Los **sistemas de tiempo real** son aquellos donde las tareas tienen **deadlines** estrictos. Se usan en entornos críticos (control de vuelo, plantas industriales, dispositivos médicos): si un deadline no se cumple, algo malo ocurre.

**EDF — Earliest Deadline First:**
- Siempre ejecutar el proceso **más cercano a perder su deadline**
- Es óptimo en sistemas de tiempo real (si existe una asignación válida, EDF la encuentra)

---

#### Ejemplo EDF

| Tarea | Período | Tiempo de ejecución | Deadline |
|-------|---------|---------------------|----------|
| T1 | 20 | 3 | 20 |
| T2 | 5 | 2 | 5 |
| T3 | 10 | 2 | 10 |

**Ejecución:**
- t=0: T1(deadline=20), T2(deadline=5), T3(deadline=10). Menor deadline = T2 → ejecuta T2
- t=2: T2 termina su instancia. T1(deadline=20), T3(deadline=10). Menor = T3 → ejecuta T3
- t=4: T3 termina. Solo T1(deadline=20). Ejecuta T1.
- t=5: Nueva instancia T2(deadline=10). T1 restante=1, deadline=20. T2 deadline=10 < 20 → desaloja T1, ejecuta T2
- t=7: T2 termina. T1 restante=1. Ejecuta T1.
- t=8: T1 termina su primera instancia.

**Diagrama de Gantt:**

```
  0   2   4   5   7 8        10      15      20
  |───|───|───|───|─|─────────|───────|───────|
  |T2 |T3 |T1 |T2 |T1 (resto) ...
  └───┴───┴───┴───┴─...
```

---

### 5.8 Scheduling en SMP (Multiprocesadores)

En sistemas con múltiples CPUs, el scheduling es un problema diferente.

**El problema del caché:**
- Si un proceso migra de CPU, llega con el **caché vacío** en la nueva CPU
- El tiempo de ejecución aumenta significativamente (cache miss)
- Esto puede negar los beneficios de distribuir la carga

**Afinidad al procesador (Processor Affinity):**
- Intentar que cada proceso use **siempre el mismo procesador**
- **Afinidad dura:** garantizado (el proceso NUNCA migra)
- **Afinidad blanda:** se intenta, pero puede migrar si es necesario

**Balanceo de carga:**
- **Push migration:** un proceso periodicamente verifica la carga y *empuja* procesos desde CPUs sobrecargadas a CPUs ociosas
- **Pull migration:** una CPU ociosa *jala* un proceso de una CPU ocupada

---

## 6. NUMA — Non-Uniform Memory Access

En sistemas con múltiples procesadores, la memoria puede no ser uniforme:

```
┌─────────────────────────────────────────────┐
│                  Computadora                │
│  ┌────────────────┐     ┌────────────────┐  │
│  │      CPU       │     │      CPU       │  │
│  │       ↓        │     │       ↓        │  │
│  │  fast access   │     │  fast access   │  │
│  │       ↓        │  slow access         │  │
│  │    memoria     │ ←──────────────────> │  │
│  │                │     │    memoria     │  │
│  └────────────────┘     └────────────────┘  │
└─────────────────────────────────────────────┘
```

- Cada CPU accede a su memoria local **rápido**
- El acceso a la memoria de otra CPU es **más lento**
- El scheduler debe tener en cuenta dónde vive la memoria de cada proceso y asignarlo a la CPU correcta

---

## 7. El Linux CFS Scheduler

El **CFS** (Completely Fair Scheduler) es el scheduler estándar de Linux desde 2007. Implementa una forma de Round Robin equitativo usando una estructura de datos eficiente.

### 7.1 vruntime (Virtual Runtime)

Cada proceso tiene un atributo llamado **vruntime**: cuánto tiempo de CPU "virtual" ha consumido. El proceso con **menor vruntime** es el que más necesita CPU y ejecuta primero.

### 7.2 Árbol Rojo-Negro

Los procesos listos se organizan en un **árbol rojo-negro** (balanced binary search tree) con clave = vruntime:

```
                    T0 (vruntime medio)
                   /                  \
              T1 (menor)          T2 (mayor)
             /         \         /         \
           T3           T4     T5           T6
          /            /      \
        T7            T8      T9

← menor vruntime              mayor vruntime →
(ejecutar primero)            (puede esperar)
```

- El nodo más a la **izquierda** (menor vruntime) = próximo proceso a ejecutar
- Es el proceso que ha recibido **menos tiempo de CPU** proporcionalmente
- Linux cachea el nodo más a la izquierda en `rb_leftmost` para acceso O(1)

### 7.3 Funcionamiento

1. El proceso con menor `vruntime` ejecuta
2. Mientras ejecuta, su `vruntime` aumenta
3. Eventualmente, otro proceso tiene menor `vruntime` → context switch
4. Los procesos con alta prioridad tienen su `vruntime` incrementado más lento (reciben más CPU)

---

## 8. Comparación de Algoritmos

### Resumen numérico

Usando el ejemplo: P1(burst=10), P2(burst=5), P3(burst=8), todos con llegada ≈ 0:

| Algoritmo | Turnaround Promedio | Waiting Promedio | Respuesta |
|-----------|--------------------|--------------------|-----------|
| FCFS | 15.0 | 7.33 | Malo |
| SJF (NP) | 11.0 | 4.33 | Bueno |
| RR (q=4) | 19.33 | 11.67 | Muy bueno |
| Prioridades (NP) | Variable | Variable | Puede ser malo |

### Tabla de características

| Algoritmo | Preemptive | Starvation | Overhead | Mejor para |
|-----------|-----------|------------|----------|------------|
| **FCFS** | No | No | Muy bajo | Sistemas simples, batch |
| **SJF** | Opcional | Sí | Bajo-medio | Batch, throughput |
| **Prioridades** | Opcional | Sí (sin aging) | Bajo-medio | Sistemas con clases de procesos |
| **Round Robin** | Sí | No | Medio | Sistemas interactivos, tiempo compartido |
| **Múlt. Colas** | Sí | Posible | Medio-alto | Sistemas de propósito general |
| **EDF** | Sí | No | Alto | Tiempo real |

---

## 9. Consideraciones Prácticas

### 9.1 Fairness: ¿entre procesos o usuarios?

Un usuario puede tener varios procesos. ¿El scheduling debe ser equitativo entre **procesos** o entre **usuarios**? Si el usuario A tiene 10 procesos y el usuario B tiene 1, ¿el usuario A recibe 10 veces más CPU?

### 9.2 Procesos hijos

Si un proceso lanza muchos procesos hijos, ¿cuentan como parte de la cuota del padre? ¿Heredan su prioridad?

### 9.3 Procesos CPU-intensivos

Si un proceso consume mucha CPU, ¿lo prioritizo (tiene trabajo) o lo castigo (está abusando del sistema)? Tal vez haya usuarios hostiles intentando hacer un ataque de denegación de servicio.

### 9.4 Heurísticas útiles

- Si un proceso **abre una terminal**, muy probablemente va a volverse interactivo → darle mayor prioridad
- Se puede usar **análisis estático** para predecir comportamiento
- Los procesos que hacen E/S frecuente son "buenos compañeros" y suelen recibir crédito extra

### 9.5 Cómo se evalúa un scheduler en la práctica

- **Modelos matemáticos:** basados en teoría de colas
- **Simulación:** con trazas de carga real o benchmarks estandarizados
- **Prueba en producción:** prueba/error/corrección, ajustando a medida que cambian los patrones de uso

---

## 10. Resumen de Fórmulas

| Métrica | Fórmula |
|---------|---------|
| **Turnaround time** | `completion_time - arrival_time` |
| **Waiting time** | `turnaround_time - burst_time` |
| **Response time** | `first_execution_time - arrival_time` |
| **Turnaround promedio** | `Σ turnaround_i / n` |
| **Waiting promedio** | `Σ waiting_i / n` |
| **CPU utilization** | `tiempo_útil / tiempo_total × 100%` |
| **Throughput** | `procesos_completados / unidad_de_tiempo` |

---

## Resumen General

| Concepto | Descripción |
|----------|-------------|
| **Scheduler** | Componente del kernel que decide qué proceso ejecuta |
| **Preemptive** | El SO puede desalojar un proceso en cualquier momento |
| **Quantum** | Tiempo máximo de CPU antes del próximo context switch |
| **FCFS** | Primero en llegar, primero atendido. Simple pero injusto con procesos cortos |
| **SJF** | El más corto ejecuta primero. Óptimo en teoría, difícil de implementar |
| **Prioridades** | Procesos con mayor prioridad van primero. Riesgo de inanición |
| **Round Robin** | Quantum equitativo para todos. Estándar en sistemas interactivos |
| **Múltiples colas** | Combina prioridades con quantum variable. Más sofisticado |
| **EDF** | El de deadline más cercano primero. Para tiempo real |
| **Inanición** | Un proceso nunca ejecuta porque siempre hay otros de mayor prioridad |
| **Aging** | Aumentar prioridad con el tiempo para evitar inanición |
| **Afinidad** | Preferir que un proceso use siempre el mismo procesador (caché) |
| **CFS** | Completely Fair Scheduler de Linux, usa árbol rojo-negro con vruntime |
