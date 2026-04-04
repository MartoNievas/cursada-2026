#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <unistd.h>

int my_system(const char *command) {
  pid_t pid = fork();

  if (pid == 0) {
    execl("/bin/sh", "sh", "-c", command, (char *)NULL);
    exit(0);
  }

  if (pid < 0) {
    return -1;
  }
  waitpid(pid, NULL, 0);
  return 0;
}

int main(int argc, char *argv[]) {
  if (argc != 2) {
    printf("Usage: %s <Command>\n", argv[0]);
  }
  const char *command = argv[1];
  int res = my_system(command);
  return res;
}
