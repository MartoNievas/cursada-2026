#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

enum { READ, WRITE };

void ejecutar_cmd(char *cmd, char *p) {
  execlp(cmd, cmd, p, NULL);
  perror("Error en execlp");
  exit(EXIT_FAILURE);
}

void ejecutar_hijo_1(int pipe_fd[]) {
  close(pipe_fd[READ]);
  dup2(pipe_fd[WRITE], STDOUT_FILENO);
  close(pipe_fd[WRITE]); // Cierra el fd original una vez duplicado

  ejecutar_cmd("ls", "-al");
}

void ejecutar_hijo_2(int pipe_fd[]) {
  close(pipe_fd[WRITE]);
  dup2(pipe_fd[READ], STDIN_FILENO);
  close(pipe_fd[READ]); // Cierra el fd original una vez duplicado

  ejecutar_cmd("wc", "-l");
}

int main(void) {
  int pipe_fd[2];
  if (pipe(pipe_fd) < 0) {
    perror("Error al crear el pipe");
    exit(EXIT_FAILURE);
  }

  pid_t pid_ls = fork();
  if (pid_ls < 0) {
    perror("Error al crear el proceso ls");
    exit(EXIT_FAILURE);
  }
  if (pid_ls == 0) {
    ejecutar_hijo_1(pipe_fd);
  }

  pid_t pid_wc = fork();
  if (pid_wc < 0) {
    perror("Error al crear el proceso wc");
    exit(EXIT_FAILURE);
  }
  if (pid_wc == 0) {
    ejecutar_hijo_2(pipe_fd);
  }

  // El padre debe cerrar ambos extremos para que wc reciba EOF cuando ls
  // termine
  close(pipe_fd[WRITE]);
  close(pipe_fd[READ]);

  waitpid(pid_ls, NULL, 0);
  waitpid(pid_wc, NULL, 0);

  return EXIT_SUCCESS;
}
