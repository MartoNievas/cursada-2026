#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>

#define SOCKET_PATH "/tmp/ejercicio20.sock"
#define N 4

int main() {
  int server_fd, client_fd;

  struct sockaddr_un addr;
  int value;

  // Creamos el socket del server

  server_fd = socket(AF_UNIX, SOCK_STREAM, 0);

  if (server_fd == -1) {
    perror("Error al crear el socket\n");
    exit(1);
  }

  // Ahora debemos configurar el socket

  memset(&addr, 0, sizeof(addr));
  addr.sun_family = AF_UNIX;
  strncpy(addr.sun_path, SOCKET_PATH, sizeof(addr.sun_path) - 1);

  unlink(SOCKET_PATH);

  if (bind(server_fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
    perror("Error en el bind\n");
    exit(1);
  }

  if (listen(server_fd, 1) < 0) {
    perror("Error en listen\n");
    exit(1);
  }

  printf("Proceso1: Esperando conexion...\n");
  client_fd = accept(server_fd, NULL, NULL);
  if (client_fd < 0) {
    perror("Error al aceptar el cliente\n");
    exit(1);
  }

  for (int i = 0; i < N; i += 2) {
    // Enviamos valores pares y recibimos impares
    printf("Proceso1 envia a Proceso2 el valor %d\n", i);
    write(client_fd, &i, sizeof(i));

    // Ahora recibimos el valor impar

    read(client_fd, &value, sizeof(value));
    printf("El proceso1 recibe el valor %d\n", value);
  }

  close(client_fd);
  close(server_fd);
  unlink(SOCKET_PATH);
  return 0;
}
