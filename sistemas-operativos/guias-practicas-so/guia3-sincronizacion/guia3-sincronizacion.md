# Práctica 3: Sincronizacion entre procesos

> Los enunciados de los ejercicios se encuentran en el PDF aparte [Enunciados](p3.pdf).

## Ejercicio 1

### a) 

No, hay distintas salidas dependiendo del orden de ejecucion ya que no se especifica el mismo para ambas funciones en los 2 procesos.

### b)

Por cada proceso tenemos 2 salidas posibles dependiendo del orden de ejecucion de `A` y `B`:

>**Aclaracion:** Voy a simbolizar $A \rightarrow B$ para indicar que se ejecuta A y luego B

---

#### Proceso 1

- $A \rightarrow B$: La salida para este caso seria simplemente el valor 1, ya que primero se actualiza la variable x que originalmente vale 0, se le suma 1 y printea B incrementa el valor pero no se imprime.

- $B \rightarrow A$: La salida para este caso seria el valor 2, ya que primero se ejecuta B que incrementa la variable x en 1, luego A que vuelve a hacer lo mismo por lo tanto imprime el valor 2. 

#### Proceso 2

- $A \rightarrow B$: En esta caso primero se imprime 0, 1, 2 y 3 por el proceso A, y termina igual a 1, se ejecuta B y no imprime nada porque x = 4.

- $B \rightarrow A$: B evalua el ciclo y entra, luego el if pero no entra ya que `y = 0` y se queda loopeando hasta que A haga algo, A ejecuta su primer iteracion, printea 0 y pone y = 1, si justo entra B printea a.

Una posible salida: es 1a2a3a...

## Ejercicio 2

Contamos con el siguiente codigo:

```C
x = 0; // variable compartida
mutex(1); //mutex compartido

while(1) {
  mutex.wait();
  y = x; //lectura de 
  mutex.signal();
  if (y < 5) {
    x++;
  } else {
    x--;
  }
}
```

El programa como tal cumple con lo planteado ya que antes de leer la varible se hace un wait, hasta que se libere el mutex, se lee y por utlimo se libera con un signal. Pero este programa puede ser victima de una **race condition** debido a que el if que se ejecuta posteriormente depende de una variable compartida que puede ser modificada apenas se solto el mutex.

Ademas `x++` y `x--` no son escrituras atomicas pueden sufrir de interrupciones.

Pongamos un ejemplo para que se vea mejor:

- Si x = 5. El proceso 1 lee 5 y suelta el mutex. El proceso 2 entra, lee 5 y suelta el mutex.

- Ambos entran al `if (y <= 5)`.

- Ambos ejecutan `x++`.

- Resultado: x = 7.

Fallo ya que el segundo proceso deberia haber leido un 6 y restado 1.

## Ejercicio 3

Si utilizamos una cola, los pedidos se ejecutan en orden, por lo tanto los más viejos son los que se procesan primero.
Si en cambio utilizamos una pila (LIFO, Last In, First Out), los pedidos más nuevos tienen prioridad sobre los viejos. En un sistema en el cual se hacen muchos pedidos, los más viejos no llegarán a ejecutarse antes de que los más nuevos se terminen, por lo tanto esto genera inanición.

## Ejercicio 4

Recordemos el funcionamiento de `wait()` y `signal()` el cual es el siguiente: 

```plaintext
wait(s):   while (s <= 0) dormir(); s--;
signal(s): s++; if (alguien espera por s) despertar a alguno;
```

Es decir la operacion `wait` lee una variable compartida s y se fija si es menor o igual a 0, en caso de serlo lo pone a dormir, si no decrementa la variable compartida.

Por otro lado `signal` utiliza tambien esa variable compartida, primero la incrementa si hay alguien esperando despierta.

**q.v.q:** En caso de que las operaciones `wait` y `signal` no se ejecuten de manera atomica, entonces se viola la propiedad de exclusion mutua.

Supongamos que las operaciones no se ejecutan de manera atomica, entonces lo que podria pasar es que durante el FETCH del valor de s en memoria, mas de un proceso capture el valor de la misma siendo s > 0 en ese instante por lo que podria ingresar en la seccion critica. Por lo tanto rompre con la exclusion mutua.

## Ejercicio 5

Contamos con el siguiente codigo:

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

Notemos que `signal` de barrera se ejecuta una sola vez es decir que cuando llega el problema n se libera solo para el n-1. 

Para corregir el codigo podemos hacer lo siguiente cada vez que se llama `barrera.signal()` se mete la ficha en la caja, podemos asumir que podemos meter tantas fichas como sea.

>**Aclaracion:** Asumo que critica() se puede ejecutar en paralelo.

```C
semaphore mutex = 1;
semaphore barrera = 0;
int count = 0;

preparado();

mutex.wait();
count = count + 1;
if (count == n) {
  barrera.signal(); //Aqui libero el ultimo proceso en llegar.
}
mutex.signal();


barrera.wait();   // El proceso se bloquea aqui hasta recibir la señal de barrea.
barrera.signal(); // Aqui el proceso despierta y libera al siguiente
critica();
```

Con esto resolvemos la inanición debido a que se van liberando de forma secuencial.

## Ejercicio 6

Contamos con el codigo del ejercicio anterior, y debemos corregirlo utilizando solo herramientas atomicas vistas en clase:

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
