#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <unistd.h>

int pipe_fd[2];

enum { READ, WRITE };

// ---- HANDLERS DEL HIJO ----

void handler_hijo_sigint(int sig) {
    (void)sig;
    write(STDOUT_FILENO,"¿Dejame pensarlo...\n", 22);
    fflush(stdout);
}

void handler_hijo_sighup(int sig) {
    (void)sig;
    write(STDOUT_FILENO,"Me voy a mirar crecer las flores...\n", 37);
    fflush(stdout);
    close(pipe_fd[WRITE]);
    exit(0);
}

// ---- HANDLERS DEL PADRE ----

void handler_padre_sigint(int sig) {
  (void) sig;

}

int main(void) {

  // Primero creamos los pipes
  pipe(pipe_fd);

  //creamos el hijo
  pid_t hijo = fork();

  if (hijo < 0) {
    perror("Error al crear al hijo\n");
    exit(EXIT_FAILURE);
  }

  if (hijo == 0) {
    // Vemos que hace el hijo

    // Primero cierra el extremo de lectura del pipe
    close(pipe_fd[READ]);

    //Ahora seteamos los handlers
    signal(SIGINT,handler_hijo_sigint);
    signal(SIGHUP,handler_hijo_sighup);

    // Se queda en pause hasta que el proceso le mande signint
    pause();

    sleep(5);
    printf("Ya sé el significado de la vida...\n");
    fflush(stdout);
    
    // Escribimos en el pipe
    write(pipe_fd[WRITE],"42",2);

    //Enviamos la senial SIGINT al padre
    kill(getppid(),SIGINT);

    while(1) {
      pause(); //Espera el SIGHUP del padre
    }

  } else {
    // Ahora vamos con el padre

    // Cerramos el extremo de escritura del pipe
    close(pipe_fd[WRITE]);

    sleep(1);
    printf("¿Cuál es el significado de la vida?\n");
    fflush(stdout);
    
    kill(hijo, SIGINT); // Despierta al hijo

    char buf[10] = {0};
    read(pipe_fd[READ], buf, sizeof(buf)); // Bloquea hasta leer "42"

    printf("Mirá vos. El significado de la vida...\n");
    fflush(stdout);
    printf("¡Bang Bang, estás liquidado!\n");
    fflush(stdout);

    kill(hijo, SIGHUP); // Manda matar al hijo
        wait(NULL);

    printf("Te voy a buscar en la oscuridad.\n");
    fflush(stdout);

    close(pipe_fd[READ]);
    exit(0);
  
  }
}