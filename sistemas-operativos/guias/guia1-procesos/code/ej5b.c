#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <unistd.h>

int main(void) {
  pid_t pid = fork();
  if (pid == 0) {
    printf("Soy Homero\n");

    // Bart
    pid_t pid_b = fork();
    if (pid_b == 0) {
      printf("Soy Bart\n");
      exit(0);
    }
    // Lisa
    pid_t pid_l = fork();
    if (pid_l == 0) {
      printf("Soy Lisa\n");
      exit(0);
    }
    // Maggie
    pid_t pid_m = fork();
    if (pid_m == 0) {
      printf("Soy Maggie\n");
      exit(0);
    }

    waitpid(pid_b, NULL, 0);
    waitpid(pid_l, NULL, 0);
    waitpid(pid_m, NULL, 0);
    exit(0);
  } else {
    printf("Soy Abraham\n");
    waitpid(pid, NULL, 0);
    exit(0);
  }
}
