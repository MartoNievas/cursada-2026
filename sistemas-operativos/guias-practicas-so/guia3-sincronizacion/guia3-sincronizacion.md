# Práctica 3: Sincronización entre procesos

> Los enunciados de los ejercicios se encuentran en el PDF aparte [Enunciados](p3.pdf).

## Ejercicio 1

### a)

No, hay distintas salidas dependiendo del orden de ejecución ya que no se especifica el mismo para ambas funciones en los 2 procesos.

### b)

Por cada proceso tenemos 2 salidas posibles dependiendo del orden de ejecución de `A` y `B`:

> **Aclaración:** Voy a simbolizar $A \rightarrow B$ para indicar que se ejecuta A y luego B.

---

#### Proceso 1

- $A \rightarrow B$: La salida para este caso sería simplemente el valor 1, ya que primero se actualiza la variable x que originalmente vale 0, se le suma 1 y printea. B incrementa el valor pero no se imprime.

- $B \rightarrow A$: La salida para este caso sería el valor 2, ya que primero se ejecuta B que incrementa la variable x en 1, luego A que vuelve a hacer lo mismo, por lo tanto imprime el valor 2.

#### Proceso 2

- $A \rightarrow B$: En este caso primero se imprime 0, 1, 2 y 3 por el proceso A, y termina igual a 1. Se ejecuta B y no imprime nada porque x = 4.

- $B \rightarrow A$: B evalúa el ciclo y entra, luego el if pero no entra ya que `y = 0` y se queda loopeando hasta que A haga algo. A ejecuta su primera iteración, printea 0 y pone y = 1, si justo entra B printea a.

Una posible salida: `1a2a3a...`

## Ejercicio 2

Contamos con el siguiente código:

```C
x = 0; // variable compartida
mutex(1); // mutex compartido

while(1) {
  mutex.wait();
  y = x; // lectura de x
  mutex.signal();
  if (y < 5) {
    x++;
  } else {
    x--;
  }
}
```

El programa como tal cumple con lo planteado ya que antes de leer la variable se hace un wait hasta que se libere el mutex, se lee y por último se libera con un signal. Pero este programa puede ser víctima de una **race condition** debido a que el if que se ejecuta posteriormente depende de una variable compartida que puede ser modificada apenas se soltó el mutex.

Además `x++` y `x--` no son escrituras atómicas y pueden sufrir de interrupciones.

Pongamos un ejemplo para que se vea mejor:

- Si x = 5, el proceso 1 lee 5 y suelta el mutex. El proceso 2 entra, lee 5 y suelta el mutex.
- Ambos entran al `if (y <= 5)`.
- Ambos ejecutan `x++`.
- Resultado: x = 7.

Falló, ya que el segundo proceso debería haber leído un 6 y restado 1.

## Ejercicio 3

Si utilizamos una cola, los pedidos se ejecutan en orden, por lo tanto los más viejos son los que se procesan primero.

Si en cambio utilizamos una pila (LIFO, Last In, First Out), los pedidos más nuevos tienen prioridad sobre los viejos. En un sistema en el cual se hacen muchos pedidos, los más viejos no llegarán a ejecutarse antes de que los más nuevos se terminen, por lo tanto esto genera **inanición**.

## Ejercicio 4

Recordemos el funcionamiento de `wait()` y `signal()`, el cual es el siguiente:

```plaintext
wait(s):   while (s <= 0) dormir(); s--;
signal(s): s++; if (alguien espera por s) despertar a alguno;
```

Es decir, la operación `wait` lee una variable compartida s y se fija si es menor o igual a 0, en caso de serlo lo pone a dormir, si no decrementa la variable compartida.

Por otro lado, `signal` utiliza también esa variable compartida, primero la incrementa y si hay alguien esperando lo despierta.

**Q.V.Q:** En caso de que las operaciones `wait` y `signal` no se ejecuten de manera atómica, entonces se viola la propiedad de exclusión mutua.

Supongamos que las operaciones no se ejecutan de manera atómica. Lo que podría pasar es que durante el FETCH del valor de s en memoria, más de un proceso capture el valor de la misma siendo s > 0 en ese instante, por lo que podría ingresar en la sección crítica. Por lo tanto rompe con la exclusión mutua.

## Ejercicio 5

Contamos con el siguiente código:

```C
semaphore mutex = 1;
semaphore barrera = 0;
int count = 0;

preparado();

mutex.wait();
count = count + 1;
mutex.signal();

if (count == n) {
  barrera.signal();
}

barrera.wait();

critica();
```

Notemos que `signal` de barrera se ejecuta una sola vez, es decir que cuando llega el proceso n se libera solo para el n-1.

Para corregir el código podemos hacer lo siguiente: cada vez que se llama `barrera.signal()` se mete la ficha en la caja, podemos asumir que podemos meter tantas fichas como sea.

> **Aclaración:** Asumo que `critica()` se puede ejecutar en paralelo.

```C
semaphore mutex = 1;
semaphore barrera = 0;
int count = 0;

preparado();

mutex.wait();
count = count + 1;
if (count == n) {
  barrera.signal(); // Aquí libero el último proceso en llegar.
}
mutex.signal();

barrera.wait();   // El proceso se bloquea aquí hasta recibir la señal de barrera.
barrera.signal(); // Aquí el proceso despierta y libera al siguiente.
critica();
```

Con esto resolvemos la inanición debido a que se van liberando de forma secuencial.

## Ejercicio 6

Contamos con el código del ejercicio anterior, y debemos corregirlo utilizando solo herramientas atómicas vistas en clase:

```C
preparado();

mutex.wait();
count = count + 1;
mutex.signal();

if (count == n) {
  barrera.signal();
}

barrera.wait();

critica();
```

Para resolver este problema utilizaremos **TTASLock (local spinning)**, el cual es una mejora del **TASLock**. La solución quedaría así:

```C
TASLock mtx = 0;
volatile int count = 0;

preparado();

mtx.lock();
count += 1;
mtx.unlock();

while(count < n);

critica();
```

### a)

La primera solución a mi parecer tiene un código más legible debido a que la barrera se declara como un semáforo y no se hace spin lock.

### b)

La solución mediante herramientas de **HW** es mucho más rápida, aunque puede llegar a consumir mucha **CPU** en el ciclo `while()` y en el lock ya que no se duerme. Lo que se podría hacer es usar **TTASLock** que consume menos.

### c)

**Solución ejercicio 5:** Esta solución necesita que el **HW** tenga soporte de instrucciones atómicas, además de que cuenta con la interrupción del reloj.

Por parte del **SO** necesitamos que implemente un gestor de bloqueos como lo son `sleep` y `wakeup`, ambas syscalls del **SO**, un scheduler para que cuando ocurra un `signal()` tenga que elegir a uno de los procesos en la cola, y también que el **SO** mantenga un control sobre qué procesos esperan un semáforo.

**Solución ejercicio 6:** Esta solución requiere soporte de instrucciones atómicas, protocolos de coherencia de caché y **memory barriers** para que las escrituras de memoria se hagan en orden. Por parte del **SO** no requiere gran soporte, con tener la memoria mapeada y un scheduler es suficiente.

## Ejercicio 7

Este ejercicio tiene que cumplir la siguiente secuencia de ejecución: tenemos los procesos $P_0, P_1, \dots, P_{N-1}$ y tenemos que sincronizarlos de tal manera que se ejecuten así: $P_i, P_{i+1}, \dots, P_0, \dots, P_{i-1}$.

```C
semaphore pasos[N]; // pasos[i] = 1, el resto en 0

void initialization(int N, int init_i) {
  for (int j = 0; j < N; j++) {
    pasos[j] = 0;
  }
  for (int j = 0; j < N; j++) {
    spawn proc(j);
  }
  pasos[i].signal();
}

void proc(int N, int i) {
  // Cada proceso espera su turno, menos el i que es el único que no duerme porque tiene 1.
  pasos[i].wait();

  printf("Ejecutando proceso %d\n", i);

  // Al terminar de ejecutar i le tengo que pasar la ficha al siguiente.
  pasos[(i + 1) % N].signal();
}
```

## Ejercicio 8

En este ejercicio decidí hacer ejemplos reales en C para aprender sobre los semáforos reales.

### 1)

[Ver código](code/ej8/ej8-1.c)

### 2)

[Ver código](code/ej8/ej8-2.c)

### 3)

[Ver código](code/ej8/ej8-3.c)

### 4)

[Ver código](code/ej8/ej8-4.c)

## Ejercicio 9

Si contamos con $N$ procesos $P_i$ y un conjunto de sentencias $a_i$ y $b_i$, y queremos ejecutar todas las $a_i$ primero, es el clásico problema de barrera. La idea es poner un semáforo que actúa de barrera hasta que se ejecutan todas las sentencias $a_i$, y en el momento en que se ejecuta la última, liberar los procesos para que ejecuten $b_i$.

La idea del pseudocódigo sería la siguiente:

```C
atomic<int> cant = 0;
semaphore barrera = 0;

proc P(i) {
  a(i);

  if (cant.getAndInc() == N - 1) {
    barrera.signal();
  }

  barrera.wait();
  barrera.signal();

  b(i);
}
```

## Ejercicio 10

Contamos con dos procesos `foo` y `bar`, que se ejecutan concurrentemente. Además comparten los semáforos **S** y **R**, ambos inician en 1, y una variable x que empieza en 0.

### a)

Sí puede haber **deadlock** debido a cómo se hacen los `semWait` en ambos procesos. Vamos con una traza de ejecución:

- Empieza a ejecutarse **foo**, entonces S = 0.
- Context switch: el scheduler le da **CPU** a `bar`.
- **bar** ejecuta `semWait(R)`, tiene éxito (R = 0).
- **foo** intenta `semWait(R)`. Se **bloquea** porque `bar` tiene R.
- **bar** intenta `semWait(S)`. Se **bloquea** porque `foo` tiene S.

**Resultado:** Deadlock.

### b)

A pesar de que se genera un **deadlock**, también puede haber inanición. Vamos con una traza de ejecución:

- `foo` adquiere S, adquiere R, incrementa `x`, libera S y libera R (se ejecuta completamente).
- Antes de que `bar` pueda ejecutar `semWait(R)`, el scheduler le da la **CPU** a `foo`.
- `foo` vuelve a entrar al do-while, toma S y R de nuevo.
- Si este ciclo se repite indefinidamente, puede generar inanición al proceso `bar`.

## Ejercicio 11

Queremos simular la comunicación entre pipes usando memoria compartida sin usar file descriptors. Contamos con un buffer con dos métodos `pop()` y `push()`.

[Ver código](code/ej11.c)

## Ejercicio 12

Acá tenemos un clásico problema de barreras, ya que primero queremos terminar una sentencia y posteriormente ejecutar otra. En este caso primero queremos `implementarTp()` y posteriormente `experimentar()`.

[Ver código](code/ej12.c)

## Ejercicio 13

### a)

Tenemos varios procesos:

- `estoyListo()` indica que la ropa puede empezar a entrar.
- Una vez que está lleno invoca a `lavar()`.
- Por último cuando está vacío invoca a `puedenDescargarme()` y queda listo para empezar de nuevo.

Es básicamente un esquema productor-consumidor. Vamos con el pseudocódigo:

```C
sem_t sem_lavarropas_listo = 0;
sem_t sem_lavado_terminado = 0;
sem_t sem_carga_completa = 0;
sem_t sem_vacio = 0;
sem_t mutex = 1; // empieza en 1 ya que es para proteger al contador de prendas.

// Cantidad de prendas en el tambor
int contador = 0;

void prenda() {
  semWait(sem_lavarropas_listo); // Esperamos a que el lavarropas esté listo para empezar a cargar

  semWait(mutex);
  contador++;
  if (contador == 10) {
    semSignal(sem_carga_completa);
  }
  semSignal(mutex);

  // Fase de lavado y descarga, esperamos a que se termine el lavado
  semWait(sem_lavado_terminado);

  // Ahora debemos descargar las prendas del lavarropas.
  semWait(mutex);
  contador--;
  if (contador == 0) {
    semSignal(sem_vacio);
  }
  semSignal(mutex);
}

// Ahora vamos con el proceso lavarropas

void lavarropas(void) {
  while(1) {
    // Avisamos que podemos empezar a cargar ropa
    estoyListo();

    // Damos 10 permisos para meter ropa
    for (int i = 0; i < 10; i++) semSignal(sem_lavarropas_listo);

    // Una vez listo debemos esperar a que la carga esté completa
    semWait(sem_carga_completa);

    // Cuando tenemos la carga completa empezamos a lavar
    lavar();

    // Cuando terminamos de lavar, avisamos a prenda que puede empezar con la descarga
    for (int i = 0; i < 10; i++) semSignal(sem_lavado_terminado);

    // Esperamos a que esté vacío el lavarropas.
    semWait(sem_vacio);
  }
}
```

### b)

Ahora cambia ligeramente el ejercicio, ya que la carga es secuencial pero la descarga es en paralelo. Vamos con el pseudocódigo:

```C
sem_t sem_lavarropas_listo = 0;
sem_t sem_lavado_terminado = 0;
sem_t sem_carga_completa = 0;
sem_t sem_vacio = 0;
sem_t mutex_contador = 1; // empieza en 1 ya que es para proteger al contador de prendas.
sem_t mutex_carga = 1;    // para ir cargando secuencialmente las prendas

// Cantidad de prendas en el tambor
int contador = 0;

void prenda(void) {
  // Esperamos que el lavarropas esté listo
  semWait(sem_lavarropas_listo);

  // Una vez listo, tenemos que ir metiendo prendas.
  semWait(mutex_carga);
  entroAlLavarropas();

  semWait(mutex_contador);
  contador++;
  if (contador < 10) {
    // Si no está lleno, llamo a la siguiente prenda
    semSignal(sem_lavarropas_listo);
  } else {
    // Soy la 10, entonces la carga está completa
    semSignal(sem_carga_completa);
  }
  // Avisamos al mutex del contador que puede ir el siguiente
  semSignal(mutex_contador);

  // Avisamos al mutex de carga que siga con el siguiente
  semSignal(mutex_carga);

  // Ahora tenemos que esperar que termine el lavado
  semWait(sem_lavado_terminado);

  // Una vez que terminó de lavar, hacemos la descarga en paralelo
  semSignal(sem_lavado_terminado);

  saqueenmeDeAqui();

  // Por último descargamos
  semWait(mutex_contador);
  contador--;
  if (contador == 0) {
    semWait(sem_lavado_terminado);
    semSignal(sem_vacio);
  }
  semSignal(mutex_contador);
}

// Ahora vamos con el proceso lavarropas

void lavarropas(void) {
  while(1) {
    // Decimos que estamos listos
    estoyListo();

    // Avisamos que estamos listos para cargar las prendas
    semSignal(sem_lavarropas_listo);

    // Ahora esperamos a que la carga esté completa
    semWait(sem_carga_completa);

    // Ahora lavamos
    lavar();

    puedenDescargarme();
    semSignal(sem_lavado_terminado);

    // Por último esperamos a que salgan todas las prendas
    semWait(sem_vacio);
  }
}
```
