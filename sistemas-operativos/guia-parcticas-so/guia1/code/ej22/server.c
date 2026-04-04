#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/select.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>

#define SOCK_PATH "/tmp/chat_server.sock"
#define MAX_CLIENTES 5
#define BUFFER_SIZE 256

int main() {
  int server_fd, nuevo_socket;
  struct sockaddr_un addr;

  // Array para guardar los file descriptors de los clientes conectados
  int clientes[MAX_CLIENTES];
  for (int i = 0; i < MAX_CLIENTES; i++) {
    clientes[i] = 0; // 0 significa "espacio libre"
  }

  server_fd = socket(AF_UNIX, SOCK_STREAM, 0);
  if (server_fd < 0) {
    perror("Error al crear socket");
    exit(EXIT_FAILURE);
  }

  memset(&addr, 0, sizeof(addr));
  addr.sun_family = AF_UNIX;
  strncpy(addr.sun_path, SOCK_PATH, sizeof(addr.sun_path) - 1);
  unlink(SOCK_PATH);

  if (bind(server_fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
    perror("Error en bind");
    exit(EXIT_FAILURE);
  }

  if (listen(server_fd, 5) < 0) {
    perror("Error en listen");
    exit(EXIT_FAILURE);
  }

  printf("Chat Server iniciado. Soportando máximo %d clientes.\n",
         MAX_CLIENTES);

  fd_set readfds;
  char buffer[BUFFER_SIZE];

  while (1) {
    // Limpiamos el set de sockets y añadimos el servidor
    FD_ZERO(&readfds);
    FD_SET(server_fd, &readfds);
    int max_sd = server_fd;

    // Añadimos los sockets de los clientes activos al set
    for (int i = 0; i < MAX_CLIENTES; i++) {
      int sd = clientes[i];
      if (sd > 0) {
        FD_SET(sd, &readfds);
      }
      if (sd > max_sd) {
        max_sd = sd;
      }
    }

    // Esperamos a que pase algo en alguno de los sockets
    // select se bloquea hasta que alguien se conecta o envía un mensaje
    int actividad = select(max_sd + 1, &readfds, NULL, NULL, NULL);
    if (actividad < 0) {
      perror("Error en select");
      continue;
    }

    // 1. ¿Hay una nueva conexión entrante en el socket del servidor?
    if (FD_ISSET(server_fd, &readfds)) {
      nuevo_socket = accept(server_fd, NULL, NULL);
      if (nuevo_socket >= 0) {
        // Buscamos un lugar libre en el array
        int anadido = 0;
        for (int i = 0; i < MAX_CLIENTES; i++) {
          if (clientes[i] == 0) {
            clientes[i] = nuevo_socket;
            printf("Nuevo cliente conectado en el slot %d\n", i);
            anadido = 1;
            break;
          }
        }
        // Si no hay espacio, rechazamos la conexión
        if (!anadido) {
          printf("Servidor lleno. Rechazando conexión.\n");
          char *msg = "Servidor lleno. Intenta más tarde.\n";
          write(nuevo_socket, msg, strlen(msg));
          close(nuevo_socket);
        }
      }
    }

    // 2. ¿Algún cliente envió un mensaje o se desconectó?
    for (int i = 0; i < MAX_CLIENTES; i++) {
      int sd = clientes[i];

      if (sd > 0 && FD_ISSET(sd, &readfds)) {
        memset(buffer, 0, BUFFER_SIZE);
        int bytes_leidos = read(sd, buffer, BUFFER_SIZE - 1);

        if (bytes_leidos == 0) {
          // El cliente se desconectó
          printf("Cliente en slot %d desconectado.\n", i);
          close(sd);
          clientes[i] = 0; // Liberamos el espacio
        } else {
          // Mensaje recibido, debemos retransmitirlo a LOS DEMÁS
          buffer[bytes_leidos] = '\0';
          printf("Mensaje recibido del slot %d: %s", i, buffer);

          for (int j = 0; j < MAX_CLIENTES; j++) {
            // Enviamos a todos menos al que lo mandó y a los slots vacíos
            if (clientes[j] > 0 && clientes[j] != sd) {
              write(clientes[j], buffer, strlen(buffer));
            }
          }
        }
      }
    }
  }

  close(server_fd);
  unlink(SOCK_PATH);
  return 0;
}
