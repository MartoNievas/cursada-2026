#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <unistd.h>

// Proceso principal Abraham
int main(void) {
  // Homero
  pid_t pid = fork();
  if (pid == 0) {
    printf("Soy Homero");
    pid_t bart = fork();
    if (bart == 0) {
      printf("Soy Bart");
      exit(0);
    }

    pid_t lisa = fork();
    if (lisa == 0) {
      printf("Soy Lisa");
      exit(0);
    }

    pid_t maggie = fork();
    if (maggie == 0) {
      printf("Soy Maggie");
      exit(0);
    }
  } else {
    printf("Soy Abraham");
    exit(0);
  }
}
