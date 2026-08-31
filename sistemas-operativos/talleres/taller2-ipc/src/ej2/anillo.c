/*
 * Ejercicio 2: One ring to rule them all (template).
 *
 * Se corre con: make run-anillo N=<n> S=<s> C=<c> P=<p>
 *
 *   n : cantidad de procesos del anillo (n >= 3)
 *   s : cuál de los hijos es el distinguido, el que arranca (1 <= s <= n)
 *   c : valor inicial del mensaje
 *   p : cota; el anillo para cuando el distinguido recibe un valor >= p (p > c)
 *
 * El parseo y la validación de los parámetros ya están resueltos: lo que
 * falta es armar el anillo de pipes, crear los hijos y programar la
 * ronda.
 */
#include <errno.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

#define READ 0
#define WRITE 1

static void usage(const char *prog) {
  fprintf(stderr, "uso: %s <n> <s> <c> <p>\n", prog);
  fprintf(stderr, "  n : cantidad de procesos del anillo (n >= 3)\n");
  fprintf(stderr, "  s : hijo distinguido, el que arranca (1 <= s <= n)\n");
  fprintf(stderr, "  c : valor inicial del mensaje\n");
  fprintf(stderr, "  p : cota, tiene que ser mayor que c\n");
}

/* strtol con todos los chequeos puestos: que haya algún dígito, que no
 * sobre basura al final y que entre en un int. */
static int parse_int(const char *text, int *out) {
  char *end;
  long value;

  errno = 0;
  value = strtol(text, &end, 10);
  if (end == text || *end != '\0')
    return -1;
  if (errno == ERANGE || value < INT_MIN || value > INT_MAX)
    return -1;

  *out = (int)value;
  return 0;
}

void cerrar_pipes_ajenos(int n, int i, int pipes[][2]) {
  int indice_anterior = ((i - 1 + n) % n);
  for (int j = 0; j < n; j++) {
    if (j != indice_anterior)
      close(pipes[j][READ]);
    if (j != i)
      close(pipes[j][WRITE]);
  }
}

void hijo_distinguido(int n, int i, int p, int pipes[][2],
                      int pipe_comunicacion_distinguido[2]) {

  int fd_read_padre = pipe_comunicacion_distinguido[READ];
  int fd_write_padre = pipe_comunicacion_distinguido[WRITE];
  int indice_anterior = (i - 1 + n) % n;
  int fd_read_antecesor = pipes[indice_anterior][READ];
  int fd_write_sucesor = pipes[i][WRITE];
  int lectura;

  // Cerramos pipes que no utilizamos
  cerrar_pipes_ajenos(n, i, pipes);
  close(fd_read_padre);

  while (read(fd_read_antecesor, &lectura, sizeof(lectura)) > 0) {
    printf("HIJO %d PID %d NUM %d\n", i + 1, getpid(), lectura);
    fflush(stdout);

    if (lectura >= p) {
      // Alcanzó o superó la cota: Notifica al padre y corta el ciclo
      write(fd_write_padre, &lectura, sizeof(lectura));
      break;
    }

    lectura++;
    write(fd_write_sucesor, &lectura, sizeof(lectura));
  }

  close(fd_write_padre);
  close(fd_read_antecesor);
  close(fd_write_sucesor);
  exit(EXIT_SUCCESS);
}

void hijo_normal(int n, int i, int pipes[][2],
                 int pipe_comunicacion_distinguido[2]) {

  int indice_anterior = (i - 1 + n) % n;
  int fd_read_antecesor = pipes[indice_anterior][READ];
  int fd_write_sucesor = pipes[i][WRITE];

  int lectura;

  // Cerramos pipes ajenos
  cerrar_pipes_ajenos(n, i, pipes);
  close(pipe_comunicacion_distinguido[READ]);
  close(pipe_comunicacion_distinguido[WRITE]);

  // Si paramos de leer quiere decir que se rompio el anillo lo rompio el
  // proceso distinguido
  while (read(fd_read_antecesor, &lectura, sizeof(lectura)) > 0) {
    printf("HIJO %d PID %d NUM %d\n", i + 1, getpid(), lectura);
    fflush(stdout);

    lectura++;
    write(fd_write_sucesor, &lectura, sizeof(lectura));
  }

  close(fd_read_antecesor);
  close(fd_write_sucesor);
  exit(EXIT_SUCCESS);
}

int main(int argc, char **argv) {
  int n, s, c, p, leader;

  if (argc != 5) {
    usage(argv[0]);
    return EXIT_FAILURE;
  }
  if (parse_int(argv[1], &n) < 0 || parse_int(argv[2], &s) < 0 ||
      parse_int(argv[3], &c) < 0 || parse_int(argv[4], &p) < 0) {
    fprintf(stderr,
            "error: los cuatro parámetros tienen que ser números enteros\n");
    usage(argv[0]);
    return EXIT_FAILURE;
  }
  if (n < 3) {
    fprintf(stderr, "error: el anillo necesita al menos 3 procesos (n = %d)\n",
            n);
    return EXIT_FAILURE;
  }
  if (s < 1 || s > n) {
    fprintf(stderr, "error: s tiene que estar entre 1 y %d (s = %d)\n", n, s);
    return EXIT_FAILURE;
  }
  if (p <= c) {
    fprintf(stderr, "error: p tiene que ser mayor que c (c = %d, p = %d)\n", c,
            p);
    return EXIT_FAILURE;
  }

  /* Adentro trabajamos con índices desde 0; el enunciado numera los
   * hijos desde 1, y así se imprimen. */
  leader = s - 1;

  /* TODO: crear los pipes del anillo. */
  int pipes[n][2];
  for (int i = 0; i < n; i++) {
    pipe(pipes[i]);
  }

  /* TODO: crear los n hijos. */

  /* TODO: programar el trabajo de cada hijo (te va a quedar más prolijo
   *       en una función aparte).
   */

  int pipe_comunicacion_distinguido[2];
  pipe(pipe_comunicacion_distinguido);

  for (int i = 0; i < n; i++) {
    pid_t pid = fork();
    if (pid == 0) {
      if (i == leader) {
        hijo_distinguido(n, i, p, pipes, pipe_comunicacion_distinguido);
      } else {
        hijo_normal(n, i, pipes, pipe_comunicacion_distinguido);
      }
    }
  }

  /* TODO: inyectar el valor inicial. */
  write(pipes[(leader - 1 + n) % n][WRITE], &c, sizeof(c));
  close(pipe_comunicacion_distinguido[WRITE]);

  for (int i = 0; i < n; i++) {
    close(pipes[i][READ]);
    close(pipes[i][WRITE]);
  }

  /* TODO: Recibir el valor final del distinguido, esperar a que terminen
   *       todos los hijos e imprimir el resultado final.
   */
  int valor_final;
  read(pipe_comunicacion_distinguido[READ], &valor_final, sizeof(valor_final));
  printf("PADRE RESULTADO %d\n", valor_final);
  fflush(stdout);

  close(pipe_comunicacion_distinguido[READ]);

  for (int i = 0; i < n; i++) {
    wait(NULL);
  }

  return EXIT_SUCCESS;
}
