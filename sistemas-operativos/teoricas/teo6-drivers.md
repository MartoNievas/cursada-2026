# Entrada/Salida - Drivers

## Drivers y Controllers

Dos definiciones importantes:

- **Drivers:** Módulos de software que pueden ser añadidos al **SO** para manejar los dispositivos de E/S.
- **Controllers:** Componente mecánico y/o electrónico que trabaja como una interfaz entre un dispositivo y el driver.

A continuación, una representación gráfica de cómo se conectan ambas capas y cómo se comunican:

<p align="center">
  <img src="https://github.com/user-attachments/assets/6e06ec3d-bbfe-4155-ab0c-ff0970a9e607" alt="Representación de comunicación entre Controllers y Drivers">
</p>

---

## E/S Asíncrona vs. Síncrona

La entrada/salida de un **SO** puede funcionar de dos maneras:

- **Síncrona:** La ejecución de la **CPU** que solicita la E/S espera a que esta se complete.
- **Asíncrona:** Cada E/S procede concurrentemente con la ejecución de la **CPU** que la solicita.

### E/S Síncrona

El proceso solicita una operación de E/S y se **bloquea**: el control no vuelve al programa del usuario hasta que la E/S se completa totalmente.

- **Flujo:** El proceso realiza una llamada al sistema → el kernel pone el proceso en estado de espera (*waiting*) → el dispositivo realiza la tarea → una interrupción despierta al proceso.
- **Ventaja:** Muy sencillo de programar, ya que el código sigue un orden lineal y predecible.
- **Desventaja:** La **CPU** "pierde" tiempo que podría usar en otras tareas, ya que queda bloqueada esperando al hardware.

### E/S Asíncrona

El proceso solicita la E/S y **continúa su ejecución inmediatamente**, sin esperar a que los datos estén listos.

- **Flujo:** El proceso inicia la syscall → el kernel le devuelve el control casi al instante → el proceso sigue haciendo otros cálculos → cuando la E/S termina, el SO le avisa al proceso (o el proceso consulta periódicamente mediante *polling*).
- **Ventaja:** Máxima eficiencia. Se pueden procesar datos, actualizar una interfaz o atender otras conexiones mientras el disco lee un archivo pesado.
- **Desventaja:** Mucho más complejo de implementar. Se deben gestionar estados y saber exactamente cuándo los datos están disponibles para no intentar usarlos antes de tiempo.

---

## Polling vs. Interrupciones

Estas dos técnicas son las vías principales para detectar la llegada de cualquier tipo de entrada desde el hardware. Ambas permiten a la **CPU** atender eventos que suceden en cualquier momento, sin estar necesariamente relacionados con los procesos en ejecución.

### 1. Polling (Espera Activa)

Es el método más simple de implementar; la jerarquía de control recae totalmente en el procesador.

- **Mecánica:** Consiste en una revisión periódica del estado del dispositivo. La CPU ejecuta un bucle para leer un registro de estado específico en el controlador de E/S.
- **Implementación:** Utiliza un registro de estado para determinar si el periférico tiene datos listos o si ha finalizado una tarea.
- **Carga de CPU:** Al ser una "espera activa", el procesador desperdicia ciclos de reloj preguntando constantemente si el dispositivo está listo, lo que puede ser ineficiente si el hardware es lento.

### 2. Interrupciones (Manejo por Eventos)

El flujo de trabajo es inverso: el dispositivo es quien notifica a la CPU cuando ocurre un evento relevante.

- **Mecánica:** El controller envía la señal de finalización o notifica cuando necesita atención de la **CPU**. Esto permite que la CPU realice otras tareas mientras el hardware trabaja en segundo plano.
- **Implementación:** El SO utiliza **handlers** o rutinas de software específicas (ISR - *Interrupt Service Routines*) para manejar cada tipo de interrupción de forma aislada.
- **Eficiencia:** Es el mecanismo base para la multitarea moderna, ya que libera al procesador de la vigilancia constante del hardware, permitiendo una mejor gestión de los recursos del sistema.

---

| Característica   | Polling                      | Interrupciones                          |
| :--------------- | :--------------------------- | :-------------------------------------- |
| **Iniciativa**   | CPU (Software)               | Dispositivo (Hardware)                  |
| **Eficiencia**   | Baja (desperdicia ciclos)    | Alta (uso bajo demanda)                 |
| **Complejidad**  | Baja                         | Alta (requiere soporte de hardware/kernel) |

---

## Software para E/S

El software de E/S se organiza en capas para abstraer la complejidad del hardware al usuario. Algunos ejemplos clave:

- **Bibliotecas a nivel de usuario:** Interfaces de alto nivel como **stdio** en C/C++. Ofrecen funciones como `printf()` o `scanf()`, que permiten realizar operaciones de E/S sin conocer los detalles físicos del dispositivo.
- **Módulos a nivel del Kernel (Drivers):** El núcleo del software de E/S. Residen en el espacio del kernel y son los únicos capaces de comunicarse directamente con los controladores de hardware mediante registros e interrupciones.
- **Hardware (Firmware):** El software de nivel más bajo, generalmente embebido en el dispositivo. Gestiona las operaciones internas del hardware y expone una interfaz (registros) que el driver puede manipular.

---

## Drivers

Los **drivers** (o manejadores de dispositivos) son piezas críticas de software diseñadas para un hardware específico. Su función principal es actuar como traductor entre el sistema operativo y el controlador del dispositivo.

### Funciones Principales

- **Interacción con los Controllers:** Aceptan solicitudes genéricas de lectura o escritura enviadas por el SO o el usuario, y las traducen en comandos específicos que el controlador del hardware puede entender.
- **Abstracción de Dispositivos:** Permiten que el SO trate distintos tipos de hardware (como diferentes marcas de discos rígidos) de manera uniforme.
- **Manejo de Errores:** Detectan y gestionan errores durante la comunicación, como fallos en la lectura de un bloque o tiempos de espera agotados (*timeouts*).
- **Control de Estado:** Se aseguran de que las solicitudes se ejecuten exitosamente, gestionando el estado del dispositivo (ocupado, listo o en error) y reportando el resultado al proceso que realizó la petición.

---

| Capa de Software    | Responsabilidad Principal                                       |
| :------------------ | :-------------------------------------------------------------- |
| **Usuario**         | Realizar llamadas al sistema y formatear datos (E/S independiente). |
| **Kernel (Driver)** | Gestionar el hardware específico y manejar interrupciones.      |
| **Hardware**        | Ejecutar físicamente la operación de E/S.                       |

---

## Handlers de Interrupciones

Este tema fue visto en la materia anterior **AyOC** (de hecho, en el TP hay que configurar la ISR). Los handlers de interrupciones se conocen como rutinas de servicio de interrupciones o **ISR**. Se las denomina *callback functions*, se alojan en el driver y se ordenan numéricamente para ser vectorizadas.

---

## Software a Nivel de Usuario

El software en este nivel tiene una interfaz simple: consiste en procedimientos/funciones alojadas en bibliotecas que residen en el espacio del usuario.

---

## Subsistema de E/S del Kernel

El kernel cuenta con el siguiente subsistema de E/S:

- **Scheduling**
- **Buffering**
- **Caching**
- **Spooling:** Un *spool* es un buffer que mantiene los datos enviados a un dispositivo que no acepta envíos intercalados, sino solo solicitudes completas. Es decir, si alguien está esperando un dato, no se puede hacer otra solicitud hasta que se complete esa entrega. Se usa típicamente para el servicio de impresión: mantiene una cola de archivos enviados que se atienden de a uno a la vez.
- **Manejo de errores**

---

## La API de un Driver

Dos preguntas importantes:

1. ¿Cuándo el código de usuario necesita hacer uso del driver del dispositivo?
2. ¿Qué funciones debería proveer el driver que programemos?

Para responder la segunda pregunta, la API del driver debería proveer los siguientes procedimientos para ser cargado por el sistema operativo:

| Función                    | Invocación                              |
| :------------------------- | :-------------------------------------- |
| `int driver_init()`        | Durante la carga del **SO**             |
| `int driver_open()`        | Al solicitar un `open`                  |
| `int driver_close()`       | Al solicitar un `close`                 |
| `int driver_read(int *data)`  | Al solicitar un `read`               |
| `int driver_write(int *data)` | Al solicitar un `write`              |
| `int driver_remove()`      | Durante la descarga del **SO**          |

Por otro lado, el Kernel debe implementar una serie de procedimientos para los drivers:

| Función                                | Descripción                                                                 |
| :------------------------------------- | :-------------------------------------------------------------------------- |
| `void OUT(int IO_address, int data)`   | Escribe `data` en el registro de E/S                                        |
| `int IN(int IO_address)`              | Devuelve el valor almacenado en el registro de E/S                          |
| `int request_irq(int irq, void* handler)` | Asocia el procedimiento `handler` a la interrupción IRQ. Devuelve `IRQ_ERROR` si ya está asociado a otro handler |
| `int irq_free(int irq)`               | Libera la interrupción IRQ del procedimiento asociado                       |

---

### Implementación con Polling

Una primera implementación de `driver_write` usando polling podría verse así:

```c
int driver_write(void* data) {
    OUT(LOC_TARGET, *data);
    OUT(LOC_CTRL, START);

    // Esperamos hasta que el dispositivo esté ocupado y luego listo
    while (IN(LOC_STATUS) != BUSY) {}
    while (IN(LOC_STATUS) != READY) {}

    // Leemos el resultado
    int res = IN(LOC_CTRL);

    if (res == JOYA) {
        return 1;
    } else if (res == BAJON) {
        return 0;
    }
    return -1;
}
```

Sin embargo, este código tiene dos problemas: no es seguro con los punteros que pasa el usuario y no contempla la concurrencia. La versión corregida:

```c
int driver_write(void* data) {
    // Copio los datos que me pasa el usuario de forma segura
    int codigo;
    copy_from_user(&codigo, data, sizeof(int));

    // Sección crítica
    mutex.lock();

    OUT(LOC_TARGET, codigo);
    OUT(LOC_CTRL, START);

    while (IN(LOC_STATUS) != BUSY) {}
    while (IN(LOC_STATUS) != READY) {}

    int resultado = IN(LOC_CTRL);
    mutex.unlock(); // Fin sección crítica

    if (resultado == JOYA) {
        return 1;
    } else if (resultado == BAJON) {
        return 0;
    } else {
        return -1;
    }
}
```

### Implementación con Interrupciones

También podemos implementar el driver usando interrupciones. La ventaja es que el procesador no queda ocioso y es el dispositivo quien avisa cuando está listo; la desventaja es que requiere más código:

```c
mutex acceso;
semaforo listo;
bool esperando;

int driver_init() {
    acceso = mutex_create();
    listo = semaforo_create(0);
    esperando = false;
    request_irq(CHINBOT_INT, handler);
}

void handler(int sig) {
    (void) sig;
    if (esperando && IN(LOC_STATUS) == READY) {
        // Si está esperando y el dispositivo está listo, salimos del estado de espera
        esperando = false;
        listo.signal(); // Señalamos que el driver puede utilizarse
    }
}

int driver_write(void* data) {
    int codigo;
    copy_from_user(&codigo, data, sizeof(int));

    // Bloqueamos el acceso al resto de procesos
    acceso.lock();

    OUT(LOC_TARGET, codigo);
    OUT(LOC_CTRL, START);

    // Esperamos a que el dispositivo esté listo (sin hacer polling)
    esperando = true;
    listo.wait();

    // Una vez listo, leemos el resultado
    int resultado = IN(LOC_CTRL);
    acceso.unlock(); // Fin sección crítica

    if (resultado == JOYA) {
        return 1;
    } else if (resultado == BAJON) {
        return 0;
    }
    return -1;
}
```

---

## Cosas a Tener en Cuenta

- **Contexto de proceso:** Un driver siempre corre dentro del contexto de un proceso, lo que significa que puede acceder a sus datos. Hay que tener extremo cuidado con los punteros que pasa el usuario.
- **Concurrencia:** Muchos procesos pueden querer utilizar el driver al mismo tiempo, por lo que se debe serializar su utilización para evitar *race conditions*.
- **Inicialización:** Las primitivas de sincronización y las estructuras que requiere el driver se inicializan cuando se carga en el kernel con `driver_init()`.
- **Sin bibliotecas externas:** El driver no se linkea contra bibliotecas, por lo que solo puede usar funciones que sean parte del kernel.
