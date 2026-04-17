#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

#define MAX_CICLOS 5
int contador_ciclos = 0;

void sigurg_handler(int sig) {
  contador_ciclos++;
  printf("Ya va!\n");
  fflush(stdout);

  if (contador_ciclos >= MAX_CICLOS) {
    // Al llegar al máximo, avisamos al padre para que deje de esperar
    kill(getppid(), SIGINT);
  }
}

// El padre necesita esto para que el SIGINT del hijo interrumpa el sleep
void sigint_handler(int sig) {}

void hijo(char *argv[]) {
  // Es mejor usar struct sigaction, pero signal() para este taller sirve
  signal(SIGURG, sigurg_handler);
  while (contador_ciclos < MAX_CICLOS) {
    pause();
  }

  // Ejecutamos el comando final
  execvp(argv[1], &argv[1]);

  // Si llega hasta aqui significa que fallo
  perror("Error en execvp\n");
  exit(EXIT_FAILURE);
}

int main(int argc, char *argv[]) {
  if (argc < 2) {
    printf("Uso: %s <programa> [Argumentos...]\n", argv[0]);
    exit(EXIT_FAILURE);
  }
  // Programa a ser ejecutado
  char *programa = argv[1];

  // Limpiamos el buffer antes de duplicar el proceso
  fflush(stdout);

  pid_t pid_hijo = fork();

  if (pid_hijo < 0) {
    perror("Error al crear el hijo\n");
    exit(EXIT_FAILURE);
  } else if (pid_hijo == 0) {
    // ejecucion del hijo
    hijo(argv);
  } else {
    // El padre captura SIGINT para sincronizar el final con el hijo
    signal(SIGINT, sigint_handler);

    // ejecucion del padre
    for (int i = 0; i < MAX_CICLOS; i++) {
      // Pequeño delay para evitar que la primera señal llegue antes que el
      // handler
      if (i == 0)
        usleep(100000);

      printf("Sup!\n");
      fflush(stdout);

      if (kill(pid_hijo, SIGURG) == -1) {
        perror("Error enviando señal");
        break;
      }

      // Esperamos un segundo
      sleep(1);
    }

    // Ahora debo esperar a que el hijo muera para ejecutar el comando final
    int status;
    waitpid(pid_hijo, &status, 0);
  }

  return 0;
}
