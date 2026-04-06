#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <sys/wait.h>
#include <unistd.h>

#define SOCK_PATH "/tmp/primo_server.sock"
#define NUM_HIJOS 3

int es_primo(long long n) {
  if (n < 2)
    return 0;
  if (n == 2)
    return 1;
  if (n % 2 == 0)
    return 0;
  for (long long i = 3; i * i <= n; i += 2)
    if (n % i == 0)
      return 0;
  return 1;
}

// Bucle en el que trabajarán los hijos
void worker_loop(int server_fd) {
  int client_fd;
  long long numero;

  while (1) {
    // El SO se encarga de despertar a un solo hijo cuando llega un cliente
    client_fd = accept(server_fd, NULL, NULL);
    if (client_fd < 0) {
      perror("accept");
      continue;
    }

    if (read(client_fd, &numero, sizeof(numero)) > 0) {
      int resultado = es_primo(numero);
      write(client_fd, &resultado, sizeof(resultado));
      printf("Hijo %d: %lld es %sprimo\n", getpid(), numero,
             resultado ? "" : "no ");
    }
    close(client_fd); // El hijo cierra la conexión con ese cliente específico
  }
}

int main() {
  int server_fd;
  struct sockaddr_un addr;

  // 1. Crear socket servidor
  server_fd = socket(AF_UNIX, SOCK_STREAM, 0);
  if (server_fd < 0) {
    perror("socket");
    exit(1);
  }

  memset(&addr, 0, sizeof(addr));
  addr.sun_family = AF_UNIX;
  strncpy(addr.sun_path, SOCK_PATH, sizeof(addr.sun_path) - 1);
  unlink(SOCK_PATH);

  if (bind(server_fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
    perror("bind");
    exit(1);
  }
  if (listen(server_fd, 10) < 0) {
    perror("listen");
    exit(1);
  }

  printf("Servidor esperando conexiones...\n");

  // 2. Crear los hijos (Pre-fork)
  for (int i = 0; i < NUM_HIJOS; i++) {
    pid_t pid = fork();
    if (pid < 0) {
      perror("fork");
      exit(1);
    }
    if (pid == 0) {
      // El hijo entra al bucle de trabajo y nunca sale de esta función
      worker_loop(server_fd);
      exit(0);
    }
  }

  // 3. El padre simplemente espera a que los hijos terminen (infinitamente en
  // este caso)
  for (int i = 0; i < NUM_HIJOS; i++) {
    wait(NULL);
  }

  close(server_fd);
  unlink(SOCK_PATH);
  return 0;
}
