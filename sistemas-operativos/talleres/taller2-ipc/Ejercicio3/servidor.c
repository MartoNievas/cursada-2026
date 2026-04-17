#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <sys/un.h>
#include <unistd.h>

#define SOCK_PATH "/tmp/chat_server.sock"
#define BUFFER_SIZE 64
#define MAX_CLIENTES 5

int calcular(const char *expresion) {
  int num1, num2, resultado;
  char operador;

  // Usamos sscanf para extraer los dos números y el operador de la expresión
  if (sscanf(expresion, "%d%c%d", &num1, &operador, &num2) != 3) {
    printf("Formato incorrecto\n");
    return 0; // En caso de error, retornamos 0.
  }

  // Realizamos la operación según el operador
  switch (operador) {
  case '+':
    resultado = num1 + num2;
    break;
  case '-':
    resultado = num1 - num2;
    break;
  case '*':
    resultado = num1 * num2;
    break;
  case '/':
    if (num2 != 0) {
      resultado = num1 / num2;
    } else {
      printf("Error: División por cero\n");
      return 0; // Si hay división por cero, retornamos 0.
    }
    break;
  default:
    printf("Operador no reconocido\n");
    return 0; // Si el operador no es válido, retornamos 0.
  }

  return resultado;
}

void manejar_clientes(int cliente_fd) {
  char buffer[BUFFER_SIZE];

  while (1) {
    memset(buffer, 0, BUFFER_SIZE);

    int n = read(cliente_fd, buffer, sizeof(buffer));
    if (n <= 0)
      break;

    buffer[n] = '\0';

    printf("[Servidor]: Recibi %s", buffer);

    if (strncmp(buffer, "exit", 4) == 0) {
      // Terminamos el proceso
      printf("[Servidor]: Cerrando conexion con cliente %d\n", cliente_fd);
      sleep(1);
      break;
    }

    int res = calcular(buffer);

    char respuesta[BUFFER_SIZE];
    snprintf(respuesta, BUFFER_SIZE, "Resultado: %d\n", res);

    write(cliente_fd, respuesta, strlen(respuesta));
  }

  close(cliente_fd);
  exit(0);
}

int main() {

  // COMPLETAR. Este es un ejemplo de funcionamiento básico.
  // La expresión debe ser recibida como un mensaje del cliente hacia el
  // servidor.
  int servidor_fd, cliente_fd;
  struct sockaddr_un addr;

  signal(SIGCHLD, SIG_IGN);

  servidor_fd = socket(AF_UNIX, SOCK_STREAM, 0);
  if (servidor_fd < 0) {
    perror("[Servidor]: Error al crear el scoket del servidor");
    exit(EXIT_FAILURE);
  }

  // Ahora lo eliminamos si ya existe
  unlink(SOCK_PATH);

  // Ahora setemaos el servidor
  memset(&addr, 0, sizeof(addr));
  // Familia del soceckt
  addr.sun_family = AF_UNIX;
  // Path del socket
  strcpy(addr.sun_path, SOCK_PATH);

  if (bind(servidor_fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
    perror("bind");
    exit(EXIT_FAILURE);
  }

  if (listen(servidor_fd, MAX_CLIENTES) < 0) {
    perror("listen");
    exit(EXIT_FAILURE);
  }

  // Una vez que el servidor escucha
  printf("[Servidor]: Escuchando en %s\n", SOCK_PATH);

  // Ciclo esperando peticion del cliente
  while (1) {
    // Le ponemos null porque no nesecitamos la info del strcut addr
    cliente_fd = accept(servidor_fd, NULL, NULL);

    if (cliente_fd < 0) {
      perror("[Servidor]: Error al extraer solicitud de conexion");
      exit(EXIT_FAILURE);
    }

    printf("Nuevo cliente conectado\n");

    pid_t pid = fork();

    if (pid < 0) {
      perror("[Servidor]: Error al crear un proceso hijo para el cliente");
      exit(EXIT_FAILURE);
    } else if (pid == 0) {
      // Proceso hijo
      close(servidor_fd);
      manejar_clientes(cliente_fd);
    } else {
      close(cliente_fd);
    }
  }

  unlink(SOCK_PATH);
  return 0;
}
