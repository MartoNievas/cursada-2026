#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/select.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>

#define SOCK_PATH "/tmp/chat_server.sock"
#define BUFFER_SIZE 256

int main() {
  int sock_fd;
  struct sockaddr_un addr;
  char buffer[BUFFER_SIZE];

  sock_fd = socket(AF_UNIX, SOCK_STREAM, 0);
  if (sock_fd < 0) {
    perror("Error al crear el socket");
    exit(EXIT_FAILURE);
  }

  memset(&addr, 0, sizeof(addr));
  addr.sun_family = AF_UNIX;
  strncpy(addr.sun_path, SOCK_PATH, sizeof(addr.sun_path) - 1);

  if (connect(sock_fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
    perror("Error al conectar con el servidor (¿está encendido?)");
    exit(EXIT_FAILURE);
  }

  printf("¡Conectado al chat! Escribe un mensaje y presiona Enter.\n");
  printf("Para salir, presiona Ctrl+C o cierra la terminal.\n");
  printf("---------------------------------------------------\n");

  fd_set readfds;

  while (1) {
    FD_ZERO(&readfds);

    // Vigilar el teclado (Standard Input es el file descriptor 0)
    FD_SET(STDIN_FILENO, &readfds);
    // Vigilar el socket (para mensajes que vengan del servidor)
    FD_SET(sock_fd, &readfds);

    // Bloqueamos hasta que haya entrada del teclado o del socket
    if (select(sock_fd + 1, &readfds, NULL, NULL, NULL) < 0) {
      perror("Error en select");
      break;
    }

    // 1. ¿El usuario escribió algo en el teclado?
    if (FD_ISSET(STDIN_FILENO, &readfds)) {
      memset(buffer, 0, BUFFER_SIZE);
      if (fgets(buffer, BUFFER_SIZE, stdin) != NULL) {
        write(sock_fd, buffer, strlen(buffer));
      }
    }

    // 2. ¿El servidor nos envió un mensaje de otro usuario?
    if (FD_ISSET(sock_fd, &readfds)) {
      memset(buffer, 0, BUFFER_SIZE);
      int bytes = read(sock_fd, buffer, BUFFER_SIZE - 1);
      if (bytes <= 0) {
        printf("\nDesconectado del servidor.\n");
        break;
      }
      // Imprimimos el mensaje recibido
      printf("> Mensaje entrante: %s", buffer);
    }
  }

  close(sock_fd);
  return 0;
}
