#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

int n;
int numero_maldito;
int rondas;
int pids[10];

int pids_vivos[10] = {0};

int generate_random_number() {
  // Funcion para cargar nueva semilla para el numero aleatorio
  srand(time(NULL) ^ getpid());
  return (rand() % n);
}

void sigterm_handler(int sig) {
  printf("Soy el hijo y recibi SIGTERM\n");
  int numero = generate_random_number();
  pid_t pid = getpid();
  if (numero == numero_maldito) {
    // Si el numero coincide con el maldito dijo mis ultimas palabras
    printf("Me muero papa\n");
    exit(0);
  }
  // caso contrario sobrevive
}

void sigchld_handler(int sig) {

  // Capturamos el pid
  int status;
  pid_t pid = wait(&status);

  for (int i = 0; i < n; i++) {
    if (pids[i] == pid) {
      // Aviso que ese pid murio
      pids_vivos[i] = 0;
    }
  }
}

void proceso_hijo() {

  signal(SIGTERM, sigterm_handler);

  while (1) {
  }
}

int main(int argc, char const *argv[]) {

  if (argc != 4) {
    printf("Uso: %s <N> <Numero de rondas> <Numero maldito>\n", argv[0]);
    exit(EXIT_FAILURE);
  }

  n = atoi(argv[1]);
  rondas = atoi(argv[2]);
  numero_maldito = atoi(argv[3]);

  if (n >= 10) {
    printf("El numero %d, debe ser menor a 10\n", n);
    exit(EXIT_FAILURE);
  }

  if (numero_maldito >= n || numero_maldito < 0) {
    printf("El numero maldito %d, debe ser menor a N y mayor a 0\n",
           numero_maldito);
    exit(EXIT_FAILURE);
  }

  // Ahora creamos los n-hijos
  for (int i = 0; i < n; i++) {
    pid_t pid = fork();

    // guardamos el numero de pid del proceso hijo
    pids[i] = pid;

    // Marcamos como vivo
    pids_vivos[i] = 1;

    // Si no se creo correctamente
    if (pid < 0) {
      printf("Error al crear uno de los hijos\n");
      exit(EXIT_FAILURE);
    } else if (pid == 0) {
      // El hijo se creo correctamente
      proceso_hijo();
    }
  }
  // Por cada ronda
  for (int i = 0; i < rondas; i++) {
    // Mandamos a los n hijos la señal SIGTERM
    for (int j = 0; j < n; j++) {
      pid_t current_pid = pids[j];

      kill(current_pid, SIGTERM);

      // Esperamos 1 segundo entre proceso y proceso
      sleep(1);

      signal(SIGCHLD, sigchld_handler);
    }
  }

  // Ahora el padre debe buscar los que sobrevivieron
  for (int i = 0; i < n; i++) {

    // Si esta vivo...
    if (pids_vivos[i] == 1) {
      printf("Ganador: %d, pid: %d\n", i, pids[i]);
      // Por ultimo debo matarlo.
      kill(pids[i], SIGKILL);
    }
  }

  exit(0);
}
