#include <signal.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <unistd.h>

#define MAX_VUELTAS 3

volatile sig_atomic_t recibio_senial = 0;

void handler_pong(int sig) {
  (void)sig;
  recibio_senial = 1;
}

int main() {

  signal(SIGUSR1, handler_pong);

  pid_t ping_pid = fork();

  if (ping_pid < 0) {
    perror("Error al crear el hijo ping\n");
    exit(EXIT_FAILURE);
  }

  if (ping_pid == 0) {

    pid_t padre_pid = getppid();

    // El hijo escribe ping y el padre pong
    while (1) {
      for (int i = 0; i < MAX_VUELTAS; i++) {
        printf("ping PID: %d\n", getpid());
        sleep(1);
        fflush(stdout);
        kill(padre_pid, SIGUSR1);

        while (!recibio_senial) {
          pause();
        }

        recibio_senial = 0;
      }
    }
    return EXIT_SUCCESS;
  } else {
    char opcion;

    // Respuesta del padre
    while (1) {
      for (int i = 0; i < MAX_VUELTAS; i++) {
        while (!recibio_senial) {
          pause();
        }

        recibio_senial = 0;

        printf("pong PID: %d\n", getpid());
        sleep(1);
        fflush(stdout);

        kill(ping_pid, SIGUSR1);
      }

      printf("\nDesea finalizar la ejecucion? (s/n): ");
      fflush(stdout);

      if (scanf(" %c", &opcion) != 1 || opcion == 's' || opcion == 'S') {
        break;
      }
      printf("\n");
    }

    // Mato al hijo
    kill(ping_pid, SIGTERM);
    wait(NULL);
    printf("Hijo finalizado fin del programa\n");
  }
  return EXIT_SUCCESS;
}
