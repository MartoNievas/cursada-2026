#include <math.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <sys/un.h>
#include <sys/wait.h>
#include <unistd.h>

#define SOCK_PATH "/tmp/primo_server.sock"
#define NUM_CHIDLS 3

enum { READ, WRITE };

int main(int argc, char *argv[]) {
  if (argc != 2) {
    fprintf(stderr, "Uso: %s <numero>\n", argv[0]);
    exit(1);
  }

  long long number = atoll(argv[1]);

  int sock_fd;
  struct sockaddr_un addr;

  // Creamos el socket
  sock_fd = socket(AF_UNIX, SOCK_STREAM, 0);
  if (sock_fd < 0) {
    perror("Cliente: Error al crear el socket\n");
    exit(1);
  }
  memset(&addr, 0, sizeof(addr));
  addr.sun_family = AF_UNIX;
  strncpy(addr.sun_path, SOCK_PATH, sizeof(addr.sun_path) - 1);

  // Ahora realizamos la conexion
  if (connect(sock_fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
    perror("Cliente: error al conetar el cliente\n");
    exit(1);
  }

  // Por ultimo debemos escribir el numero en el socket

  write(sock_fd, &number, sizeof(number));

  int res;
  read(sock_fd, &res, sizeof(res));
  printf("%lld %s primo\n", number, res ? "ES" : "NO ES");
  return EXIT_SUCCESS;
}
