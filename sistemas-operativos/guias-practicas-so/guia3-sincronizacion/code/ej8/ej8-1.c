#include <pthread.h>
#include <semaphore.h>
#include <stdio.h>
#include <unistd.h>
#define N 3
#define A 0
#define B 1
#define C 2

sem_t semeforos[N];

// 1) proceso A,B y C

void inicializar() {
  for (int i = 0; i < N; i++) {
    int valor_inicial = (i == 0) ? 1 : 0;
    sem_init(&semeforos[i], 0, valor_inicial);
  }
}

void *ejecutar_proceso(void *arg) {
  int id = *(int *)arg;
  while (1) {
    sem_wait(&semeforos[id]);

    // Seccion ciritica
    if (id == 0)
      printf("Proceso A ejecutando...\n");
    if (id == 1)
      printf("Proceso B ejecutando...\n");
    if (id == 2)
      printf("Proceso C ejecutando...\n");

    sleep(1);

    sem_post(&semeforos[(id + 1) % N]);
  }

  return NULL;
}

int main() {
  pthread_t hilos[N];
  int ids[N];

  inicializar();

  // Creamos los 3 hilos (A, B y C)
  for (int i = 0; i < N; i++) {
    ids[i] = i;
    pthread_create(&hilos[i], NULL, ejecutar_proceso, &ids[i]);
  }

  // Esperamos a que todos terminen
  for (int i = 0; i < N; i++) {
    pthread_join(hilos[i], NULL);
  }

  // Limpieza
  for (int i = 0; i < N; i++) {
    sem_destroy(&semeforos[i]);
  }

  printf("Secuencia finalizada con éxito.\n");
  return 0;
}
