#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <unistd.h>

int main(void) {
  pid_t pid_homero = fork();
  if (pid_homero == 0) {
    printf("Soy Homero\n");

    // Bart
    pid_t pid_bart = fork();
    if (pid_bart == 0) {
      printf("Soy Bart\n");
      exit(EXIT_SUCCESS);
    }
    // Lisa
    pid_t pid_lisa = fork();
    
    if (pid_lisa < 0) {
      perror("Error al crear a Lisa\n");
      exit(EXIT_FAILURE);
    }

    if (pid_lisa == 0) {
      printf("Soy Lisa\n");
      exit(EXIT_SUCCESS);
    }
    // Maggie
    pid_t pid_maggie = fork();
    if (pid_maggie == 0) {
      printf("Soy Maggie\n");
      exit(EXIT_SUCCESS);
    }

    waitpid(pid_bart, NULL, 0);
    waitpid(pid_lisa, NULL, 0);
    waitpid(pid_maggie, NULL, 0);
    exit(EXIT_SUCCESS);
  } else {
    printf("Soy Abraham\n");
    waitpid(pid_homero, NULL, 0);
    exit(EXIT_SUCCESS);
  }
}
