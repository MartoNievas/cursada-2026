#include "constants.h"
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#define FIN -1

int generate_random_number() { return rand() % 50; }

void hijo_distinguido(int buffer, int n, int pipe_hp[2], int pipes[][2],
                      int index) {

  // Cerrar pipes innecesarios
  for (int i = 0; i < n; i++) {
    if (i != index)
      close(pipes[i][PIPE_WRITE]);
    if (i != (index - 1 + n) % n)
      close(pipes[i][PIPE_READ]);
  }

  close(pipe_hp[PIPE_READ]); // solo escribe al padre

  srand(time(NULL) + getpid());

  int numero_secreto = generate_random_number();
  printf("[Hijo %d] Numero secreto: %d\n", index, numero_secreto);

  int valor = buffer + 1;

  write(pipes[index][PIPE_WRITE], &valor, sizeof(valor));

  while (1) {
    int lectura;
    int r =
        read(pipes[(index - 1 + n) % n][PIPE_READ], &lectura, sizeof(lectura));

    if (r <= 0)
      continue;

    printf("[Hijo %d] Recibi: %d\n", index, lectura);

    if (lectura == FIN) {
      write(pipes[index][PIPE_WRITE], &lectura, sizeof(lectura));
      exit(EXIT_SUCCESS);
    }

    if (lectura >= numero_secreto) {
      // Aviso al padre
      write(pipe_hp[PIPE_WRITE], &lectura, sizeof(lectura));

      // Envío FIN al anillo
      int fin = FIN;
      write(pipes[index][PIPE_WRITE], &fin, sizeof(fin));

      exit(EXIT_SUCCESS);
    }

    lectura++;
    write(pipes[index][PIPE_WRITE], &lectura, sizeof(lectura));
  }
}

void hijo_comun(int n, int index, int pipes[][2]) {

  // Cerrar pipes innecesarios
  for (int j = 0; j < n; j++) {
    if (j == (index - 1 + n) % n) {
      close(pipes[j][PIPE_WRITE]);
    } else if (j == index) {
      close(pipes[j][PIPE_READ]);
    } else {
      close(pipes[j][PIPE_READ]);
      close(pipes[j][PIPE_WRITE]);
    }
  }

  while (1) {
    int lectura;
    int r =
        read(pipes[(index - 1 + n) % n][PIPE_READ], &lectura, sizeof(lectura));

    if (r <= 0)
      continue;
    if (lectura != FIN) {
      printf("[Hijo %d] Recibi: %d\n", index, lectura);
    }
    if (lectura == FIN) {
      write(pipes[index][PIPE_WRITE], &lectura, sizeof(lectura));
      exit(EXIT_SUCCESS);
    }

    lectura++;
    write(pipes[index][PIPE_WRITE], &lectura, sizeof(lectura));
  }
}

int main(int argc, char **argv) {

  if (argc != 4) {
    printf("Uso: ./anillo <n> <c> <s>\n");
    exit(EXIT_FAILURE);
  }

  int n = atoi(argv[1]);
  int buffer = atoi(argv[2]);
  int start = atoi(argv[3]);

  if (n < 3) {
    perror("Debe haber al menos 3 procesos");
    exit(EXIT_FAILURE);
  }

  if (start >= n) {
    perror("Proceso inicial invalido");
    exit(EXIT_FAILURE);
  }

  printf("Procesos: %d | Valor inicial: %d | Inicio: %d\n", n, buffer, start);

  int pipe_hp[2];
  pipe(pipe_hp);

  int pipes[n][2];
  for (int i = 0; i < n; i++) {
    pipe(pipes[i]);
  }

  int pids[n];

  for (int i = 0; i < n; i++) {

    pid_t pid = fork();

    if (pid < 0) {
      perror("Error fork");
      exit(EXIT_FAILURE);
    }

    if (pid == 0) {
      if (i == start) {
        hijo_distinguido(buffer, n, pipe_hp, pipes, i);
      } else {
        hijo_comun(n, i, pipes);
      }
      exit(EXIT_SUCCESS);
    }

    pids[i] = pid;
  }

  // Padre
  close(pipe_hp[PIPE_WRITE]); // solo lee

  int lectura;
  read(pipe_hp[PIPE_READ], &lectura, sizeof(lectura));

  printf("[Padre] Resultado final: %d\n", lectura);

  // Esperar a todos los hijos
  for (int i = 0; i < n; i++) {
    wait(NULL);
  }

  return 0;
}
