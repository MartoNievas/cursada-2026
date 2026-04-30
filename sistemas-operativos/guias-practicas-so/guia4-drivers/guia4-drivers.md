# Práctica 4: Drivers y Administración de E/S

## Parte 1 – Interfaz de E/S

### Ejercicio 1

Vamos a seleccionar las opciones correctas que describen el concepto de driver:

- **a)** En esencia es un módulo/pieza de software que se comunica con el usuario y el controller, por lo que sirve como una capa intermedia de comunicación.
- **c)** Como ya dije, es un módulo que se integra al **SO**, ya que estos se ejecutan en modo **Kernel** (cuando se carga el sistema) y extiende las capacidades del **SO**.

---

### Ejercicio 2

Vamos con el código del driver donde vamos a escribir las funciones `driver_init()`, `driver_read(void* data)` y `driver_write(void* data)`:

```C
semaphore mutex;

int driver_init() {
  // Inicializamos el semáforo para la sincronización
  sem_init(&mutex, 1);
  return 0;
}

int driver_write(void* udata) {
  mutex.lock();                    // Entramos en la sección crítica
  OUT(CHRONO_CTRL, CHRONO_RESET);
  mutex.unlock();                  // Saliendo de la sección crítica
  return 0;
}

// Ahora vamos con read
int driver_read(void* udata) {
  mutex.lock();                                         // Sección crítica
  int current_time = IN(CHRONO_CURRENT_TIME);
  copy_to_user(udata, &current_time, sizeof(current_time));
  mutex.unlock();                                       // Fin de sección crítica
  return current_time;
}
```

Ahora vamos a dar un ejemplo de código de una aplicación de usuario que la puede utilizar:

```C
int main(int argc, char** argv) {
  int cronometro = open("/dev/cronometro", "rw");
  int numero;
  int tiempo;

  while (1) {
    printf("¿Querés leer el cronómetro (0) o reiniciarlo (1)?\n");
    scanf("%d", &numero);

    if (numero == 0) {
      read(cronometro, &tiempo);
      printf("El tiempo transcurrido es %d\n", tiempo);
    } else if (numero == 1) {
      printf("Reiniciando cronómetro...\n");
      sleep(1);
      write(cronometro, 0);
    } else {
      printf("Saliendo del programa...\n");
      break;
    }
  }

  close(cronometro);
  return 0;
}
```

---

### Ejercicio 3

Tenemos los siguientes registros:

- $BTN\_STATUS_0$: vale 0 si la tecla no fue pulsada, 1 si fue pulsada.
- $BTN\_STATUS_1$: escribir 0 en este bit limpia la memoria de la tecla.
- $BTN\_PRESSED$: indica la tecla presionada.

Vamos con el código del driver, donde solo vamos a implementar las mismas funciones que en el ejercicio anterior:

```C
// Requerimos de un mutex para evitar race conditions en secciones críticas
semaphore mutex;

int driver_init() {
  sem_init(&mutex, 1);
  return 0;
}

int driver_read(void* udata) {
  // Busy-waiting hasta que se presione una tecla
  while ((IN(BTN_STATUS) & 0b1) != 1) {}

  mutex_lock(&mutex);   // Inicio de sección crítica

  // Cuando llegamos acá, se presionó una tecla
  OUT(BTN_STATUS, 0);
  int res = IN(BTN_PRESSED);
  copy_to_user(udata, &res, sizeof(res));

  mutex_unlock(&mutex); // Fin de sección crítica
  return 1;
}
```

Con eso dejamos listo el driver. Para dar una pequeña explicación: con `init` inicializamos el mutex/semáforo que vamos a utilizar para garantizar la exclusión mutua. En el `read`, nos quedamos esperando en busy-waiting hasta que el bit menos significativo sea 1; luego entramos en sección crítica usando el mutex, borramos la memoria de la tecla, leemos `BTN_PRESSED` y salimos de la sección crítica. Por último, retornamos 1.

---

### Ejercicio 4

Ahora debemos reescribir el driver del ejercicio anterior usando interrupciones. La tecla se conecta a la interrupción número 7 y se debe guardar la constante `BTN_INIT` en el registro de la tecla cuando se detecta una nueva pulsación.

```C
//Declaramos variable que se van a utilizar
semaphore sem_read;
semaphore mutex;

// Vamos con el init
int driver_init() {
  // En 0 porque inicialmente nadie puede leer
  sem_init(&sem_read,0);
  sem_init(&mutex,1);
  irq_register(7,handler);
  return 0;
}

//Ahora hacemos el free
int driver_remove() {
  irq_free(7);
  return 0;
}

// Hacemos el handler de la interrupción
void handler(int sig) {
  (void) sig;   
  signal(&sem_read);
} 

// Por último el read
int driver_read(void* udata) {
  
  // Ahora esperamos hasta que nos habiliten leer

  wait(&sem_read);

  // Una vez que nos habilitan 
  wait(&mutex);
  OUT(BTN_STATUS,BTN_INIT);
  signal(&mutex);

  // Escribimos la tecla
  int res = BTN_PRESSED;
  copy_to_user(udata,&res,sizeof(res));

  return sizeof(int);
}
```

### Ejercicio 5

Tenemos que indicar las acciones que debe tomar el administrador de E/S:

- **a)** Cuando se ejecuta un `open()`, primero el administrador debe verificar que el dispositivo exista y verificar que el usuario tenga permisos para acceder al mismo. Por otro lado, debe inicializar todas las estructuras para la comunicación de una aplicación a nivel de usuario con el dispositivo. Por último, hay que actualizar las estructuras del **SO** que indican los dispositivos abiertos.

- **b)** Cuando se efectúa un `write()`, primero hay que verificar que exista el dispositivo, que esté abierto y además que el usuario tenga permisos de escritura sobre el mismo. Luego debemos hacer un `copy_from_user()` sobre el dato que nos pasó el usuario, comunicarse con el dispositivo mediante `OUT()` y por último devolver la cantidad de bytes que se escribieron para indicar que la escritura fue exitosa.

### Ejercicio 6

Las operaciones IN y OUT son instrucciones privilegiadas que deben ejecutarse en modo kernel (nivel 0), ya que permiten acceder directamente a los registros de E/S. Por razones de seguridad y aislamiento, no deben estar disponibles en modo usuario, sino que su uso queda restringido a drivers dentro del sistema operativo, los cuales corren a nivel de kernel.
