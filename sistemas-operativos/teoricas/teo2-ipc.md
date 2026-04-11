# Comunicación entre Procesos (IPC)

**Sistemas Operativos — FCEyN, Universidad de Buenos Aires**

---

## 1. ¿Qué es IPC?

**IPC** (InterProcess Communication) es el conjunto de mecanismos que permite a los procesos comunicarse entre sí, ya sea en el mismo equipo o entre equipos conectados en red.

### ¿Para qué sirve?

- **Compartir información:** múltiples procesos acceden o intercambian datos
- **Mejorar la velocidad de procesamiento:** dividir trabajo en subprocesos paralelos
- **Modularizar:** separar responsabilidades en procesos independientes (como hace Chrome)

---

## 2. Motivación: Chrome como ejemplo

Antes, los browsers corrían como **un solo proceso**. Si un sitio web tenía un problema (bug, loop infinito, exploit), todo el browser se colgaba.

**Chrome resolvió esto con arquitectura multiproceso:**

| Tipo de proceso | Responsabilidad |
|-----------------|-----------------|
| **Browser** | Administra la interfaz de usuario, acceso a disco y red |
| **Renderer** | Muestra páginas web, ejecuta HTML y JavaScript. Uno nuevo por sitio. Corre en sandbox |
| **Plug-in** | Un proceso separado por cada tipo de plugin |

Cada pestaña es un proceso separado. Si una pestaña se cuelga, el resto del browser sigue funcionando.

---

## 3. Formas de IPC

Las tres formas principales de IPC son:

```
   a. Memoria compartida              b. Pasaje de mensajes

   ┌──────────────┐                  ┌──────────────┐
   │  Proceso A   │                  │  Proceso A   │
   ├──────────────┤                  │  Proceso B   │
   │shared memory │                  ├──────────────┤
   ├──────────────┤                  │ message queue│
   │  Proceso B   │                  │m0│m1│m2│...  │
   ├──────────────┤                  ├──────────────┤
   │    kernel    │                  │    kernel    │
   └──────────────┘                  └──────────────┘
```

### Comparación

| Característica | Memoria compartida | Pasaje de mensajes |
|----------------|-------------------|-------------------|
| **Velocidad** | Muy rápida (acceso directo) | Más lento (interviene el kernel) |
| **Sincronización** | Manual (semáforos, mutexes) | Implícita en el canal |
| **Complejidad** | Mayor (evitar condiciones de carrera) | Menor |
| **Uso típico** | Gran volumen de datos, mismo equipo | Mensajes discretos, red |

---

## 4. File Descriptors

Antes de entender los pipes, es fundamental comprender los **file descriptors**.

### 4.1 ¿Qué son?

- **Intuitivamente:** representan instancias de archivos abiertos
- **Concretamente:** son índices en una tabla que indica los archivos abiertos por el proceso

Cada proceso en UNIX tiene su **propia tabla de file descriptors** (almacenada en su PCB) al momento de ser creado.

```
File Descriptor Table:
┌───┬───────────────────┐
│ 0 │ ──────────────────────> teclado (stdin)
├───┤
│ 1 │ ──────────────────────> pantalla (stdout)
├───┤
│ 2 │ ──────────────────────> pantalla (stderr)
├───┤
│ 3 │ ──────────────────────> /path/to/file
├───┤
│ 4 │ ──────────────────────> /path/to/file2
└───┘
```

### 4.2 Los tres file descriptors estándar

La mayoría de los procesos esperan tener abiertos 3 file descriptors al inicio:

| FD | Nombre | Destino típico |
|----|--------|----------------|
| **0** | stdin (standard input) | Teclado |
| **1** | stdout (standard output) | Pantalla |
| **2** | stderr (standard error) | Pantalla |

> **Importante:** En Unix, **el teclado y la pantalla se modelan como archivos**. Todo es un archivo.

### 4.3 Herencia de file descriptors

Los file descriptors se **heredan** de padre a hijo al usar `fork()`, y se mantienen en la llamada a `execve()`. Esto es fundamental para el funcionamiento de los pipes.

### 4.4 La Global File Table

El kernel mantiene una **Global File Table** que registra:
- Modo de apertura (read-only, write-only, read-write)
- Offset actual de lectura/escritura
- Contador de referencias (`ref_count`)

Cuando dos file descriptors (de cualquier proceso) apuntan al mismo archivo, comparten el offset.

```
FD Table (proceso)    Global File Table    Inode Table
┌───┐                ┌──────────────────┐  ┌──────────────┐
│ 0 │ ──────────────>│read-only; off:0  │──>│  /dev/tty    │
│   │                │ref_count = 1     │  │              │
├───┤                ├──────────────────┤  ├──────────────┤
│ 1 │ ──────────────>│write-only; off:0 │──>│  /dev/tty    │
│ 2 │ ──────────────>│ref_count = 2     │  │              │
├───┤                ├──────────────────┤  ├──────────────┤
│ 3 │ ──────────────>│read-only; off:20 │──>│/path/to/file │
└───┘                │ref_count = 1     │  └──────────────┘
                     └──────────────────┘
```

---

## 5. Lectura y Escritura en File Descriptors

```c
ssize_t read(int fd, void *buf, size_t count);
ssize_t write(int fd, const void *buf, size_t count);
```

| Parámetro | Descripción |
|-----------|-------------|
| `fd` | File descriptor |
| `buf` | Puntero al buffer de datos |
| `count` | Cantidad máxima de bytes a leer/escribir |
| **Retorno** | Bytes leídos/escritos, -1 en caso de error |

> El comportamiento de `read()` y `write()` **depende del tipo de file descriptor**. Para un archivo regular, es determinístico. Para un pipe o socket, puede bloquearse.

---

## 6. Redirección con dup2

### 6.1 ¿Cómo funciona `>`?

Cuando escribimos en bash:
```bash
echo "Hola mundo" > archivo.txt
```

La consola:
1. Abre `archivo.txt` → obtiene fd = 3
2. Llama a `dup2(3, 1)` → hace que fd=1 (stdout) apunte al mismo archivo que fd=3
3. Ahora cuando `echo` escribe en stdout (fd=1), escribe en el archivo

### 6.2 La función dup2

```c
int dup2(int oldfd, int newfd);
```

**Efecto:** pisa en `newfd` el contenido que está en `oldfd`.

```
ANTES de dup2(3, 1):          DESPUÉS de dup2(3, 1):
┌───┐                         ┌───┐
│ 0 │──> teclado              │ 0 │──> teclado
│ 1 │──> pantalla     →→→     │ 1 │──> archivo.txt  ← cambió!
│ 2 │──> pantalla             │ 2 │──> pantalla
│ 3 │──> archivo.txt          │ 3 │──> archivo.txt
└───┘                         └───┘
```

---

## 7. Pipes

### 7.1 ¿Qué es un pipe?

Un pipe es un "pseudo archivo" que **esconde** una forma de IPC. Es:
- Un **archivo temporal y anónimo** que vive en memoria (no en disco)
- Actúa como un **buffer** para leer y escribir de manera secuencial
- Un **byte stream**: no hay separación por mensajes, es una secuencia continua de bytes

### 7.2 Tipos de pipes

**Ordinary pipes (anónimos):**
```bash
ls -l | grep ".so"   # el stdout de ls se conecta al stdin de grep
```

**Named pipes (FIFO):**
```bash
mkfifo -m 0640 /tmp/mi_tuberia   # crea un archivo especial en el filesystem
```

Los named pipes persisten en el sistema de archivos y pueden ser usados por procesos sin relación padre-hijo.

### 7.3 Creación de un pipe

```c
int pipe(int pipefd[2]);
```

Después de ejecutar `pipe()`:
- `pipefd[0]` → file descriptor para **leer** del pipe
- `pipefd[1]` → file descriptor para **escribir** al pipe

```
pipefd[1]          BUFFER EN MEMORIA          pipefd[0]
  write ──────────────────────────────────────> read
        → [byte][byte][byte]...[byte][byte] →
```

### 7.4 Pipe + fork: comunicación entre padre e hijo

```c
int pipefd[2];
pipe(pipefd);   // crear el pipe ANTES del fork

pid_t pid = fork();

if (pid == 0) {
    // HIJO: va a leer
    close(pipefd[1]);          // cerrar extremo de escritura (no lo usamos)
    char buf[100];
    read(pipefd[0], buf, 100); // leer del pipe
    printf("Hijo recibió: %s\n", buf);
    close(pipefd[0]);
} else {
    // PADRE: va a escribir
    close(pipefd[0]);               // cerrar extremo de lectura (no lo usamos)
    write(pipefd[1], "Hola!", 5);   // escribir en el pipe
    close(pipefd[1]);
    wait(NULL);
}
```

**¿Por qué cerrar los extremos que no usamos?**
- Si el lector no cierra el extremo de escritura, `read()` nunca retorna EOF
- Si el escritor no cierra el extremo de lectura, hay recursos desperdiciados

### 7.5 Pipe en la tabla de file descriptors

Cuando se crea un pipe y luego se hace fork:

```
PADRE:                           HIJO:
┌───┐                           ┌───┐
│ 0 │──> teclado                │ 0 │──> teclado
│ 1 │──> pantalla               │ 1 │──> pantalla
│ 2 │──> pantalla               │ 2 │──> pantalla
│ 3 │──> pipe[IN]  ←── PIPE ──> │ 3 │──> pipe[IN]
│ 4 │──> pipe[OUT] ←──     ──>  │ 4 │──> pipe[OUT]
└───┘                           └───┘
```

Los file descriptors del padre se **copian** al hijo y apuntan a los mismos extremos del pipe.

### 7.6 Implementación de `ls -l | grep ".so"` en C

```c
int pipefd[2];
pipe(pipefd);

if (fork() == 0) {
    // HIJO ejecuta "ls -l"
    close(pipefd[0]);           // no lee
    dup2(pipefd[1], 1);         // stdout → extremo de escritura del pipe
    close(pipefd[1]);
    execlp("ls", "ls", "-l", NULL);
} else {
    // PADRE ejecuta "grep .so"
    close(pipefd[1]);           // no escribe
    dup2(pipefd[0], 0);         // stdin → extremo de lectura del pipe
    close(pipefd[0]);
    execlp("grep", "grep", ".so", NULL);
}
```

**Diagrama del flujo:**
```
echo      OUT──> 4 ──> pipe buffer ──> 3 ──> IN   wc
process                                           process
```

---

## 8. Sockets

### 8.1 ¿Qué es un socket?

Un socket es una interfaz de comunicación entre procesos que permite el intercambio de datos. Extiende el concepto de pipe a la comunicación en red.

### 8.2 Tipos de sockets en Unix

**Sockets Unix (AF_UNIX / AF_LOCAL):**
- Comunicación rápida y eficiente **dentro del mismo sistema**
- Usan archivos en el filesystem como puntos de conexión
- No requieren configuración de red
- Menor latencia

**Sockets de red (AF_INET, AF_INET6):**
- Usan **direcciones IP y puertos**
- Permiten comunicación entre **diferentes máquinas**
- Mayor latencia y overhead por protocolos de red (TCP/IP)

Se proveen syscalls homogéneas para manejarlos, independientemente del tipo.

### 8.3 Creación de un socket

```c
int socket(int domain, int type, int protocol);
```

| Parámetro | Valores comunes |
|-----------|----------------|
| `domain` | `AF_UNIX` (local), `AF_INET` (IPv4), `AF_INET6` (IPv6) |
| `type` | `SOCK_STREAM` (TCP, orientado a conexión), `SOCK_DGRAM` (UDP, sin conexión) |
| `protocol` | Generalmente 0 (automático) |

### 8.4 Flujo de un servidor TCP

```
SERVIDOR                          CLIENTE
   |                                 |
socket()                          socket()
   |                                 |
bind()                               |
   |                                 |
listen()                             |
   |                              connect() ─────────────────────>
accept() <─────────────────────────────────────────────────────── |
   |                                 |
read()/write() <──────────────────> read()/write()
   |                                 |
close()                           close()
```

### 8.5 Ejemplo: servidor TCP simple en C

```c
// Servidor
int server_fd = socket(AF_INET, SOCK_STREAM, 0);

struct sockaddr_in addr = {
    .sin_family = AF_INET,
    .sin_port = htons(8080),
    .sin_addr.s_addr = INADDR_ANY
};

bind(server_fd, (struct sockaddr*)&addr, sizeof(addr));
listen(server_fd, 5);

int client_fd = accept(server_fd, NULL, NULL);
char buf[256];
read(client_fd, buf, sizeof(buf));
write(client_fd, "Pong", 4);
close(client_fd);
close(server_fd);
```

```c
// Cliente
int sock_fd = socket(AF_INET, SOCK_STREAM, 0);

struct sockaddr_in server_addr = {
    .sin_family = AF_INET,
    .sin_port = htons(8080),
};
inet_pton(AF_INET, "127.0.0.1", &server_addr.sin_addr);

connect(sock_fd, (struct sockaddr*)&server_addr, sizeof(server_addr));
write(sock_fd, "Ping", 4);
char buf[256];
read(sock_fd, buf, sizeof(buf));
close(sock_fd);
```

---

## 9. Memoria Compartida

La memoria compartida permite que dos o más procesos accedan a la **misma región de memoria** directamente.

### 9.1 API POSIX de memoria compartida

```c
// Crear/abrir región de memoria compartida
int fd = shm_open("/mi_shm", O_CREAT | O_RDWR, 0666);

// Establecer tamaño
ftruncate(fd, sizeof(int));

// Mapear en el espacio de direcciones del proceso
int *ptr = mmap(NULL, sizeof(int), PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);

// Usar la memoria
*ptr = 42;  // escribe
printf("%d\n", *ptr);  // lee

// Limpiar
munmap(ptr, sizeof(int));
close(fd);
shm_unlink("/mi_shm");  // eliminar la región
```

### 9.2 Problema: condición de carrera

Con memoria compartida, **dos procesos pueden modificar datos simultáneamente**, causando resultados indefinidos. Se necesitan mecanismos de sincronización (semáforos, mutexes).

```
Proceso A:           Proceso B:
lee valor = 5        lee valor = 5
suma 1               suma 1
escribe 6            escribe 6
                     
¡El resultado debería ser 7, pero es 6!
```

---

## 10. Comparación de Mecanismos IPC

| Mecanismo | Velocidad | Distancia | Persistencia | Sincronización |
|-----------|-----------|-----------|--------------|----------------|
| **Pipe anónimo** | Alta | Mismo equipo | No (en memoria) | Implícita |
| **Named pipe (FIFO)** | Alta | Mismo equipo | Sí (en filesystem) | Implícita |
| **Memoria compartida** | Muy alta | Mismo equipo | Configurable | Manual |
| **Socket Unix** | Alta | Mismo equipo | No | Manual |
| **Socket TCP/IP** | Media | Red | No | Manual |
| **Archivo/base de datos** | Baja | Red (con NFS) | Sí | Manual |

---

## 11. El Modelado de Unix: Todo es un Archivo

Una de las ideas más elegantes de Unix es que **todo se modela como un archivo**:

- El teclado → `/dev/stdin` (fd=0)
- La pantalla → `/dev/stdout` (fd=1)
- Un disco → `/dev/sda`
- Un pipe → fd en la tabla de descriptores
- Un socket → fd en la tabla de descriptores
- Una impresora → `/dev/lp0`

Esto permite que las mismas syscalls (`read()`, `write()`, `close()`) funcionen para todos los recursos, logrando una API uniforme y composable.

---

## Resumen

| Concepto | Clave |
|----------|-------|
| **IPC** | Mecanismo para que procesos se comuniquen |
| **File descriptor** | Índice en la tabla de archivos abiertos del proceso |
| **stdin/stdout/stderr** | FD 0, 1 y 2 por convención |
| **dup2(old, new)** | Hace que `new` apunte al mismo archivo que `old` |
| **pipe()** | Crea un canal de comunicación unidireccional en memoria |
| **Pipe anónimo** | Requiere relación padre-hijo (creado antes del fork) |
| **Named pipe** | Archivo especial en filesystem, sin relación requerida |
| **Socket** | Endpoint de comunicación, local o en red |
| **Memoria compartida** | Región de memoria accesible por múltiples procesos |
