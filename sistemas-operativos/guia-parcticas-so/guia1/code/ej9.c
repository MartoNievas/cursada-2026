#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

void pong_handler(int sig) {
  (void)sig;
  printf("PONG\n");
}

int main(void) {
  pid_t pid = fork();

  if (pid == -1) {
    printf("La creacion del proceso hijo fallo\n");
    exit(EXIT_FAILURE);
  } else if (pid == 0) {
    signal(10, pong_handler);
    while (1) {
    }
  } else {
    sleep(1);

    for (int i = 0; i < 3; i++) {
      printf("PING\n");
      kill(pid, 10);
      sleep(1);
    }

    char option[1];
    printf("Desea finalizar [y/n] ?");
    scanf("%s", option);

    while (strcmp(option, "n") == 0) {
      for (int i = 0; i < 3; i++) {
        printf("PING\n");
        kill(pid, 10);
        sleep(1);
      }

      printf("Que hacemos? [y/n]\n");
      scanf("%s", option);
    }
  }
  kill(pid, SIGTERM);
  printf("Proceso finalizado\n");
  exit(0);
}
