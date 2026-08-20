#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <unistd.h>

enum { READ, WRITE };
enum { FATHER, CHILD1, CHILD2 };

int main(void) {
  int pipes[3][2];
  int limit = 50;

  if (pipe(pipes[FATHER]) == -1 || pipe(pipes[CHILD1]) == -1 ||
      pipe(pipes[CHILD2]) == -1) {
    perror("Error creando pipes");
    exit(1);
  }

  pid_t child1 = fork();
  if (child1 < 0) {
    perror("Error fork hijo1");
    exit(1);
  }

  if (child1 == 0) {
    // Hijo1: lee FATHER[READ], escribe CHILD1[WRITE]
    close(pipes[FATHER][WRITE]);
    close(pipes[CHILD1][READ]);
    close(pipes[CHILD2][READ]);
    close(pipes[CHILD2][WRITE]);

    int value;
    while (read(pipes[FATHER][READ], &value, sizeof(int)) > 0) {
      int next = value + 1;
      printf("Hijo_1 envia a Hijo_2 el valor %d\n", next);
      fflush(stdout);
      write(pipes[CHILD1][WRITE], &next, sizeof(int));
      if (next >= limit)
        break;
    }
    // FIX 3: cerrar los que realmente usó
    close(pipes[FATHER][READ]);
    close(pipes[CHILD1][WRITE]);
    exit(EXIT_SUCCESS);
  }

  pid_t child2 = fork();
  if (child2 < 0) {
    perror("Error fork hijo2");
    exit(1);
  }

  if (child2 == 0) {
    // Hijo2: lee CHILD1[READ], escribe CHILD2[WRITE]
    close(pipes[FATHER][READ]);
    close(pipes[FATHER][WRITE]); // FIX 1: era [READ] duplicado
    close(pipes[CHILD1][WRITE]);
    close(pipes[CHILD2][READ]);

    int value;
    while (read(pipes[CHILD1][READ], &value, sizeof(int)) > 0) {
      int next = value + 1;
      printf("Hijo_2 envia a Padre el valor %d\n", next);
      fflush(stdout);
      write(pipes[CHILD2][WRITE], &next, sizeof(int));
      if (next >= limit)
        break;
    }
    // FIX 2: close y exit FUERA del while
    close(pipes[CHILD1][READ]);
    close(pipes[CHILD2][WRITE]);
    exit(EXIT_SUCCESS);
  }

  // Padre
  close(pipes[FATHER][READ]);
  close(pipes[CHILD1][WRITE]);
  close(pipes[CHILD1][READ]);
  close(pipes[CHILD2][WRITE]);

  int value = 0;
  printf("Padre envia a Hijo_1 el valor %d\n", value);
  fflush(stdout);
  write(pipes[FATHER][WRITE], &value, sizeof(int));

  int receive;
  while (read(pipes[CHILD2][READ], &receive, sizeof(int)) > 0) {
    if (receive >= limit) {
      printf("Saliendo de la secuencia\n");
      break;
    }
    int next = receive + 1;
    printf("Padre envia a Hijo_1 el valor %d\n", next);
    fflush(stdout);
    write(pipes[FATHER][WRITE], &next, sizeof(int));
  }

  close(pipes[FATHER][WRITE]);
  close(pipes[CHILD2][READ]);
  wait(NULL);
  wait(NULL);
  return 0;
}
