#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>

#define SOCK_P3 "/tmp/sock_p3.sock" // P3 escucha aqui (recibe de P2)
#define SOCK_P1 "/tmp/sock_p1.sock" // P3 se conecta aqui (envia a P1)
#define N 50

int main() {
  int server_fd, send_fd, client_fd;
  struct sockaddr_un addr;
  int value = 0;

  // Creamos el socket server que recibe de P2
  server_fd = socket(AF_UNIX, SOCK_STREAM, 0);
  memset(&addr, 0, sizeof(addr));
  addr.sun_family = AF_UNIX;
  strncpy(addr.sun_path, SOCK_P3, sizeof(addr.sun_path) - 1);
  unlink(SOCK_P3);
  if (bind(server_fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
    perror("Error bind en proceso3\n");
    exit(1);
  }
  if (listen(server_fd, 1) < 0) {
    perror("Error en listen proceso3\n");
    exit(1);
  }

  // Conectamos a P1 para enviar el valor
  send_fd = socket(AF_UNIX, SOCK_STREAM, 0);
  memset(&addr, 0, sizeof(addr));
  addr.sun_family = AF_UNIX;
  strncpy(addr.sun_path, SOCK_P1, sizeof(addr.sun_path) - 1);
  while (connect(send_fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
    printf("Esperando a que Proceso1 se conecte...\n");
    sleep(1);
  }
  printf("Proceso3: conectado a Proceso1\n");

  client_fd = accept(server_fd, NULL, NULL);
  printf("Proceso3: conexion aceptada de Proceso2\n");

  while (value < N) {
    read(client_fd, &value, sizeof(value));
    printf("Proceso3 recibe de Proceso2 el valor %d\n", value);
    value++;
    write(send_fd, &value, sizeof(value));
    value++;
  }

  close(send_fd);
  close(server_fd);
  close(client_fd);
  unlink(SOCK_P3);
  return 0;
}
