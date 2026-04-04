#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>

#define SOCKET_PATH "/tmp/ejercicio20.sock"
#define N 4

int main() {
  int sock_fd;
  struct sockaddr_un addr;
  int value;

  // Creamos el socket

  sock_fd = socket(AF_UNIX, SOCK_STREAM, 0);
  if (sock_fd < 0) {
    perror("Fallo en la creacion del socket proceso2\n");
    exit(1);
  }

  // Configuramos la direccion
  memset(&addr, 0, sizeof(addr));
  addr.sun_family = AF_UNIX;
  strncpy(addr.sun_path, SOCKET_PATH, sizeof(addr.sun_path) - 1);

  if (connect(sock_fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
    perror("Error en la conexion del socket proceso2\n");
    exit(1);
  }

  // Ahora una vez conectado podemos recibir mensajes y enviar
  for (int i = 1; i < N; i += 2) {
    read(sock_fd, &value, sizeof(value));
    printf("Proceso2 recibe el valor %d\n", value);

    printf("El Proceso2 envia a Proceso1 el valor %d\n", i);
    write(sock_fd, &i, sizeof(i));
  }

  close(sock_fd);
  return 0;
}
