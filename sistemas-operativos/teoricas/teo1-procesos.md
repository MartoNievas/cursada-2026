# Procesos y API del Sistema Operativo

**Sistemas Operativos — FCEyN, Universidad de Buenos Aires**

---

## 1. ¿Qué es un Proceso?

Un **programa** es una secuencia de pasos escrita en algún lenguaje (C, Python, ensamblador, etc.). Ese programa eventualmente se compila en **código objeto**, que es un programa escrito en lenguaje de máquina.

Cuando ese programa se pone a ejecutar en la CPU, lo que tenemos es un **proceso**.

> **Definición clave:** Un proceso es un programa en ejecución.

A cada proceso se le asigna un identificador numérico único llamado **PID** (Process ID).

### 1.1 Componentes de un Proceso en Memoria

Visto desde la memoria, un proceso está compuesto por:

| Región | Descripción |
|--------|-------------|
| **Área de texto** | El código de máquina del programa (instrucciones) |
| **Área de datos / Heap** | Memoria dinámica asignada en tiempo de ejecución (`malloc`, `new`) |
| **Stack** | Variables locales, parámetros de funciones, direcciones de retorno |

> Las variables locales se almacenan en el **stack**. El stack crece hacia abajo en la mayoría de las arquitecturas.

### 1.2 ¿Qué puede hacer un proceso?

- **Terminar** (`exit()`)
- **Lanzar procesos hijos** (`system()`, `fork()`, `exec()`)
- **Ejecutar en la CPU** (operaciones entre registros y memoria)
- **Hacer system calls** (llamadas al kernel)
- **Realizar E/S** (entrada/salida a dispositivos)

---

## 2. Árbol de Procesos

Todos los procesos están organizados **jerárquicamente**, como un árbol. Cuando el SO inicia, lanza un proceso raíz llamado **`init`** o **`systemd`** (PID = 1).

### 2.1 fork() y exec()

`fork()` es una llamada al sistema que crea un proceso **exactamente igual** al actual (copia completa del padre). Retorna:
- **0** en el proceso hijo
- **El PID del hijo** en el proceso padre
- **-1** en caso de error

`exec()` reemplaza el código binario del proceso actual por otro programa, sin crear un nuevo proceso.

**Cuando lanzamos un programa desde el shell:**
1. El shell hace un `fork()`
2. El hijo hace un `exec()` con el programa deseado
3. El padre puede llamar a `wait()` para suspenderse hasta que el hijo termine

```
         fork()
           |
    ┌──────┴──────┐
  padre          hijo
    |              |
  wait()        exec()
    |              |
  resumes       exit()
```

### 2.2 Ejemplo: pstree

```
-+= 00001 root /sbin/launchd
 \-+= 00708 user /Applications/.../Terminal
    \-+= 00711 root login -pf user
       \-+= 00712 user -bash
          \-+= 00789 user pstree -u user
             \--- 00790 root ps -axwwo user,pid,ppid,...
```

Cada proceso tiene un **padre** (PPID — Parent PID).

---

## 3. Actividades de un Proceso

### 3.1 Terminación

Cuando un proceso llama a `exit(status)`:
- Indica al SO que puede liberar todos sus recursos
- Reporta el **código de status** (número) al proceso padre
- El padre lo recibe mediante `wait()` o `waitpid()`

Por convención:
- `exit(0)` → terminación exitosa
- `exit(distinto de 0)` → algún error ocurrió

### 3.2 Ejecutar en la CPU: el Quantum

Solo **un proceso a la vez** puede estar en la CPU (en sistemas con un único núcleo). La pregunta es: ¿por cuánto tiempo?

Opciones:
- **Hasta que termina:** Ideal para el proceso, pero bloquea al resto. Además, podría no terminar nunca.
- **Un "ratito" llamado quantum:** Los SO modernos usan esto.

Los SO modernos implementan **preemption** (desalojo): cuando se acaba el quantum, le toca el turno al siguiente proceso. Esto se implementa colgándose de la **interrupción del clock** del hardware.

### 3.3 Context Switch (Cambio de Contexto)

Para cambiar de proceso en la CPU, el SO debe:

1. Guardar los registros del proceso actual
2. Guardar el IP (Instruction Pointer / Program Counter)
3. Cargar los registros del nuevo proceso
4. Poner el valor del IP del nuevo proceso

> El estado de cada proceso se guarda en una estructura llamada **PCB (Process Control Block)**.

**El tiempo de context switch es tiempo muerto** — el sistema no está haciendo trabajo productivo. Esto tiene dos consecuencias importantes:

1. **Impacto en hardware:** motivó el diseño de procesadores RISC (pocos registros, cambio de contexto más rápido).
2. **Quantum apropiado:** si el quantum es muy corto, el sistema pasa mucho tiempo en overhead de context switch.

```
Proceso P0          SO              Proceso P1
   |           interrupt/syscall        |
   |─────────────────>|                 |
   |           save PCB0               idle
   |           ...                      |
   |           load PCB1                |
   |                  |─────────────────>|
  idle          interrupt/syscall       |
   |           <─────────────────|      |
   |           save PCB1                |
   |           load PCB0                |
   |<─────────────────|                idle
   |                                    |
```

---

## 4. El Scheduler

Aparece un componente esencial del SO: el **scheduler** (planificador).

- Es parte fundamental del **kernel**
- Su función: decidir a qué proceso le corresponde ejecutar en cada momento
- Pocas cosas tienen mayor impacto en el rendimiento de un SO que su política de scheduling

El scheduler mantiene una lista de **PCBs** llamada **tabla de procesos**.

---

## 5. System Calls (Llamadas al Sistema)

Las syscalls proveen una interfaz a los servicios del SO: la **API del SO**.

### 5.1 ¿Por qué son especiales?

A diferencia de una llamada a función normal, una syscall:
- Requiere **cambiar el nivel de privilegio** (user mode → kernel mode)
- Implica un **cambio de contexto**
- A veces involucra una **interrupción** del hardware

Todo esto **toma tiempo extra** (overhead).

### 5.2 Implementación en Linux

En Linux (32 bits), las syscalls se invocan mediante la **interrupción 0x80**. El número de syscall va en el registro `EAX` (o `RAX` en 64 bits).

**Ejemplo en ensamblador:**
```asm
section .data
hello: db 'Hola SO!', 10
hello_len: equ $-hello

section .text
global _start
_start:
    mov eax, 4          ; syscall write (número 4)
    mov ebx, 1          ; stdout (fd = 1)
    mov ecx, hello      ; puntero al mensaje
    mov edx, hello_len  ; longitud
    int 0x80            ; invocar al kernel

    mov eax, 1          ; syscall exit
    mov ebx, 0          ; código de retorno 0
    int 0x80
```

**El mismo ejemplo en C (usando wrapper functions):**
```c
#include <unistd.h>

int main(int argc, char* argv[]) {
    write(1, "Hola SO!\n", 9);
    return 0;
}
```

Las **wrapper functions** permiten usar syscalls con mayor portabilidad y sin programar en ensamblador. Por ejemplo, `printf()` internamente invoca a la syscall `write()`.

### 5.3 Overhead medido

En MacOS 10.3.3, Intel Core i7 (2012) 2.9 GHz, con 10.000.000 iteraciones:

| Tipo de operación | Ciclos de reloj |
|---|---|
| System call | 1.319.374.911 |
| Llamada a función | 993.981.671 |
| Asignación en arreglos | 584.898.656 |

- Una llamada a función es **1.7× más cara** que una asignación
- Una system call es **1.3× más cara** que una llamada a función

### 5.4 Ejemplos de System Calls

| Categoría | Windows | Unix/Linux |
|-----------|---------|------------|
| Control de procesos | `CreateProcess()`, `ExitProcess()`, `WaitForSingleObject()` | `fork()`, `exit()`, `wait()` |
| Manipulación de archivos | `CreateFile()`, `ReadFile()`, `WriteFile()`, `CloseHandle()` | `open()`, `read()`, `write()`, `close()` |
| Manipulación de dispositivos | `SetConsoleMode()`, `ReadConsole()` | `ioctl()`, `read()`, `write()` |
| Información del sistema | `GetCurrentProcessID()`, `SetTimer()` | `getpid()`, `alarm()`, `sleep()` |
| Comunicación | `CreatePipe()`, `CreateFileMapping()` | `pipe()`, `shmget()`, `mmap()` |
| Protección | `SetFileSecurity()` | `chmod()`, `umask()`, `chown()` |

---

## 6. Estado de un Proceso

Las actividades de E/S dan origen al concepto de **estado de un proceso**.

### 6.1 Los tres estados fundamentales

```
              ┌─────────────┐
              │  CORRIENDO  │──────────────────> TERMINADO
              └─────────────┘
               ↑         |
    scheduler  |         | E/S o evento
    dispatch   |         ↓
              ┌─────────────┐    I/O completada    ┌──────────────┐
              │    LISTO    │<─────────────────────│  BLOQUEADO   │
              └─────────────┘                      └──────────────┘
```

| Estado | Descripción |
|--------|-------------|
| **Corriendo** | Está usando la CPU activamente |
| **Bloqueado** | No puede correr hasta que algo externo suceda (E/S lista, señal, etc.) |
| **Listo** | No está bloqueado, pero espera turno de CPU |

> **Nota:** La **carga del sistema** = cantidad de procesos en estado **Listo**.

### 6.2 El PCB (Process Control Block)

Cada proceso tiene un PCB que almacena:
- Registros del procesador (guardados durante context switch)
- Instruction Pointer (PC)
- Estado del proceso
- Prioridad
- Recursos por los que está esperando
- Información de memoria (páginas, segmentos)
- Tabla de file descriptors

Los PCBs forman la **tabla de procesos**, que el scheduler usa para decidir quién ejecuta.

---

## 7. Entrada/Salida (E/S)

La E/S es **muy lenta** comparada con la CPU. Quedarse esperando activamente (busy waiting) es un desperdicio de ciclos de CPU.

### 7.1 Modos de E/S

**Busy waiting:**
- El proceso no libera la CPU
- Sigue ejecutando instrucciones mientras espera
- Solo un proceso efectivo a la vez
- Sencillo pero ineficiente

**Polling:**
- El proceso libera la CPU periódicamente
- Verifica si la E/S terminó
- Aún desperdicia quantum hasta que la E/S esté lista

**Interrupciones (el modo correcto):**
- El SO no le otorga más quanta al proceso hasta que su E/S esté lista
- El hardware comunica que la E/S terminó mediante una **interrupción**
- La interrupción es atendida por el SO, que "despierta al proceso" (lo mueve de BLOQUEADO a LISTO)
- Permite la **multiprogramación** real

### 7.2 E/S Bloqueante vs No Bloqueante desde el código

**Bloqueante:**
```c
// El proceso se bloquea hasta que la lectura completa
ssize_t bytes = read(fd, buffer, size);
// Llegamos aquí solo cuando la E/S terminó
```

**No bloqueante (usando `select()`):**
```c
fd_set lectura;
FD_ZERO(&lectura);
FD_SET(fd, &lectura);

struct timeval timeout = {5, 0}; // 5 segundos

int resultado = select(fd+1, &lectura, NULL, NULL, &timeout);
if (resultado > 0 && FD_ISSET(fd, &lectura)) {
    // fd está listo para leer
    read(fd, buffer, size);
}
// Mientras tanto, podemos hacer otras cosas
```

---

## 8. Multiprogramación y Conceptos Relacionados

| Término | Definición |
|---------|------------|
| **Multiprocesador** | Equipo con más de un procesador físico |
| **Multiprogramación** | Capacidad del SO de tener varios procesos en ejecución (alternando) |
| **Multiprocesamiento** | Procesamiento real en paralelo en multiprocesadores |
| **Multitarea** | Multiprogramación con conmutación tan rápida que parece simultánea |
| **Multithreaded** | Procesos con varios "mini-procesos" (threads) internos |

---

## 9. Señales (Signals)

Las **señales** son un mecanismo POSIX para notificar a un proceso la ocurrencia de un evento.

### 9.1 Funcionamiento

Cuando un proceso recibe una señal:
1. Su ejecución se **interrumpe**
2. Se ejecuta un **handler** (manejador) para esa señal
3. Al terminar el handler, el proceso retoma su ejecución

Cada tipo de señal tiene un **handler por defecto** que puede ser reemplazado con `signal()` o `sigaction()`.

### 9.2 Señales comunes

| Señal | Número | Causa | Handler por defecto |
|-------|--------|-------|---------------------|
| `SIGINT` | 2 | Ctrl+C | Terminar proceso |
| `SIGKILL` | 9 | Muerte forzada | Terminar (no se puede interceptar) |
| `SIGTERM` | 15 | Terminación "amable" | Terminar proceso |
| `SIGSEGV` | 11 | Segmentation fault | Terminar + core dump |
| `SIGCHLD` | 17 | Hijo terminó | Ignorar |
| `SIGSTOP` | 19 | Pausar proceso | Pausar (no se puede interceptar) |

> **Importante:** `SIGKILL` y `SIGSTOP` **no pueden** ser bloqueadas ni se puede reemplazar su handler. Son las señales "irresistibles" del SO.

### 9.3 Ejemplo de uso

```c
#include <signal.h>
#include <stdio.h>

void handler(int sig) {
    printf("Recibi señal %d, ignorando Ctrl+C\n", sig);
}

int main() {
    // Reemplazar handler de SIGINT
    signal(SIGINT, handler);
    
    while(1) {
        printf("Corriendo...\n");
        sleep(1);
    }
    return 0;
}
```

Para enviar señales desde terminal:
```bash
kill -9 1234    # SIGKILL al proceso con PID 1234
kill -2 1234    # SIGINT (equivalente a Ctrl+C)
```

---

## 10. POSIX

**POSIX** (Portable Operating System Interface, X = UNIX) es un estándar IEEE (1003.1/2008) que define una API portable entre sistemas tipo UNIX.

Sus **Core Services** incluyen:
- Creación y control de procesos (`fork`, `exec`, `wait`, `exit`)
- Pipes (`pipe`, `mkfifo`)
- Señales (`signal`, `kill`)
- Operaciones de archivos y directorios
- Excepciones y errores del bus
- Biblioteca C estándar
- Instrucciones de E/S y control de dispositivos (`ioctl`)

POSIX garantiza que un programa escrito para Linux compilará y funcionará en macOS, FreeBSD, y otros sistemas UNIX-like sin modificaciones (en teoría).

---

## 11. Threads vs Procesos

### Proceso (concurrencia con varios procesos)
- Cada proceso tiene su **propio espacio de memoria**
- Aislamiento total: un proceso no puede acceder a la memoria de otro
- Mayor overhead en context switch
- Comunicación requiere IPC (pipes, sockets, memoria compartida)

### Thread (hilo de ejecución)
- Múltiples threads **comparten** el espacio de memoria del proceso
- Cada thread tiene sus propios **registros** y **stack**
- Menor overhead en context switch
- Comunicación directa a través de variables compartidas (pero requiere sincronización)

```
Proceso con 3 threads:
┌─────────────────────────────────────────┐
│ Espacio de dirs.  │Reg+Stack│Reg+Stack│Reg+Stack │
│ Archivos          │ Thread1 │ Thread2 │ Thread3  │
├─────────────────────────────────────────┤
│ Código (compartido por todos los threads) │
├─────────────────────────────────────────┤
│ Datos (compartidos por todos los threads) │
└─────────────────────────────────────────┘
```

---

## Resumen

| Concepto | Descripción |
|----------|-------------|
| **Proceso** | Programa en ejecución, tiene PID único |
| **fork()** | Crea proceso hijo idéntico al padre |
| **exec()** | Reemplaza el código del proceso actual |
| **wait()** | Padre se bloquea hasta que hijo termine |
| **PCB** | Process Control Block — estado completo del proceso |
| **Context switch** | Guardar/restaurar estado al cambiar de proceso |
| **Quantum** | Tiempo máximo de CPU antes del cambio de proceso |
| **Scheduler** | Componente del SO que decide qué proceso ejecuta |
| **Syscall** | Interfaz entre user mode y kernel mode |
| **Signal** | Notificación asíncrona de eventos a procesos |
