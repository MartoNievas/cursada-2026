#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <sys/un.h>
#include <unistd.h>

#define SOCK_PATH "/tmp/chat_server.sock"
#define BUFFER_SIZE 64

int main() {

  int sockfd;
  struct sockaddr_un addr;
  char buffer[BUFFER_SIZE];

  // Creamos el socket
  sockfd = socket(AF_UNIX, SOCK_STREAM, 0);
  if (sockfd < 0) {
    perror("[Cliente]: Error al crear el socket");
    exit(EXIT_FAILURE);
  }

  // Configuramos las direcciones
  memset(&addr, 0, sizeof(addr));
  addr.sun_family = AF_UNIX;
  strcpy(addr.sun_path, SOCK_PATH);

  // Conectamos el servidor
  if (connect(sockfd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
    perror("[Cliente]: Error al establecer conexion");
    exit(EXIT_FAILURE);
  }

  printf("[Cliente]: Conectado al servidor. Escribi operaciones (ej: 10+5) o "
         "'exit'\n");

  while (1) {
    // Ahora debemos obtener la formula del cliente y enviarsela al servido.
    printf("> ");
    fflush(stdout);

    if (fgets(buffer, BUFFER_SIZE, stdin) == NULL) {
      break;
    }

    // Enviamos al servidor
    write(sockfd, buffer, strlen(buffer));

    // Si el usuario quiere salir
    if (strncmp(buffer, "exit", 4) == 0) {
      break;
    }

    // Leemos respuesta
    memset(buffer, 0, BUFFER_SIZE);

    int n = read(sockfd, buffer, BUFFER_SIZE);
    if (n <= 0) {
      printf("[Cliente]: Servidor desconectado\n");
      break;
    }

    buffer[n] = '\0';

    printf("[Servidor]: respuesta de la operacion: %s", buffer);
  }

  close(sockfd);
  return 0;
}
