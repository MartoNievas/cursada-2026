#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

enum { READ, WRITE };

void ejecutar_cmd(char *cmd, char *p) { execlp(cmd, cmd, p, NULL); }

void ejecutar_hijo_1(int pipe_fd[]) {
  close(pipe_fd[READ]);

  // conectar la escritura a stdout
  dup2(pipe_fd[WRITE], STDOUT_FILENO);

  // Ejecutar el programa

  ejecutar_cmd("ls", "-al");
}

void ejecutar_hijo_2(int pipe_fd[]) {
  // cerramos la escritura
  close(pipe_fd[WRITE]);

  // conectamos la salida con el pipe
  dup2(pipe_fd[READ], STDIN_FILENO);

  // Ejecutamos programa
  ejecutar_cmd("wc", "-l");
}

int main(void) {
  int pipe_fd[2];
  pipe(pipe_fd);

  if (fork() == 0) {
    ejecutar_hijo_1(pipe_fd);
  }

  if (fork() == 0) {
    ejecutar_hijo_2(pipe_fd);
  }

  close(pipe_fd[WRITE]);
  wait(NULL);
  wait(NULL);

  return 0;
}
