#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <unistd.h>

int pipe_fd[2];

enum { READ, WRITE };

void handler(int sig) { (void)sig; }

int main() {
  pipe(pipe_fd);
  pid_t pid = fork();
  if (pid == 0) {
    close(pipe_fd[READ]);
    sleep(5);

    printf("Ya se el significado de la vida...\n");
    write(pipe_fd[WRITE], "42", 2);

    kill(getpid(), SIGINT);
    printf("Me voy a mirar crecer las flores...\n");

    close(pipe_fd[WRITE]);
    exit(0);
  } else {
    close(pipe_fd[WRITE]);
    signal(SIGINT, handler);

    printf("Cual es el significado de la vida?\n");

    kill(pid, SIGINT);

    char buf[10] = {0};
    read(pipe_fd[READ], buf, sizeof(buf));

    printf("Mirá vos. El significado de la vida...\n");
    printf("¡Bang Bang, estás liquidado!\n");

    kill(pid, SIGHUP);
    wait(NULL);

    printf("Te voy a buscar en la oscuridad.\n");

    close(pipe_fd[READ]);
    exit(0);
  }
}
