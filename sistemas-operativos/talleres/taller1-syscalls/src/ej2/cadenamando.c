/*
 * SSOO - La Cadena de Mando (template)
 *
 * Uso: ./bin/cadenamando N K J   (o: make run-ej2 N=4 K=5 J=1)
 *   N: cantidad de hijos a crear (1 <= N < 10)
 *   K: cantidad de rondas (K > 0)
 *   J: numero maldito (0 <= J < N)
 *
 * Formato de salida esperado (no lo cambies, la corrección automática
 * depende de esto):
 *
 *   HIJO <id> PID <pid> ULTIMAS_PALABRAS mando_total=<valor>
 *   SOBREVIVIENTE <id> PID <pid>
 *   PADRE mando_total=<valor>
 *
 * Restricciones:
 *   - Solo señales y llamadas de gestión de procesos (fork, la
 *     familia de wait, kill, pause, etc). Nada de pipes, memoria
 *     compartida ni sockets.
 */

#include <bits/types/sigset_t.h>
#include <errno.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#define MAX_N 10
#define SENIAL_PASO_MANDO SIGUSR1
#define SENIAL_ENTREGAR_MANDO SIGUSR2
#define SENIAL_HIJO_TERMINO SIGCHLD
/* ---------------------------------------------------------------------
 * TODO 1: Declarar la(s) variable(s) global(es) que van a representar
 * la cuenta de pases del mando (una en el padre, y una por cada hijo,
 * ya que cada proceso tiene su propia copia desde el fork()).
 *
 * Pensá: ¿qué la va a leer? ¿qué la va a escribir? ¿desde dónde
 * (flujo normal del programa, o un manejador de señal)?
 *
 * ------------------------------------------------------------------ */

static int pases_padre = 0;
static int pases_hijos[MAX_N];

/* TODO 2: variables globales que necesite el padre para llevar el
 * estado del juego: PIDs de los hijos, quién sigue vivo, a quién le
 * toca el mando ahora, cuántas rondas van, etc.
 */
static pid_t pids[MAX_N];
/* ... */

// Para tener un referencia de cada pid vivo
static int hijos_vivos[MAX_N];
// para tener una referencia de los que estan vivos en un instante
static int cantidad_hijos_vivos;
static int id_mando_actual;

static int N, K, J;

/* ---------------------------------------------------------------------
 * Manejadores de señal.
 *
 * Recordá: dentro de un manejador sólo podés usar funciones
 * async-signal-safe (nada de printf). Si necesitás "avisar" algo al
 * resto del programa, la forma habitual es levantar una bandera y
 * procesarla fuera del handler.
 * ------------------------------------------------------------------ */

static volatile sig_atomic_t mando_recibido = 0;
static volatile sig_atomic_t alguien_paso_mando = 0;
static volatile sig_atomic_t algun_hijo_termino = 0;

static void manejador_mando_recibido(int sig) {
  (void)sig;
  /* TODO 3 (hijo): marcar que llegó el mando (sólo levantar un
   * flag acá; el trabajo real -sortear el número, decidir si
   * termina o sigue- se hace en el loop principal del hijo). */
  mando_recibido = 1;
}

static void manejador_alguien_paso_mando(int sig) {
  (void)sig;
  /* TODO 4 (padre): un hijo avisó que quiere pasar el mando.
   * ¿Qué es lo mínimo que hay que hacer acá adentro, y qué es mejor
   * dejar para el loop principal del padre? */
  alguien_paso_mando = 1;
}

static void manejador_hijo_termino(int sig) {
  (void)sig;
  /* TODO 5 (padre): un hijo terminó y el padre fue notificado por señal.
   * Ojo: esta señal no encola. Si reapeás con un único wait, ¿qué puede pasar
   * si mueren dos hijos casi al mismo tiempo (por ejemplo, cuando el
   * padre manda SIGKILL a varios sobrevivientes juntos al final)?
   * ¿Hace falta hacer el reapeo real acá adentro, o alcanza con que
   * este handler haga que pause() se despierte? */
  algun_hijo_termino = 1;
}

/* ---------------------------------------------------------------------
 * Lógica del hijo
 * ------------------------------------------------------------------ */

static void correr_hijo(int id) {
  /* TODO 6: sembrar el generador de números aleatorios. Pensá bien
   * en qué momento hay que hacer esto (antes o después del fork?) y
   * con qué semilla, para que cada hijo saque números distintos. */

  srand(time(NULL) ^ getpid());

  /* TODO 7: instalar el/los manejador(es) de señal que necesite este
   * proceso hijo (con signal(), no con sigaction). */
  signal(SENIAL_ENTREGAR_MANDO, manejador_mando_recibido);
  for (;;) {
    /* TODO 8: si llegó el mando (ver bandera de TODO 3):
     *   - incrementar la copia local de la cuenta de pases
     *   - sortear un numero entre 0 y N-1
     *   - si es el numero maldito J: imprimir las ultimas palabras
     *     con el formato pedido y terminar (exit) usando el propio
     *     id como codigo de salida
     *   - si no: avisarle al padre que hay que pasar el mando
     *     (¿con qué señal? ¿a quién hay que mandársela?), y volver
     *     a esperar
     */

    // Creamos la mascara de seniales que queremos bloquear para poder
    // enconlarlas
    sigset_t mask_desbloqueada;
    sigemptyset(&mask_desbloqueada);

    while (!mando_recibido) {
      sigsuspend(&mask_desbloqueada);
    }

    // Restauramos la flag del mando
    mando_recibido = 0;

    // Procedimiento normal de un hijo vivo
    pases_hijos[id]++;
    int numero_aleatorio = rand() % N;

    if (numero_aleatorio == J) {
      printf("HIJO %d PID %d ULTIMAS_PALABRAS mando_total=%d\n", id, getpid(),
             pases_hijos[id]);
      fflush(stdout);
      exit(id);
    }

    kill(getppid(), SENIAL_PASO_MANDO);
  }
}

/* ---------------------------------------------------------------------
 * Lógica del padre
 * ------------------------------------------------------------------ */

static int validar_parametros(int argc, char **argv) {
  if (argc != 4) {
    fprintf(stderr, "uso: %s N K J\n", argv[0]);
    return -1;
  }
  N = atoi(argv[1]);
  K = atoi(argv[2]);
  J = atoi(argv[3]);
  if (N <= 0 || N >= MAX_N) {
    fprintf(stderr, "N debe ser mayor a 0 y menor a %d\n", MAX_N);
    return -1;
  }
  if (K <= 0) {
    fprintf(stderr, "K debe ser mayor a 0\n");
    return -1;
  }
  if (J < 0 || J >= N) {
    fprintf(stderr, "J debe cumplir 0 <= J < N\n");
    return -1;
  }
  return 0;
}

int main(int argc, char **argv) {
  if (validar_parametros(argc, argv) != 0) {
    return 1;
  }

  /* TODO 9: instalar en el padre los manejadores de señal que
   * necesite (¿cuáles señales le van a llegar al padre a lo largo
   * del juego?). */
  signal(SENIAL_PASO_MANDO, manejador_alguien_paso_mando);
  signal(SENIAL_HIJO_TERMINO, manejador_hijo_termino);

  // Hacemos que los hijos hereden la mascara de bits con la senial
  // SENIAL_ENTREGAR_MANDO bloqueda para no generar una condicion de carrera
  sigset_t mask_hijos, previas_padre;
  sigemptyset(&mask_hijos);
  sigaddset(&mask_hijos, SENIAL_ENTREGAR_MANDO);

  /*
   * Para mas robustez podemos bloquear las seniales SENIAL_PASO_MANDO y
   * SENIAL_HIJO_TERMINO a los hijos ya que estos en teoria nunca les van a
   * llegar, pero en caso de que les lleguen no van a hacer nada
   */

  sigaddset(&mask_hijos, SENIAL_PASO_MANDO);
  sigaddset(&mask_hijos, SENIAL_HIJO_TERMINO);

  sigprocmask(SIG_BLOCK, &mask_hijos, &previas_padre);

  for (int i = 0; i < N; i++) {
    pid_t pid = fork();
    if (pid < 0) {
      perror("fork");
      /* TODO: decidir qué hacer si falla un fork a mitad de
       * camino (¿matar a los ya creados?) */
      for (int j = 0; j < i; j++) {
        kill(pids[j], SIGKILL);
        waitpid(pids[j], NULL, 0);
      }
      return 1;
    }
    if (pid == 0) {
      correr_hijo(i);
      _exit(1); /* correr_hijo nunca deberia retornar */
    }

    pids[i] = pid;
    hijos_vivos[i] = 1;
  }

  cantidad_hijos_vivos = N;

  /* TODO 10: arrancar el juego (¿quién tiene el mando al empezar la
   * primera ronda?), y despues loopear esperando señales (pause())
   * hasta cubrir las K rondas o quedar un solo sobreviviente.
   *
   * En cada despertar conviene, sin asumir nada sobre cuántas
   * señales concretas llegaron, revisar el estado real de los
   * hijos (pista: la familia de wait con WNOHANG en loop). */

  for (int ronda = 0; ronda < K && cantidad_hijos_vivos > 1; ronda++) {
    id_mando_actual = 0;

    while (id_mando_actual < N) {
      // Si el proceso sucesor esta muerto vamos con el siguiente
      if (!hijos_vivos[id_mando_actual]) {
        id_mando_actual++;
        continue;
      }
      pases_padre++;

      pid_t pid_actual = pids[id_mando_actual];
      kill(pid_actual, SENIAL_ENTREGAR_MANDO);

      // Para mejorar las robustez del disenio, al tener estas dos seniales
      // bloqueadas, configuramos una nueva mascara vacia
      sigset_t mask_desbloqueada;
      sigemptyset(&mask_desbloqueada);

      while (!alguien_paso_mando && !algun_hijo_termino) {
        // Y con sigsuspend las habilitamos
        // temporalmente para responder los mensajes
        // encolados y prevenir que se cuelgue el padre
        // esperando una senial que nunca va a llegar
        sigsuspend(&mask_desbloqueada);
      }

      // Logica de muerte del hijo i-esimo
      int status;
      pid_t pid_muerto;

      // utilizando esta sintaxis, vamos reasignando hasta que encontremos un
      // hijo que murio y pasandole la flag WNOHANG hacemos que waitpid no sea
      // bloqueante por si no muere
      while ((pid_muerto = waitpid(-1, &status, WNOHANG)) > 0) {
        for (int i = 0; i < N; i++) {
          if (pid_muerto == pids[i]) {
            hijos_vivos[i] = 0;
            cantidad_hijos_vivos--;
            break;
          }
        }
      }

      // Reseteamos ambas flags para el proximo mando
      algun_hijo_termino = 0;
      alguien_paso_mando = 0;

      // Pasamos al siguiente
      id_mando_actual++;
    }
  }

  sigprocmask(SIG_SETMASK, &previas_padre, NULL);

  /* TODO 11: al terminar, imprimir los sobrevivientes (formato
   * pedido), mandarles SIGKILL a los que queden vivos, reapearlos
   * (¡que no queden zombies!), e imprimir la cuenta final del
   * padre. */

  // Matamos los hijos que sobrevivieron
  for (int i = 0; i < N; i++) {
    if (hijos_vivos[i]) {
      printf("SOBREVIVIENTE %d PID %d\n", i, pids[i]);
      fflush(stdout);
      kill(pids[i], SIGKILL);
      waitpid(pids[i], NULL, 0);
    }
  }

  printf("PADRE mando_total=%d\n", pases_padre);
  fflush(stdout);
  return 0;
}
