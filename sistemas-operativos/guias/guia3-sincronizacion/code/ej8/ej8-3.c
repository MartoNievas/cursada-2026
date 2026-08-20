#include <pthread.h>
#include <semaphore.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

// Ejercicio 3: proceso A, B Y C
// Secuencia: Produce A luego consumen B o C

#define A 0
#define B 1
#define C 2

sem_t sem_A;
sem_t sem_cons;
sem_t mutex;
int cantidad = 0;

void initialization() {
  sem_init(&sem_A, 0, 1);
  sem_init(&sem_cons, 0, 0);
  sem_init(&mutex, 0, 1);
}

void *productor_A(void *arg) {
  while (1) {
    // Espera hasta que se requiera la produccion
    sem_wait(&sem_A);

    printf("[A] Produciendo informacion...\n");
    // Liberamos 2 "fichas" para los consumidores retiren info
    sem_post(&sem_cons);
    sem_post(&sem_cons);
  }
  return NULL;
}

void *consumido(void *arg) {
  int id = *(int *)arg; // B o C
  char name = (id == B) ? 'B' : 'C';

  while (1) {
    // Esperamos hasta tener la info
    sem_wait(&sem_cons);

    // Una vez con la infor debemos consumirla
    printf("\t[%c] Consumiendo informacion...\n", name);
    sleep(3);

    // Seccion critica: Control de cuantos se consumieron
    sem_wait(&mutex);
    cantidad++;
    if (cantidad == 2) {
      cantidad = 0;
      printf("--- Info retirada 2 veces. Avisando a A ---\n");
      sem_post(&sem_A);
    }
    sem_post(&mutex);
  }
  return NULL;
}

int main() {
  pthread_t th_A, th_B, th_C;
  // Definimos los IDs en variables separadas
  int id_b = B;
  int id_c = C;

  initialization();

  // Lanzamos los hilos
  pthread_create(&th_A, NULL, productor_A, NULL);
  pthread_create(&th_B, NULL, consumido, &id_b);
  pthread_create(&th_C, NULL, consumido, &id_c);

  // Los unimos para que el proceso no muera
  pthread_join(th_A, NULL);
  pthread_join(th_B, NULL);
  pthread_join(th_C, NULL);

  return 0;
}
