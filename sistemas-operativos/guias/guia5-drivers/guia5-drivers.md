# Práctica 5: Drivers y Administración de E/S

**Sistemas Operativos — FCEyN, Universidad de Buenos Aires**

---

> Enunciado: [PDF](p5.pdf)

---

## Parte 1 — Interfaz de E/S

---

## Ejercicio 1

Vamos a seleccionar las opciones correctas que describen el concepto de driver:

- **a)** En esencia es un módulo/pieza de software que se comunica con el usuario y el controller, por lo que sirve como una capa intermedia de comunicación.
- **c)** Como ya dije, es un módulo que se integra al **SO**, ya que estos se ejecutan en modo **Kernel** (cuando se carga el sistema) y extiende las capacidades del **SO**.

---

## Ejercicio 2

Vamos con el código del driver donde vamos a escribir las funciones `driver_init()`, `driver_read(void* data)` y `driver_write(void* data)`:

```C
semaphore mutex;

int driver_init() {
  // Inicializamos el semáforo para la sincronización
  sema_init(&mutex, 1);
  return 0;
}

int driver_write(void* udata) {
  sema_wait(&mutex);                    // Entramos en la sección crítica
  OUT(CHRONO_CTRL, CHRONO_RESET);
  sema_signal(&mutex);                  // Saliendo de la sección crítica
  return 0;
}

// Ahora vamos con read
int driver_read(void* udata) {
  sema_wait(&mutex);                                     // Sección crítica
  int current_time = IN(CHRONO_CURRENT_TIME);
  copy_to_user(udata, &current_time, sizeof(current_time));
  sema_signal(&mutex);                                   // Fin de sección crítica
  return sizeof(current_time);
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

## Ejercicio 3

Tenemos los siguientes registros:

- $BTN\_STATUS_0$: vale 0 si la tecla no fue pulsada, 1 si fue pulsada.
- $BTN\_STATUS_1$: escribir 0 en este bit limpia la memoria de la tecla.
- $BTN\_PRESSED$: indica la tecla presionada.

Vamos con el código del driver, donde solo vamos a implementar las mismas funciones que en el ejercicio anterior:

```C
// Requerimos de un mutex para evitar race conditions en secciones críticas
semaphore mutex;

int driver_init() {
  sema_init(&mutex, 1);
  return 0;
}

int driver_read(void* udata) {
  // Busy-waiting hasta que se presione una tecla
  while ((IN(BTN_STATUS) & 0b1) != 1) {}

  sema_wait(&mutex);   // Inicio de sección crítica

  // Cuando llegamos acá, se presionó una tecla
  OUT(BTN_STATUS, 0);
  int res = IN(BTN_PRESSED);
  copy_to_user(udata, &res, sizeof(res));

  sema_signal(&mutex); // Fin de sección crítica
  return sizeof(res);
}
```

Con eso dejamos listo el driver. Para dar una pequeña explicación: con `init` inicializamos el mutex/semáforo que vamos a utilizar para garantizar la exclusión mutua. En el `read`, nos quedamos esperando en busy-waiting hasta que el bit menos significativo sea 1; luego entramos en sección crítica usando el mutex, borramos la memoria de la tecla, leemos `BTN_PRESSED` y salimos de la sección crítica. Por último, retornamos 1.

---

## Ejercicio 4

Ahora debemos reescribir el driver del ejercicio anterior usando interrupciones. La tecla se conecta a la interrupción número 7 y se debe guardar la constante `BTN_INIT` en el registro de la tecla cuando se detecta una nueva pulsación.

```C
// Declaramos las variables que se van a utilizar
semaphore sem_read;
semaphore mutex;

// Vamos con el init
int driver_init() {
  // En 0 porque inicialmente nadie puede leer
  sema_init(&sem_read, 0);
  sema_init(&mutex, 1);
  request_irq(7, handler);
  return 0;
}

// Ahora hacemos el free
int driver_remove() {
  free_irq(7);
  return 0;
}

// Hacemos el handler de la interrupción
void handler() {
  (void) sig;
  sema_signal(&sem_read);
}

// Por último el read
int driver_read(void* udata) {

  // Esperamos hasta que nos habiliten leer
  sema_wait(&sem_read);

  // Una vez que nos habilitan, entramos en sección crítica
  sema_wait(&mutex);
  OUT(BTN_STATUS, BTN_INIT);
  sema_signal(&mutex);

  // Leemos y copiamos la tecla presionada
  int res = IN(BTN_PRESSED);
  copy_to_user(udata, &res, sizeof(res));

  return sizeof(int);
}
```

---

## Ejercicio 5

Tenemos que indicar las acciones que debe tomar el administrador de E/S:

- **a)** Cuando se ejecuta un `open()`, primero el administrador debe verificar que el dispositivo exista y que el usuario tenga permisos para acceder al mismo. Por otro lado, debe inicializar todas las estructuras para la comunicación de una aplicación a nivel de usuario con el dispositivo. Por último, hay que actualizar las estructuras del **SO** que indican los dispositivos abiertos.

- **b)** Cuando se efectúa un `write()`, primero hay que verificar que exista el dispositivo, que esté abierto y además que el usuario tenga permisos de escritura sobre el mismo. Luego debemos hacer un `copy_from_user()` sobre el dato que nos pasó el usuario, comunicarse con el dispositivo mediante `OUT()` y por último devolver la cantidad de bytes que se escribieron para indicar que la escritura fue exitosa.

---

## Ejercicio 6

Las operaciones `IN` y `OUT` son instrucciones privilegiadas que deben ejecutarse en modo kernel (nivel 0), ya que permiten acceder directamente a los registros de E/S. Por razones de seguridad y aislamiento, no deben estar disponibles en modo usuario, sino que su uso queda restringido a drivers dentro del sistema operativo, los cuales corren a nivel de kernel.

---

## Ejercicio 7

Tenemos 3 registros de escritura:

- **DOR_IO:** enciende (escribiendo 1) o apaga (escribiendo 0) el motor de la unidad.
- **ARM:** número de pista a seleccionar.
- **SEEK_SECTOR:** número de sector a seleccionar dentro de la pista.

Y 3 registros de lectura:

- **DOR_STATUS:** contiene 0 si el motor está apagado o 1 si está encendido. Que esté encendido no garantiza que tenga la velocidad suficiente como para realizar la operación en el disco.
- **ARM_STATUS:** contiene 0 si el brazo se está moviendo, 1 si se ubica en la pista indicada en el registro **ARM**.
- **DATA_READY:** contiene 1 cuando el dato ya fue enviado.

Además tenemos las siguientes funciones auxiliares:

- `int cantidad_sectores_por_pista()`: devuelve la cantidad de sectores por cada pista del disco. El sector 0 es el primer sector de la pista.
- `void escribir_datos(void* src)`: escribe los datos en el puntero **src** en el último sector seleccionado.
- `void sleep(int ms)`: espera durante **ms** milisegundos.

Otros datos importantes: el motor demora en encenderse completamente 50 ms y además, después de completar una operación, se debe apagar el motor. Este tarda como máximo 200 ms y en ese tiempo no pueden realizarse operaciones.

### a)

Vamos con el driver. Notemos que vamos a tener que utilizar polling, ya que no tenemos ningún registro de interrupciones, pero sí de status.

```C
// Requerimos sincronización, por lo tanto necesitamos un semáforo
semaphore mutex;

int driver_disco_init() {
  sema_init(&mutex, 1);
  return 0;
}

// Ahora la operación de escritura
int driver_disco_write(int sector, void* data) {

  // Primero debemos tener permiso para realizar la escritura
  sema_wait(&mutex);

  // Una vez que tenemos permisos, hacemos los cálculos de sector relativo y pista
  int cantidad_sectores_pista = cantidad_sectores_por_pista();
  int pista = sector / cantidad_sectores_pista;
  int sector_relativo = sector % cantidad_sectores_pista;

  if (IN(DOR_STATUS) == 0) {
    OUT(DOR_IO, 1);
    // Esperamos 50 ms a que se estabilice
    sleep(50);
  }

  // Movemos el brazo a la pista correspondiente
  OUT(ARM, pista);

  // Esperamos a que el brazo esté en la pista
  while (IN(ARM_STATUS) != 1) {
    // Busy-waiting
  }

  // Una vez en la pista, seleccionamos el sector donde escribiremos
  OUT(SEEK_SECTOR, sector_relativo);

  // Capturamos los datos a escribir
  unsigned char* info[512];
  copy_from_user(info, data, sizeof(info));

  // Escribimos los datos
  escribir_datos((void*) info);

  // Esperamos a que se complete la operación
  while (IN(DATA_READY) != 1) {
    // Busy-waiting
  }

  // Cuando termina la operación, apagamos el motor y esperamos 200 ms
  OUT(DOR_IO, 0);
  sleep(200);

  sema_signal(&mutex); // Salimos de la sección crítica
  return 0;
}
```

---

### b)

Ahora debemos modificar el driver anterior para hacerlo con interrupciones. Se debe manejar la interrupción en la **IRQ 6** cada vez que `ARM_STATUS` o `DATA_READY` tomen el valor 1. Además, el sistema ofrece un **timer** que genera una interrupción en la **IRQ 7** una vez cada 50 ms; no podemos utilizar `sleep`.

Vamos con el driver:

```C
// Variables de sincronización
semaphore mutex;
semaphore time;
semaphore arm_status;
semaphore data_ready;

// Ticks restantes para el timer
static int ticks_restantes = 0;

int driver_disco_init() {
  sema_init(&mutex, 1);
  sema_init(&time, 0);        // Bandera de tiempo de espera
  sema_init(&arm_status, 0);  // Asumimos brazo como no listo
  sema_init(&data_ready, 0);  // Asumimos dato como no listo

  // Registramos las IRQs
  request_irq(6, handler_6);
  request_irq(7, handler_7);
  return 0;
}

int driver_remove() {
  free_irq(6);
  free_irq(7);
  return 0;
}

// Handler de la IRQ 6: monitorea ARM_STATUS y DATA_READY
void handler_6() {
  (void) sig;
  if (IN(ARM_STATUS) == 1) sema_signal(&arm_status);
  if (IN(DATA_READY) == 1) sema_signal(&data_ready);
}

// Handler de la IRQ 7: un tick equivale a 50 ms
void handler_7() {
  (void) sig;
  if (ticks_restantes > 0) {
    ticks_restantes--;
    if (ticks_restantes == 0) {
      sema_signal(&time);
    }
  }
}

// Operación de escritura con interrupciones
int driver_disco_write(int sector, void* data) {

  // Esperamos nuestro turno
  sema_wait(&mutex);

  // Calculamos pista y sector relativo
  int cantidad_sectores_pista = cantidad_sectores_por_pista();
  int pista = sector / cantidad_sectores_pista;
  int sector_relativo = sector % cantidad_sectores_pista;

  if (IN(DOR_STATUS) == 0) {
    // Seteamos los ticks antes de prender el motor para evitar race condition con la IRQ 7
    ticks_restantes = 2;
    OUT(DOR_IO, 1);
    sema_wait(&time);
  }

  // Movemos el brazo a la pista correspondiente
  OUT(ARM, pista);

  // Esperamos a que el brazo esté listo
  sema_wait(&arm_status);

  // Seleccionamos el sector relativo dentro de la pista
  OUT(SEEK_SECTOR, sector_relativo);

  // Copiamos los datos del usuario y escribimos
  char buffer[512];
  copy_from_user(buffer, data, sizeof(buffer));
  escribir_datos(buffer);

  // Esperamos a que se complete la escritura
  sema_wait(&data_ready);

  // Seteamos ticks antes y esperamos a que el motor termine de apagarse (4 ticks = 200 ms)
  ticks_restantes = 4;
  OUT(DOR_IO, 0);
  sema_wait(&time);

  // Terminamos la sección crítica
  sema_signal(&mutex);
  return 0;
}
```

---

## Ejercicio 8

Queremos escribir un driver para una impresora. Para comenzar una impresión se debe hacer lo siguiente:

- Ingresar en el registro de 32 bits **LOC_TEXT_POINTER** la dirección de memoria donde empieza el buffer que contiene el string a imprimir.
- Ingresar en el registro de 32 bits **LOCK_TEXT_SIZE** la cantidad de caracteres que se deben leer del buffer.
- Colocar la constante **START** en el registro **LOC_CTRL**.

Ahora, si la impresora detecta que no hay suficiente tinta, escribirá el valor **LOW_INK** en el registro **LOC_CTRL** y el valor **READY** en el registro **LOC_STATUS**. Caso contrario, la impresora comienza la impresión, escribe **PRINTING** en **LOC_CTRL** y **BUSY** en **LOC_STATUS**; al finalizar, escribe **FINISHED** en **LOC_CTRL** y **READY** en **LOC_STATUS**.

Para asegurarnos de que la cantidad de tinta es suficiente, tenemos que verificar al menos 5 veces para tener el dato correcto.

Por último, el controlador soporta interrupciones: **HP_LOW_INK_INT**, que se lanza cuando la impresora detecta bajo nivel de tinta, y **HP_FINISHED_INT**, que se lanza al terminar una impresión.

Vamos con la escritura de `int driver_init()`, `int driver_remove()` y `int driver_write()`:

> **Aclaración:** En el ejercicio estoy asumiendo que `LOC_CTRL` se estabiliza a partir de la quinta pasada, es decir, el quinto intento es el resultado definitivo.

```C
semaphore mutex;
semaphore finish;

void handler_finish() {
  sema_signal(&finish);
}

void handler_ink() {
  // Sin acción: la verificación se hace por polling en driver_write
}

int driver_init() {
  sema_init(&mutex, 1);
  sema_init(&finish, 0);
  request_irq(HP_LOW_INK_INT, handler_ink);
  request_irq(HP_FINISHED_INT, handler_finish);
  return 0;
}

int driver_remove() {
  free_irq(HP_LOW_INK_INT);
  free_irq(HP_FINISHED_INT);
  return 0;
}

// Ahora vamos con la escritura
int driver_write(void* data, size_t size) {

  // Esperamos a que tengamos el turno
  sema_wait(&mutex);

  // Copiamos los datos del usuario al espacio del kernel
  void* dire = kmalloc(size);
  copy_from_user(dire, data, size);

  // Configuramos los registros de la impresora
  OUT(LOC_TEXT_POINTER, dire);
  OUT(LOCK_TEXT_SIZE, size);   // El tamaño se pasa por valor, vive en la función
  OUT(LOC_CTRL, START);

  // Verificamos 5 veces si hay suficiente tinta
  int ctrl;
  for (int i = 0; i < 5; i++) {
    ctrl = IN(LOC_CTRL);
  }

  if (ctrl == LOW_INK) {
    // Sin tinta: liberamos recursos y retornamos error
    kfree(dire);
    sema_signal(&mutex);
    return -1;
  } else if (ctrl == PRINTING) {
    // Impresión iniciada: esperamos que termine via interrupción
    sema_wait(&finish);
  } else {
    // Estado inesperado: liberamos recursos y retornamos error
    kfree(dire);
    sema_signal(&mutex);
    return -1;
  }

  // Impresión finalizada correctamente
  kfree(dire);
  sema_signal(&mutex);
  return size;
}
```
--

## Ejercicio 9

Vamos con los datos del ejercicio:

- Pueden estar 3 personas utilizando el teclado en simultáneo sin interrumpirse.

- El teclado cuenta con 3 visores que muestran información acerca del juego.

- Se pueden activar o desactivar teclas, y también remapear y configurar macros por cada usuario por separado. Por otro lado, tiene luces configurables.

- Cada vez que un usuario presiona una tecla se dispara la interrupción **IRQ_KEYB** y se coloca en el registro **KEYB_REG_DATA** un entero de 32 bits que contiene, en los 14 bits menos significativos, el **KEY_CODE** correspondiente a la tecla presionada y, en los 2 bits siguientes, un identificador **P**, el cual vale 0 si se recibió por una aplicación global o del 1 al 3 si corresponde a un usuario particular. Es una interrupción no bloqueante. Se le avisa al dispositivo que el dato pudo ser almacenado escribiendo el valor **READ_OK** en el registro **KEYB_REG_CONTROL**; en caso contrario, se escribe **READ_FAILED**.

- El dispositivo cuenta con 3 direcciones de memoria **INPUT_MEM_0..3**, siendo cada una un arreglo de 100 bytes desde donde se leerá el input de las aplicaciones. Estas direcciones se mapean al arreglo **input_mem** a la hora de cargar el driver.

- Cuando una app se conecta al teclado, se informa al mismo escribiendo el valor **APP_UP** en el registro **KEYB_REG_STATUS** y el id de la app en el registro **KEYB_REG_AUX**. En caso de desconexión de la app, se escribe **APP_DOWN**.

- Contamos con la función `keycode2ascii(int keycode)` para traducir los keycodes a ASCII.

- `read` debe ser bloqueante, y cada proceso debe poder consumir los caracteres de forma independiente.

Tenemos las siguientes funciones para utilizar como caja negra:

- `int get_buffer_length(int i)`: dado un número de buffer, devuelve la cantidad de caracteres ocupados en el mismo.

- `boolean write_to_buffer(int i, char src)`: intenta escribir un carácter en el buffer correspondiente y retorna un booleano indicando si la escritura se pudo realizar.

- `boolean write_to_all_buffers(char src)`: intenta escribir un carácter en todos los buffers y retorna un booleano indicando si la escritura se pudo realizar.

- `void copy_from_buffer(int i, char* dst, int size)`: lee la cantidad de caracteres indicada desde el buffer correspondiente y los copia en un segundo buffer pasado como parámetro. Tener en cuenta que esta función no realiza ningún tipo de chequeo sobre los buffers, sino que simplemente copia.

Contamos con el siguiente código:

```C
char input_mem[3][100];
char buffer_lectura[3][1000];
atomic_int buffer_start[3];
atomic_int buffer_end[3];
bool procesos_activos[3];

// Sincronizacion entre procesos
semaphore sem_open;
semaphore sem_bytes[3];
semaphore sem_read_mutex[3];

// Para obtener el keycode de los 14 bits menos significativos
#define KEYCODE(x) ((x) & 0x3FFF)
// Para obtener los P
#define GET_P(x) (((x) >> 14) & 0x03)

void handler_keyboard() {
  // Extrae el ID y el codigo con mascaras de bits

  int data = IN(KEYB_REG_DATA);

  int keycode = KEYCODE(data);
  int p = GET_P(data);

  char c = keycode2ascii(keycode);

  bool ok = false;

  // Segun el p es el destinatario
  if (p == 0) {
    // Broadcast a todos los buffers
    ok = write_to_all_buffers(c);
    if (ok) {
      for(int i = 0; i < 3; i++) {
        if (procesos_activos[i]) {
          sema_signal(&sem_bytes[i]);
        }
      }
    }
  } else if (p >= 1 && p <= 3) {
    int idx = p - 1; // P va de 1 a 3 -> buffers e indices van de 0 a 2
    if (procesos_activos[idx]) {
      ok = write_to_buffer(idx, c);
      if (ok) {
        sema_signal(&sem_bytes[idx]);
      }
    }
  }

  // Notificamos al dispositivo el resultado de la operacion
  if (ok) {
    OUT(KEYB_REG_CONTROL, READ_OK);
  } else {
    OUT(KEYB_REG_CONTROL, READ_FAILED);
  }
}

void driver_load() {
  // Se corre al cargar el driver al kernel.
  // Primero vamos con el mapeo de la irq
  request_irq(IRQ_KEYB, handler_keyboard);
  // Ahora mapeamos INPUT_MEM1..3 a input_mem
  mem_map(INPUT_MEM_0, input_mem[0], 100);
  mem_map(INPUT_MEM_1, input_mem[1], 100);
  mem_map(INPUT_MEM_2, input_mem[2], 100);

  // Inicializacion del semaforo open
  sema_init(&sem_open, 1);

  // Inicializacion de los procesos y estructuras de sincronizacion
  for (int i = 0; i < 3; i++) {
    procesos_activos[i] = false;
    sema_init(&sem_bytes[i], 0);
    sema_init(&sem_read_mutex[i], 1);
    
    // Ponemos los indices de los buffers circulares en o
    buffer_start[i] = 0;
    buffer_end[i] = 0;
  }
}

void driver_unload() {
  // Se corre al eliminar el driver del kernel.
  // Primero liberamos la IRQ
  free_irq(IRQ_KEYB);
  //Ahora desmapeamos la memoria de input_mem
  mem_unmap(INPUT_MEM_0);
  mem_unmap(INPUT_MEM_1);
  mem_unmap(INPUT_MEM_2);
}

int driver_open() {
  // Debe conectar un proceso, asignandole un ID y retornandolo,
  // o retornando -1 en caso de falla.
  sema_wait(&sem_open);
  int id = -1;
  for(int i = 0; i < 3; i++) {
    if (!procesos_activos[i]) {
      procesos_activos[i] = true;
      id = i;
      break;
    }
  }

  if (id != -1) {
    // Notificamos al dispositivo: ID y leugo el estado APP_UP
    OUT(KEYB_REG_AUX, id + 1);
    OUT(KEYB_REG_STATUS, APP_UP);
  }

  sema_signal(&sem_open);
  return id;
}

void driver_close(int id) {
  // Debe desconectar un proceso dado por parametro.
  if (id < 0 || id >= 3) return;
  
  sema_wait(&sem_open);

  if (procesos_activos[id]) {
    procesos_activos[id] = false;

    // Notificamos al dispositivo la desconexion
    OUT(KEYB_REG_AUX, id + 1);
    OUT(KEYB_REG_STATUS, APP_DOWN);
  }
  
  sema_signal(&sem_open);
}

int driver_read(int id, char* buffer, int length) {
  // Debe leer los bytes solicitados por el proceso ’’id’’
  if (id < 0 || id >= 3 || !procesos_activos[id] || length <= 0) {
    return -1;
  }

  // Mutex por buffer para serializar lecturas concurrentes al mismo id
  sema_wait(&sem_read_mutex[id]);

  for (int i = 0; i < length; i++) {
    sema_wait(&sem_bytes[id]);
  }

  // Buffer intermedio en kernel para extraer desde la caja negra
  char* kbuf = (char*) kmalloc(length);
  copy_from_buffer(id, kbuf, length);
  copy_to_user(buffer, kbuf, length);
  kfree(kbuf);

  sema_signal(&sem_read_mutex[id]);

  return length;
}

int driver_write(char* input, int size, int proceso) {

copy_from_user(input_mem[proceso], input, size);
return size;

}
```