#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <unistd.h>

// Estructuras para la declaratividad
enum { READ, WRITE };
enum { FATHER, CHILD1, CHILD2 };

// Aqui tenemos un arreglos de arreglo para representar los pipes de los 2 hijos y el padre.
int pipes[3][2];

// Declaramos el limite como variable global.
int limit = 50;

int main(void) {

  if (pipe(pipes[FATHER]) < 0 || pipe(pipes[CHILD1]) < 0 ||
      pipe(pipes[CHILD2]) < 0) {
    perror("Error creando pipes");
    exit(EXIT_FAILURE);
  }

  pid_t child1 = fork();
  if (child1 < 0) {
    perror("Error fork hijo1\n");
    exit(EXIT_FAILURE);
  }

  if (child1 == 0) {
    // Hijo1: lee FATHER[READ], escribe CHILD1[WRITE]
    // Cierra los extremos que no utiliza
    close(pipes[FATHER][WRITE]);
    close(pipes[CHILD1][READ]);
    close(pipes[CHILD2][READ]);
    close(pipes[CHILD2][WRITE]);

    int value;
    while (read(pipes[FATHER][READ], &value, sizeof(int)) > 0) {
      int next = value + 1;
      printf("Hijo_1 envia a Hijo_2 el valor %d\n", next);
      fflush(stdout);
      sleep(1);
      write(pipes[CHILD1][WRITE], &next, sizeof(int));
      if (next >= limit)
        break;
    }
    
    close(pipes[FATHER][READ]);
    close(pipes[CHILD1][WRITE]);
    exit(EXIT_SUCCESS);
  }

  pid_t child2 = fork();
  if (child2 < 0) {
    perror("Error fork hijo2\n");
    exit(EXIT_FAILURE);
  }

  if (child2 == 0) {
    // Hijo2: lee CHILD1[READ], escribe CHILD2[WRITE]
    // Cierra los extremos que no utiliza
    close(pipes[FATHER][READ]);
    close(pipes[FATHER][WRITE]); 
    close(pipes[CHILD1][WRITE]);
    close(pipes[CHILD2][READ]);

    int value;
    while (read(pipes[CHILD1][READ], &value, sizeof(int)) > 0) {
      int next = value + 1;
      printf("Hijo_2 envia a Padre el valor %d\n", next);
      fflush(stdout);
      sleep(1);
      write(pipes[CHILD2][WRITE], &next, sizeof(int));
      if (next >= limit)
        break;
    }
    
    close(pipes[CHILD1][READ]);
    close(pipes[CHILD2][WRITE]);
    exit(EXIT_SUCCESS);
  }

  // Padre, cierra los extremos que no utiliza
  close(pipes[FATHER][READ]);
  close(pipes[CHILD1][WRITE]);
  close(pipes[CHILD1][READ]);
  close(pipes[CHILD2][WRITE]);

  int value = 0;
  printf("Padre envia a Hijo_1 el valor %d\n", value);
  fflush(stdout);
  sleep(1);
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
    sleep(1);
    write(pipes[FATHER][WRITE], &next, sizeof(int));
  }

  close(pipes[FATHER][WRITE]);
  close(pipes[CHILD2][READ]);
  waitpid(child1, NULL, 0);
  waitpid(child2, NULL, 0);
  return EXIT_SUCCESS;
}
