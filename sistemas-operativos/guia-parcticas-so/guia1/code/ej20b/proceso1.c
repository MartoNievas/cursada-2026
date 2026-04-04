#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>

#define SOCK_P1 "/tmp/sock_p1.sock"
#define SOCK_P2 "/tmp/sock_p2.sock"
#define N 50

int main() {
  int server_fd, client_fd, send_fd;
  struct sockaddr_un addr;
  int value = 0;

  // Creamos el socket servidor
  server_fd = socket(AF_UNIX, SOCK_STREAM, 0);
  if (server_fd < 0) {
    perror("Error en la creacion del servidor de Proceso1\n");
    exit(1);
  }
  memset(&addr, 0, sizeof(addr));
  addr.sun_family = AF_UNIX;
  strncpy(addr.sun_path, SOCK_P1, sizeof(addr.sun_path) - 1);
  unlink(SOCK_P1);
  if (bind(server_fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
    perror("Error en bind proceso1\n");
    exit(1);
  }
  if (listen(server_fd, 1) < 0) {
    perror("Error en listen proceso1\n");
    exit(1);
  }

  // Ahora conectamos a P2 (se pisa addr, no importa porque bind ya termino)
  send_fd = socket(AF_UNIX, SOCK_STREAM, 0);
  memset(&addr, 0, sizeof(addr));
  addr.sun_family = AF_UNIX;
  strncpy(addr.sun_path, SOCK_P2, sizeof(addr.sun_path) - 1);
  while (connect(send_fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
    printf("Esperando a que Proceso2 se conecte...\n");
    sleep(1);
  }
  printf("Proceso 1: conectado a Proceso2\n");

  client_fd = accept(server_fd, NULL, NULL);
  printf("Proceso1: conexion acceptada de Proceso3\n");

  while (value < N) {
    printf("Proceso1 envia a Proceso2 el valor %d\n", value);
    write(send_fd, &value, sizeof(value));
    value++;

    read(client_fd, &value, sizeof(value));
    printf("Proceso1 recibe de Proceso3 el valor %d\n", value);
    value++;
  }

  close(client_fd);
  close(server_fd);
  close(send_fd);
  unlink(SOCK_P1);
  return 0;
}
