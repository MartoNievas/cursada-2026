#include <pthread.h>
#include <semaphore.h>
#include <stdio.h>
#include <unistd.h>

// Definiciones de control
enum { EXEC_B, EXEC_C };

sem_t sem_a, sem_b, sem_c;
int consumer = EXEC_B;

void initialization() {
  sem_init(&sem_a, 0, 1); // El Productor A comienza habilitado
  sem_init(&sem_b, 0, 0); // B espera a que A produzca
  sem_init(&sem_c, 0, 0); // C espera a que A produzca
}

void *productor_A(void *arg) {
  while (1) {
    sem_wait(&sem_a);

    printf("\n[A] >>> Produciendo informacion...\n");
    sleep(1);

    if (consumer == EXEC_B) {
      printf("[SISTEMA] Habilitando a B para doble consumo.\n");
      sem_post(&sem_b);
      sem_post(&sem_b);
    } else {
      printf("[SISTEMA] Habilitando a C para doble consumo.\n");
      sem_post(&sem_c);
      sem_post(&sem_c);
    }
  }
  return NULL;
}

void *consumidor_B(void *arg) {
  int consumos = 0;
  while (1) {
    sem_wait(&sem_b);
    printf("\t[B] Consumiendo (lectura %d/2)...\n", ++consumos);
    usleep(500000);

    if (consumos == 2) {
      consumos = 0;
      consumer = EXEC_C; // Cambio de turno para la próxima producción
      sem_post(&sem_a);  // Despierta al Productor
    }
  }
  return NULL;
}

void *consumidor_C(void *arg) {
  int consumos = 0;
  while (1) {
    sem_wait(&sem_c);
    printf("\t\t[C] Consumiendo (lectura %d/2)...\n", ++consumos);
    usleep(500000);

    if (consumos == 2) {
      consumos = 0;
      consumer = EXEC_B; // Cambio de turno para la próxima producción
      sem_post(&sem_a);  // Despierta al Productor
    }
  }
  return NULL;
}

int main() {
  pthread_t th_a, th_b, th_c;

  initialization();

  printf("--- Iniciando Secuencia Alternada ABB -> ACC ---\n");

  // Creación de los hilos
  pthread_create(&th_a, NULL, productor_A, NULL);
  pthread_create(&th_b, NULL, consumidor_B, NULL);
  pthread_create(&th_c, NULL, consumidor_C, NULL);

  // Esperar a que los hilos terminen (en este caso es infinito)
  pthread_join(th_a, NULL);
  pthread_join(th_b, NULL);
  pthread_join(th_c, NULL);

  // Limpieza de semáforos
  sem_destroy(&sem_a);
  sem_destroy(&sem_b);
  sem_destroy(&sem_c);

  return 0;
}
