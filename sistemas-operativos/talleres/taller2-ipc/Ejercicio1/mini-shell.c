#include "constants.h"
#include "mini-shell-parser.c"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

/*
        Explicacion del argumento progs:

        Corresponde con una matriz donde cada fila representa el iesimo programa
   pasado dividido por el pipe. En cada fila esta el nombre del programa en su
   primera posicion y los parametros en las posiciones restantes.

        Ejemplo: 'du -h /home | head -n 10 | sort -rh'

        Representacion:
        [
                ['du', '-h', '/home'],
                ['head', '-n', '10'],
                ['sort', '-rh']
        ]

*/
// execvp ( prog[0], prog, NULL) chequear null
// Vamos con lo que ejecuta el hijo
void chld(int index, int pipes[][2], int count, char **program) {
  // Primero cerramos todos los pipes que no se usan, el procesos index solo
  // usa, el pipe index e index - 1
  for (int i = 0; i < count - 1; i++) {
    if (i != index - 1)
      close(pipes[i][PIPE_READ]);
    if (i != index)
      close(pipes[i][PIPE_WRITE]);
  }

  // En todos los procesos tengo que redireccionar la salida estandar hacia la
  // escritura de su pipe, excepto que sea el primero, ese lee de la entrada
  // estandar

  if (index == 0) {
    // tenemos que redirigir su salida estandar
    dup2(pipes[index][PIPE_WRITE], STD_OUTPUT);
  } else if (index == count - 1) {
    // Es decir estamos en el ultimo
    dup2(pipes[index - 1][PIPE_READ], STD_INPUT);
  } else {
    // Por ultimo es un proceso del medio
    // Si estamos en el index-esimo queremos conectar la salidad del index-1 ->
    // entrada del index.
    dup2(pipes[index - 1][PIPE_READ], STD_INPUT);
    dup2(pipes[index][PIPE_WRITE], STD_OUTPUT);
  }

  // Ahora debemos ejecutar el programa
  execvp(program[0], program);

  // Por si falla
  perror("execvp falló");
  exit(EXIT_FAILURE);
}

static int run(char ***progs, size_t count) {
  int r, status;

  // Reservo memoria para el arreglo de pids
  // TODO: Guardar el PID de cada proceso hijo creado en children[i]
  pid_t *children = malloc(sizeof(*children) * count);

  // TODO: Pensar cuantos procesos necesito
  // TODO: Pensar cuantos pipes necesito.
  // Primero que nada necesito count hijos y count - 1 pipes para poder
  // comunicar todos
  int pipes[count - 1][2];

  // Primero inicializamos los pipes

  for (int i = 0; i < count - 1; i++) {
    pipe(pipes[i]);
  }

  // Una vez con los pipes inicializados tenemos que crear a los hijos
  // TODO: Para cada proceso hijo:
  // 1. Redireccionar los file descriptors adecuados al proceso
  // 2. Ejecutar el programa correspondiente

  for (int i = 0; i < count; i++) {
    pid_t chld_pid = fork();

    if (chld_pid < 0) {
      perror("Error al crear un hijo\n");
      exit(EXIT_FAILURE);
    } else if (chld_pid == 0) {
      // Ahora estamos en el codigo del hijo
      chld(i, pipes, count, progs[i]);
    }
    children[i] = chld_pid;
  }

  // Ahora cerramos los pipes que el padre no usa (todos)
  for (int i = 0; i < count - 1; i++) {
    close(pipes[i][PIPE_READ]);
    close(pipes[i][PIPE_WRITE]);
  }

  // Espero a los hijos y verifico el estado que terminaron
  for (int i = 0; i < count; i++) {
    waitpid(children[i], &status, 0);

    if (!WIFEXITED(status)) {
      fprintf(stderr,
              "proceso %d no terminó correctamente [%d]: ", (int)children[i],
              WIFSIGNALED(status));
      perror("");
      return -1;
    }
  }
  r = 0;
  free(children);

  return r;
}

int main(int argc, char **argv) {
  if (argc < 2) {
    printf("El programa recibe como parametro de entrada un string con la "
           "linea de comandos a ejecutar. \n");
    printf("Por ejemplo ./mini-shell 'ls -a | grep anillo'\n");
    return 0;
  }
  int programs_count;
  char ***programs_with_parameters = parse_input(argv, &programs_count);

  printf("status: %d\n", run(programs_with_parameters, programs_count));

  fflush(stdout);
  fflush(stderr);

  return 0;
}
