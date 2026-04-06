#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <unistd.h>

int main(void) {
  printf("Soy Juan\n");
  sleep(1);

  pid_t julieta = fork();
  if (julieta == 0) {
    printf("Soy Julieta\n");
    sleep(1);

    pid_t jennifer = fork();
    if (jennifer == 0) {
      printf("Soy Jennifer\n");
      sleep(1);
      exit(0);
    }
    waitpid(jennifer, NULL, 0);
    exit(0);
  }

  waitpid(julieta, NULL, 0);

  pid_t jorge = fork();
  if (jorge == 0) {
    printf("Soy Jorge\n");
    sleep(1);
    exit(0);
  }

  waitpid(jorge, NULL, 0);
  return 0;
}
