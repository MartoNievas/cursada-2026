#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <unistd.h>

// Proceso principal Abraham
int main(void) {
  // Homero
  pid_t pid_homero = fork();

  if (pid_homero < 0) {
    perror("Error al crear Homero\n");
    exit(EXIT_FAILURE);
  }

  if (pid_homero == 0) {

    printf("Soy Homero");
    pid_t pid_bart = fork();
    
    if (pid_bart < 0) {
      perror("Error al crear a Bart\n");
      exit(EXIT_FAILURE);
    }

    if (pid_bart == 0) {
      printf("Soy Bart");
      exit(EXIT_SUCCESS);
    }

    pid_t pid_lisa = fork();

    if (pid_lisa < 0) {
      perror("Error al crear a Lisa\n");
      exit(EXIT_FAILURE);
    }

    if (pid_lisa == 0) {
      printf("Soy Lisa");
      exit(EXIT_SUCCESS);
    }

    pid_t pid_maggie = fork();

    if (pid_maggie < 0 ) {
      perror("Error al crear a Maggie\n");
      exit(EXIT_FAILURE);
    }

    if (pid_maggie == 0) {
      printf("Soy Maggie");
      exit(EXIT_SUCCESS);
    }
  } else {
    printf("Soy Abraham");
    exit(EXIT_SUCCESS);
  }
}
