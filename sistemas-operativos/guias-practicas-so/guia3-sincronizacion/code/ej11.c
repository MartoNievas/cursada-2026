#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>

#define N 100

void *buffer[N];
int in = 0;
int out = 0;
// Le pones el valor del tamaño del buffer para que cuando se llene llegue a 0 y
// quede bloquedo.
sem_t sem_write;

// Le ponemos 0 ya que el buffer empieza sin info
sem_t sem_read;

void initialization() {
  sem_init(&sem_read, 0, 0);
  sem_init(&sem_write, 0, N);
}

void push(void *message) {
  buffer[in] = message;
  in = (in + 1) % N; // Lógica circular: vuelve a 0 al llegar a N
}

void *pop() {
  void *message = buffer[out];
  out = (out + 1) % N; // Lógica circular
  return message;
}

void my_write(void *message) {
  // Si esta lleno espero para escribir
  sem_wait(&sem_write);

  // Si hay espacio puedo escribir
  push(message);

  // Ahora liberamos al lector
  sem_post(&sem_read);
}

void *my_read(void) {
  // Si esta vacio esperamos a que alguien escriba
  sem_wait(&sem_read);

  // Leemos con pop
  void *message = pop();

  // Ahora que esa posicion esta libre podemos liberar el write
  sem_post(&sem_write);

  return message;
}

// No hago un main, parace bastante trivial que esta bien el codigo
