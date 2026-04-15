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
