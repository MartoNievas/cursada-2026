#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <unistd.h>
#include <errno.h>

int my_system(const char *command) {
    if (command == NULL) {
        return 1;
    }

    pid_t pid = fork();

    if (pid < 0) {
        return -1;
    }

    if (pid == 0) {
        execl("/bin/sh", "sh", "-c", command, (char *)NULL);
        _exit(127);
    }

    int status;
    while (waitpid(pid, &status, 0) == -1) {
        if (errno != EINTR) {
            return -1;
        }
    }

    return status;
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <Command>\n", argv[0]);
        return EXIT_FAILURE;
    }

    const char *command = argv[1];
    int status = my_system(command);

    if (status == -1) {
        perror("Error en my_system");
        return 1;
    }

    if (WIFEXITED(status)) {
        int exit_code = WEXITSTATUS(status);
        printf("El comando finalizó normalmente con código: %d\n", exit_code);
        return exit_code;
    } else if (WIFSIGNALED(status)) {
        printf("El comando fue terminado por la señal: %d\n", WTERMSIG(status));
    }

    return EXIT_SUCCESS;
}