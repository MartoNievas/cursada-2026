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

  pid_t pid_ls = fork();

  if (pid_ls < 0) {
    perror("Error al crear el proceso de ls\n");
    exit(EXIT_FAILURE);

  }

  if (pid_ls == 0) {
    ejecutar_hijo_1(pipe_fd);
  }


  pid_t pid_wc = fork();

  if (pid_wc < 0) {
    perror("Error al crear el proceso wc\n");
    exit(EXIT_FAILURE);
  }

  if (pid_wc == 0) {
    ejecutar_hijo_2(pipe_fd);
  }

  close(pipe_fd[WRITE]);
  waitpid(pid_ls,NULL,0);
  waitpid(pid_wc,NULL,0);

  return EXIT_SUCCESS;
}
