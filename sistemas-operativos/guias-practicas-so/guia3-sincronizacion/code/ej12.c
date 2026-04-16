#include <pthread.h>
#include <semaphore.h>
#include <stdio.h>
#include <unistd.h>

#define ALUMNOS 10

sem_t mutex;
sem_t barrera1;
sem_t barrera2;
int count_impl = 0;

void implementacionTp() {
  printf("Alumnos implementando...\n");
  sleep(1);
}

void experimentar() {
  printf("\tAlumnos experimentando...\n");
  sleep(1);
}

void inicializacion(void) {
  sem_init(&mutex, 0, 1);
  sem_init(&barrera1, 0, 0);
  sem_init(&barrera2, 0,
           1); // Inicializado en 1 para el primer wait de la fase 1
}

void *proc(void *arg) {
  while (1) {
    implementacionTp();
    sleep(1);
    sem_wait(&mutex);
    count_impl++;
    if (count_impl == ALUMNOS) {
      sem_wait(&barrera2);
      sem_post(&barrera1);
    }
    sem_post(&mutex);

    sem_wait(&barrera1);
    sem_post(&barrera1);

    experimentar();
    sleep(1);
    sem_wait(&mutex);
    count_impl--;
    if (count_impl == 0) {
      sem_wait(&barrera1);
      sem_post(&barrera2);
    }
    sem_post(&mutex);

    sem_wait(&barrera2);
    sem_post(&barrera2);
  }
  return NULL;
}

int main() {
  pthread_t hilos[ALUMNOS];
  inicializacion();

  for (int i = 0; i < ALUMNOS; i++) {
    pthread_create(&hilos[i], NULL, proc, NULL);
  }

  for (int i = 0; i < ALUMNOS; i++) {
    pthread_join(hilos[i], NULL);
  }

  return 0;
}
