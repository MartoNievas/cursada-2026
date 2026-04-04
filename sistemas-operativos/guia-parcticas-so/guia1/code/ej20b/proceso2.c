#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>

#define SOCK_P2 "/tmp/sock_p2.sock" // P2 escucha aqui (recibe de P1)
#define SOCK_P3 "/tmp/sock_p3.sock" // P2 se conecta aqui (envia a P3)
#define N 50

int main() {
  int server_fd, send_fd, client_fd;
  struct sockaddr_un addr;
  int value = 0;

  // Creamos el socket servidor (Recibe de P1)
  server_fd = socket(AF_UNIX, SOCK_STREAM, 0);
  memset(&addr, 0, sizeof(addr));
  addr.sun_family = AF_UNIX;
  strncpy(addr.sun_path, SOCK_P2, sizeof(addr.sun_path) - 1);
  unlink(SOCK_P2);
  if (bind(server_fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
    perror("Error en bind proceso2\n");
    exit(1);
  }
  if (listen(server_fd, 1) < 0) {
    perror("Error en listen proceso2\n");
    exit(1);
  }

  // Conectamos a P3
  send_fd = socket(AF_UNIX, SOCK_STREAM, 0);
  memset(&addr, 0, sizeof(addr));
  addr.sun_family = AF_UNIX;
  strncpy(addr.sun_path, SOCK_P3, sizeof(addr.sun_path) - 1);
  while (connect(send_fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
    printf("Esperando a que Proceso3 se conecte...\n");
    sleep(1);
  }
  printf("Proceso2: conectado a Proceso3\n");

  client_fd = accept(server_fd, NULL, NULL);
  printf("Proceso2: conexion aceptada de Proceso1\n");

  while (value < N) {
    read(client_fd, &value, sizeof(value));
    printf("Proceso2 recibe de Proceso1 el valor %d\n", value);
    value++;
    write(send_fd, &value, sizeof(value));
    value++;
  }

  close(server_fd);
  close(client_fd);
  close(send_fd);
  unlink(SOCK_P2);
  return 0;
}
