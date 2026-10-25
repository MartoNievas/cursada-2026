# Práctica 7: Seguridad de la información

**Sistemas Operativos — FCEyN, Universidad de Buenos Aires**

---

## Ejercicio 3

Contamos con el siguiente código:

```C
void saludo(void) {
    char nombre[80];
    printf("Ingrese su nombre: ");
    gets(nombre);
    printf("Hola %s!\n", nombre);
}
```

### a)

El problema de seguridad se introduce en la función `gets`, que es insegura debido a que no hace chequeo de rangos: lee `stdin` hasta encontrar un `\n` o un `EOF`, sin importar el tamaño del buffer de destino, que en este caso es `char nombre[80]`. El problema de seguridad es una vulnerabilidad de **desbordamiento de buffer en el stack**.

---

### b)

Este problema de seguridad puede dar al usuario la posibilidad de:

1. **Sobrescribir variables locales adyacentes** del mismo stack frame, alterando la lógica de ejecución del programa.

2. **Sobrescribir registros respaldados en la pila**, principalmente el marco de pila anterior (Saved Frame Pointer, EBP/RBP).

3. **Sobrescribir la dirección de retorno** (Saved Instruction Pointer, EIP/RIP) de la función `saludo`. Al finalizar la función y ejecutarse la instrucción `ret`, el procesador cargará la dirección manipulada por el atacante, permitiendo redirigir la ejecución hacia código arbitrario (shellcode, cadenas ROP o llamadas a bibliotecas como `system()`).

---

### c)

Como el desbordamiento ocurre en `saludo()`, no es posible afectar los stack frames de las funciones `printf` o `gets`, ya que la escritura del buffer avanza hacia direcciones de memoria más altas, mientras que los stack frames de estas dos funciones se ubican en direcciones más bajas.

---

### d)

El problema no se elimina quitando el segundo `printf`, ya que el problema de fondo está en `gets`, que no chequea los límites de escritura del buffer y simplemente escribe hasta encontrar un `\n` o un `EOF`. Por lo tanto, quitar el segundo `printf` no es una solución.

---

## Ejercicio 4

El siguiente es un sistema de login que valida los datos contra una base de datos.

```C
struct credential {
    char name[32];
    char pass[32];
};

bool login(void) {
    char realpass[32];
    struct credential user;
    // Pregunta el usuario
    printf("User: ");
    fgets(user.name, sizeof(user), stdin);
    // Obtiene la contraseña real desde la base de datos y la guarda en realpass
    db_get_pass_for_user(user.name, realpass, sizeof(realpass));
    // Pregunta la contraseña
    printf("Pass: ");
    fgets(user.pass, sizeof(user), stdin);
    return strncmp(user.pass, realpass, sizeof(realpass)-1) == 0;
    // True si user.pass == realpass
}
```

Se asume que la función `db_get_pass_for_user` es totalmente correcta y no escribe fuera de `realpass`.

### a)

El diagrama de pila es el siguiente:

```text
Direcciones ALTAS (0xFFFF...)
      ▲
      │  ┌──────────────────────────────────────────────────┐
      │  │ Dirección de retorno de login()                  │  <-- A donde vuelve login (ej. main)
      │  ├──────────────────────────────────────────────────┤
      │  │ Saved EBP / RBP de login()                       │
      │  ├──────────────────────────────────────────────────┤
      │  │ char realpass[32]                                │  <-- el segundo fgets tiene acceso hasta aquí
      │  │   ...                                            │
      │  │   realpass[0]                                    │
      │  ├──────────────────────────────────────────────────┤
      │  │ struct credential user (64 bytes en total):      │
      │  │   char pass[32]                                  │  <-- el primer fgets llega hasta aquí
      │  │     ...                                          │
      │  │     user.pass[0]                                 │  <-- el segundo fgets comienza aquí
      │  │   --------------------------------------------   │
      │  │   char name[32]                                  │
      │  │     ...                                          │
      │  │     user.name[0]                                 │  <-- Inicio de user.name, el primer fgets empieza aquí
      ▼  └──────────────────────────────────────────────────┘
Direcciones BAJAS (0x0000...)
```

Viendo el diagrama, con los dos `fgets` el usuario tiene acceso a todos los buffers que se utilizan, incluidos los dos que se usan para la comparación final.

---

### b)

Sabiendo que la contraseña tiene 32 bytes, el usuario podría introducir en el segundo `fgets` un texto de 64 bytes, formado por una cadena de 32 bytes concatenada consigo misma, sobrescribiendo así la contraseña real que se almacena en el buffer `realpass`.

---

## Ejercicio 5

La siguiente función se utiliza para verificar la contraseña del usuario actual **user** en el programa que desbloquea la sesión luego de activarse el protector de pantalla del sistema. El usuario ingresa la contraseña por teclado.

```C
bool check_pass(const char *user) {
    char pass[128], realpass[128], salt[2];

    // Carga la contraseña (encriptada) desde /etc/shadow
    load_pass_from(realpass, sizeof(realpass), salt, user, "/etc/shadow");

    // Pregunta al usuario por la contraseña.
    printf("Password: ");
    gets(pass);

    // Demora de un segundo para evitar abuso de fuerza bruta
    sleep(1);

    // Encripta la contraseña y compara con la almacenada
    return strcmp(crypt(pass, salt), realpass) == 0;
}
```

* `void load_pass_from(buf, buf_size, salt, user, file)` lee del **file** la contraseña del **user** y la almacena en **buf**, escribiendo a lo sumo **buf_size - 1** caracteres más el carácter nulo. Guarda además en **salt** el valor de los caracteres que se usaron para encriptar la contraseña en **file**. Si no encuentra al usuario, se genera una contraseña inválida en **buf**, no encontrable por `crypt`.

* `char* crypt(pass, salt)` devuelve la contraseña **pass** encriptada usando el valor **salt**.

* `/etc/shadow` almacena información sensible del sistema y un usuario común no tiene acceso a este archivo; solo el root o los usuarios que estén en el grupo **shadow**.

### a)

El mecanismo que le permite a un usuario normal tener acceso momentáneo a `/etc/shadow` es la función `setuid`.

Los procesos tienen dos `uid`: el real, que es el del usuario que inició el proceso, y el efectivo, que indica qué permisos tiene actualmente el proceso y puede ir modificándose.

`setuid` puede cambiar el `effective uid`, haciendo que el owner de este proceso sea `root` para poder tener acceso a `/etc/shadow`.

El sistema le puede dar acceso momentáneo a `/etc/shadow` y, una vez que se termina el proceso de `login`, se degradan los permisos del proceso, haciendo que pierda los privilegios de `root`.

---

### b)

Esta función tiene problemas de seguridad debido a que usa el famoso `gets`. Como `gets` no deja de leer hasta que se ingresa un `\n` o un `EOF`, podemos producir un **stack buffer overflow**.

Entonces, por el orden secuencial del programa, el usuario, mediante un string de 384 bytes, va a tener acceso a `realpass` y `salt`. Si se invirtiera el orden en el que se pide el input, no tendríamos el problema de la contraseña, pero sí se podría sobrescribir la dirección de retorno de la función `bool check_pass(const char *user)`.

Por lo tanto, el usuario tiene acceso tanto a la dirección de retorno del programa como a todas las variables locales de la función.

---

### c)

Sí, compromete la integridad del sistema completo. Aunque los usuarios que ejecutan el programa ya cuenten con acceso a una terminal, para que la función pueda leer el archivo sensible `/etc/shadow` el binario ejecutable debe tener configurado el bit setuid perteneciente a `root`. Por lo tanto, el proceso se ejecuta con privilegios efectivos de superusuario (`EUID = 0`).

Dado que `gets(pass)` introduce un desbordamiento de buffer en el stack sin límite de tamaño, un usuario no solo puede manipular las variables locales para saltear la autenticación, sino que también puede **sobrescribir la dirección de retorno de la función** `check_pass` (Saved Instruction Pointer).

Esto permite desviar el flujo de ejecución hacia código inyectado (shellcode) o utilizar técnicas como Return-to-libc para invocar una shell (por ejemplo, `/bin/sh`). Como el proceso retiene los privilegios efectivos de `root`, la shell resultante se ejecutará con permisos de superusuario, permitiendo una **escalada local de privilegios (Privilege Escalation)** total que vulnera por completo la seguridad del sistema operativo.

---

## Ejercicio 6

Tenemos el siguiente código y suponemos que el usuario controla el parámetro `float f`:

```C
#define NEGATIVO 1
#define CERO 2
#define POSITIVO 3
int signo(float f) {
    if (f < 0.0) return NEGATIVO;
    if (f == 0.0) return CERO;
    if (f > 0.0) return POSITIVO;
    assert(false && "Por acá no paso nunca");
    return 0; // Si no pongo esto el compilador se queja =(
}
```

### a)

Sí, hay 2 formas de que el usuario llegue a ejecutar el `assert`:

1. Pasándole `NAN`: en el estándar IEEE-754 es **desordenado**, entonces cualquier relacional que involucre **NaN** siempre evalúa a **falso**.

2. Pasándole `-0.0f`: en el estándar IEEE-754 se implementa el 0 signado; sin embargo, se puede implementar por hardware que `-0.0f == 0.0f` sea true.

---

### b)

Al compilar en modo Release con la opción `-DNDEBUG`, la macro `assert()` se desactiva y se elimina del binario.

Si el usuario ingresa un valor que resulte en `NaN` (Not a Number), todas las comparaciones (`<`, `==`, `>`) evalúan a falso según el estándar IEEE-754. Al saltearse los tres `if` y no ejecutarse el `assert`, el flujo de control alcanza la última línea y la función retorna 0, rompiendo la precondición de devolver únicamente `1`, `2` o `3`.

---

## Ejercicio 8

Tenemos el siguiente código, que corre con el mayor nivel de privilegio; sin embargo, tiene problemas de seguridad. Además, podemos suponer que el usuario controla el parámetro `dir`:

```C
#define BUF_SIZE 1024
void wrapper_ls(const char * dir) {
    char cmd[BUF_SIZE];
    snprintf(cmd, BUF_SIZE-1, "ls %s", dir);
    system(cmd);
}
```

### a)

Teniendo en cuenta que el usuario controla el parámetro `dir`, podemos pasar la cadena `.; cat /etc/passwd` para mostrar el contenido de `/etc/passwd`. Con el `.` listamos el directorio actual, luego con `;` concatenamos comandos en sistemas **Unix** y, por último, con `cat` podemos ver el contenido de archivos. Como `wrapper_ls` corre con el máximo nivel de privilegio, es decir `root`, puede leer `/etc/passwd`.

---

### b)

Ahora, supuestamente, la función se hizo segura y se llama `secure_wrapper_ls`. Se cambió el formateo de la cadena en `snprintf`: en vez de `"ls %s"` se reemplazó por `"ls \"%s\""`. Tenemos que mostrar que la función sigue siendo insegura.

Si utilizamos la cadena `"; cat /etc/passwd; echo "` podemos saltarnos el nuevo formateo, debido a que las primeras comillas se cierran con el `ls`, pasándole un **PATH** vacío, y las últimas comillas se cierran con el `echo`, pasándole un string vacío, dejando el comando `cat /etc/passwd`.

---

### c)

Ahora, además de lo anterior, se agregó la verificación de que la cadena no puede contener el carácter `;`. Tenemos que mostrar que esta modificación tampoco arregla el problema de seguridad.

Podemos pasar la cadena `." && cat /etc/passwd; echo "`. Con `&&` concatenamos comandos, pero tiene la particularidad de que si uno falla se corta la ejecución; entonces, la idea de la cadena es que nada falle y se ejecute todo. Además, se podría cambiar el `PATH` para ejecutar un `ls` malicioso.

---

### d)

Vamos a proponer una versión sin problemas de seguridad, la cual es la siguiente:

```C
#define BUF_SIZE 1024
void wrapper_ls(const char * dir) {
    char cmd[BUF_SIZE];
    snprintf(cmd, BUF_SIZE-1, "/bin/ls %s", dir);
    char *cmd_sanitized = strtok(cmd, " ;&|() ");
    system(cmd_sanitized);
}
```

La idea es que no se puedan concatenar comandos de ningún tipo, además de que no se pueda cambiar la variable `PATH` para ejecutar un `ls` malicioso.

---

## Ejercicio 11

Tenemos el siguiente código, el cual tiene problemas de seguridad. También podemos suponer que el usuario controla la entrada estándar:

```C
#define MAX_BUF 4096
void saludo(void) {
    char nombre[MAX_BUF];
    printf("Ingrese su nombre: ");
    fgets(nombre, MAX_BUF, stdin);
    printf(nombre);
}
```

### a)

El problema de seguridad se introduce en `printf(nombre)`, ya que el primer parámetro de la función `printf` es el formato de la cadena a imprimir, y el resto de los argumentos es lo que se pone en esa cadena.

---

### b)

Entre los datos del programa que el usuario podría controlar a través de este problema de seguridad, se le puede pasar una cadena como `%p` y conocer direcciones de memoria del stack, ya que `nombre` se almacena ahí mismo. Con esto podría intentar adivinar el tipo de las variables locales, ver todo el stack y, además, conocer direcciones de retorno.

---

### c)

Mediante el especificador `%n` (o `%hhn` para escribir byte a byte) en la cadena de formato vulnerable, un atacante puede escribir un valor arbitrario en cualquier dirección de memoria. Dado que la dirección de retorno reside en el stack, es posible apuntar a ella y sobrescribirla para redirigir el flujo de ejecución cuando la función retorne.

---

### d)

Poner `exit(0)` no soluciona el problema, ya que la explotación de la vulnerabilidad ocurre dentro de `printf`. Lo correcto es usar `printf` de la siguiente manera: `printf("%s", nombre);`

---

## Ejercicio 12

Teniendo en cuenta el ejercicio anterior, considerar el siguiente código:

```C
void saludo(void) {
    char nombre[80];
    printf("Ingrese su nombre: ");
    gets(nombre);
    printf(nombre);
    exit(0);
}
```

**No, la segunda llamada a `printf` sigue siendo completamente insegura.**

El hecho de que `saludo()` no retorne es irrelevante por los siguientes motivos:

1. **La propia `printf` debe retornar:** al invocar `printf`, se crea su propio *stack frame*. Mediante el especificador `%n`, un atacante puede sobrescribir la dirección de retorno de la llamada a `printf`. Al ejecutarse la instrucción `ret` de `printf`, el control del flujo se desvía **antes** de que el programa llegue siquiera a evaluar la línea de `exit(0)`.

2. **Escritura arbitraria fuera del stack (GOT / handlers):** la escritura con `%n` no se limita al stack local; permite alterar cualquier dirección accesible de memoria. Un atacante puede sobrescribir la entrada de `exit` en la **GOT** (*Global Offset Table*) o punteros de terminación internos de `libc`, secuestrando la ejecución en el instante en que se invoque `exit(0)`.

3. **Fuga de información (*information leak*):** con especificadores como `%p` o `%s`, se pueden volcar datos confidenciales y direcciones de memoria a la salida estándar, eludiendo mecanismos como ASLR.

*(Adicionalmente, el uso de `gets` introduce una vulnerabilidad de buffer overflow clásica que permite corromper el stack incluso antes de que se ejecute `printf`).*

---

## Ejercicio 13

Contamos con el siguiente código, el cual tiene un problema de seguridad. Se trata de una función de la biblioteca de encriptación **OpenSSL**:

```C
char *SSL_get_shared_ciphers(
    char *ciphers[],
    int cant_ciphers,
    char *buf,
    int len
) {
    char *p;
    const char *cp;
    int i;
    if (len < 2)
        return (NULL);
    p = buf;
    for (i = 0; i < cant_ciphers; i++) {
        /* Decrement for either the ':' or a '\0' */
        len--;
        for (cp = ciphers[i]; *cp; ) {
            if (len-- == 0) {
                *p = '\0';
                return (buf);
            }
            else
                *(p++) = *(cp++);
        }
        *(p++) = ':';
    }
    p[-1] = '\0';
    return (buf);
}
```

Dado que el usuario controla el contenido de **ciphers** y **cant_ciphers**, siendo el primero un array válido de **cant_ciphers** posiciones definidas, donde cada una apunta a una cadena válida de al menos 1 y a lo sumo 100 caracteres, y que `buf` es un buffer de tamaño **len** que no es controlado por el usuario:

### a)

Queremos ver si es posible escribir más allá del límite de `buf`, a pesar de todos los chequeos de longitud del mismo. Por ahora veo los siguientes problemas:

1. **Condición de corte salteada:** en el chequeo `if (len-- == 0)`, si por algún motivo `len` salta el `0` y se vuelve negativo, la condición nunca se cumplirá a tiempo, lo que permitirá seguir escribiendo en el buffer con otros ciphers de manera arbitraria.

2. **Decremento no validado fuera del bucle de copia:** al inicio de cada vuelta del bucle externo se ejecuta `len--` de forma incondicional para reservar espacio para el separador `:` (o el terminador nulo). Si el cifrado anterior consumió el buffer de modo que `len` quedó exactamente en `0`, este nuevo decremento fuerza a `len` a tomar el valor `-1` antes de ingresar al chequeo interno.

3. **Invalidez permanente de la condición de corte:** como `len` es un entero con signo (`int`), una vez que alcanza `-1`, cualquier iteración subsiguiente continúa decrementándolo hacia valores más negativos (`-2`, `-3`, etc.). La condición de igualdad estricta `len-- == 0` evalúa siempre a falso, deshabilitando el mecanismo de frenado y permitiendo que la copia `*(p++) = *(cp++)` continúe indefinidamente sobre memoria adyacente no reservada.

---

### b)

Si un atacante explota el desbordamiento de buffer (*buffer overflow*) en un servidor que emplea esta biblioteca vulnerable, el impacto va desde la indisponibilidad del servicio hasta el compromiso total del sistema. La gravedad técnica depende principalmente de **dónde esté alojado `buf` en memoria**.

#### 1. Si `buf` reside en el stack (*stack-based buffer overflow*)

Si el servidor declaró el buffer como una variable local en la función llamadora (por ejemplo, `char buf[128];`):

* **Ejecución remota de código (RCE, *Remote Code Execution*):** el atacante controla los nombres de los cifrados enviados en el paquete de negociación (*Client Hello*). Al desbordar el buffer linealmente, puede sobrescribir datos de control del marco de pila: el *frame pointer* (`%rbp`) y la **dirección de retorno (*saved RIP/EIP*)**. Al finalizar la función, el procesador salta a instrucciones controladas por el atacante (mediante cadenas ROP o inyección de shellcode).
* **Escalada de privilegios:** si el proceso del servidor se ejecuta con permisos de administrador (`root`) o privilegios de red específicos (como `www-data`), el atacante hereda exactamente esos privilegios para ejecutar comandos en el sistema operativo.

#### 2. Si `buf` reside en el heap (*heap-based buffer overflow*)

Si el buffer fue asignado dinámicamente mediante `malloc()`:

* **Corrupción de metadatos del asignador de memoria:** puede sobrescribir las cabeceras de los *chunks* contiguos de la memoria dinámica, permitiendo técnicas de explotación avanzadas para redirigir punteros de ejecución.
* **Sobrescritura de datos sensibles adyacentes:** en un servidor SSL/TLS, el heap alberga estructuras críticas que pueden ser alteradas o leídas:
  * Punteros a funciones y tablas virtuales (*vtables*).
  * Claves privadas de sesión y certificados en memoria.
  * Contextos de conexión y sesiones de otros usuarios autenticados concurrentemente.

#### 3. Denegación de servicio (DoS, *Denial of Service*)

Incluso con mecanismos de mitigación activos en el sistema operativo (como ASLR, NX/DEP o *stack canaries*) que impidan ejecutar código arbitrario:

* La escritura fuera de los límites de memoria provocará inevitablemente la corrupción de punteros críticos o la activación de excepciones de hardware/software (`SIGSEGV` o fallo de canario `__stack_chk_fail`), terminando de forma abrupta el proceso del servidor.
* Un atacante puede automatizar el envío de paquetes maliciosos para reiniciar o tumbar constantemente los procesos del servidor, bloqueando el acceso a clientes legítimos.

---

> **Precedente histórico (CVE-2002-0659 / "Slapper Worm"):**
> este fallo de diseño exacto en la función `SSL_get_shared_ciphers` de OpenSSL fue aprovechado por el gusano *Slapper* en 2002. Enviando una lista manipulada de cifrados durante el *handshake* SSL a servidores Apache en Linux, el exploit obtenía una shell remota y sumaba automáticamente las máquinas comprometidas a una red botnet de ataques DDoS.

---

## Ejercicio 15

Dado el código a continuación:

```C
void imprimir_habilitado(const char *nombre_usuario, const char* clave,
    const char * imprimir, int tam_imprimir) {
    char *cmd = malloc(tam_imprimir+5 * sizeof(char));
    if (cmd == NULL)
        exit(1);
    if (usuario_habilitado("/etc/shadow", nombre_usuario, clave)) {
        snprintf(cmd, tam_imprimir+4, "echo %s", imprimir);
        system(cmd);
    } else {
        printf("El usuario o clave indicados son incorrectos.");
        assert(-1);
    }
}
```

---

### 1)

En principio, analizando el código, la única línea que requiere permisos elevados, en particular de `root`, es la línea donde se ejecuta `usuario_habilitado("/etc/shadow", nombre_usuario, clave)`, ya que en sistemas **Unix** el archivo shadow pertenece al usuario `root` y al grupo `shadow`, y solo puede ser accedido por ellos. Entonces podríamos hacer que el binario pertenezca a `root` y activar el bit **SetUID**.

---

### 2 y 3)

Como en el inciso anterior llegamos a la conclusión de que el programa debe correr con privilegios de `root` mediante el bit `SetUID`, veo los siguientes problemas de seguridad:

1. **Inyección de comandos y escalamiento de privilegios:** podemos pasarle un usuario y una contraseña válidos de un usuario común del sistema, de tal manera que pasemos la verificación del `if (usuario_habilitado("/etc/shadow", nombre_usuario, clave))`. De esa manera, podríamos poner un comando malicioso en el buffer que se pasa por el parámetro `imprimir`, para que este se concatene en `cmd` y se ejecute mediante `system()` con privilegios de `root`. Un posible comando malicioso para poner en `imprimir` sería `"hackeado maquinola"; /bin/sh`, lo que nos ejecutaría una shell interactiva con UID 0 (root), logrando un escalamiento total de privilegios y acceso a todo el sistema.

2. **Environment Variable Attack (PATH Hijacking):** como el comando `echo` que se inserta en `cmd` no tiene la ruta absoluta, la shell invocada por `system()` utiliza la variable de entorno `PATH` para resolver la ubicación del binario (asumiendo que la shell no ejecute su propio comando interno o *builtin*). Entonces podemos hacer `export PATH="/tmp:$PATH"` y crear en `/tmp` un script o binario malicioso con el nombre `echo` que levante una shell. Como el programa corre con privilegios de `root`, esa shell también los heredará, logrando nuevamente un escalamiento de privilegios.

3. **Heap-based Buffer Overflow por Integer Underflow:** podemos causar un desbordamiento en el heap pasando un valor negativo específico en `tam_imprimir`, por ejemplo `-5`. Como tanto `malloc` como `snprintf` reciben un `size_t` (entero sin signo), si pasamos `tam_imprimir = -5`:
   - `malloc(tam_imprimir + 5)` evalúa a `malloc(0)`, reservando un bloque mínimo en el heap y evitando que `cmd` sea `NULL` (no entra al `exit(1)`).
   - En la llamada a `snprintf`, `tam_imprimir + 4` evalúa a `-1`, que al castearse implícitamente a `size_t` se interpreta como un número enorme (`SIZE_MAX`).

   Con esto, `snprintf` asume que el buffer tiene un espacio casi infinito y escribe `"echo %s"` mucho más allá del bloque chico que asignó `malloc`, permitiendo corromper metadatos y memoria del heap, lo que puede causar una denegación de servicio (DoS) o la ejecución de código arbitrario.

---

### 4)

Siendo la Confidencialidad, la Integridad y la Disponibilidad los tres requisitos fundamentales de la seguridad de la información, el impacto de las vulnerabilidades encontradas se evidencia de la siguiente manera:

* **Confidencialidad:** se ve vulnerada principalmente mediante la inyección de comandos o el secuestro de la variable `PATH`. Al ejecutarse con privilegios efectivos de `root` (debido al bit SetUID del binario), un atacante puede ejecutar cualquier comando en el sistema operativo, permitiéndole leer archivos restringidos a otros usuarios o al propio administrador (como `/etc/shadow`, claves privadas o bases de datos).

* **Integridad:** se ve afectada de dos formas:
  - En memoria: mediante el *heap-based buffer overflow*, que permite alterar datos adyacentes y metadatos internos del proceso sin autorización.
  - A nivel del sistema: a través de la inyección de comandos o la manipulación de `PATH`, ya que una shell como `root` permite modificar o sobrescribir de forma arbitraria cualquier archivo del sistema, logs de auditoría o configuraciones críticas.

* **Disponibilidad:** se rompe tanto local como globalmente:
  - A nivel del proceso: el desbordamiento en el heap corrompe la memoria dinámica, provocando que el asignador de memoria aborte o que se genere una excepción de hardware (`SIGSEGV`), tumbando el servicio (*Denial of Service*).
  - A nivel del sistema operativo: al conseguir ejecución arbitraria como `root` mediante la inyección de comandos, el atacante tiene el control total para forzar el reinicio de la máquina, matar procesos esenciales o ejecutar comandos destructivos (como `rm -rf /`), dejando el sistema completamente inoperativo.

---

### 5)

A continuación vamos a proponer soluciones para cada vulnerabilidad:

1. La primera vulnerabilidad es la inyección de comandos maliciosos. La solución más fácil que se me ocurre es sanitizar `cmd` mediante la función `strtok`, filtrando los caracteres potencialmente maliciosos como `&`, `;`, `|`, etc. Con eso prevenimos la inyección de código malicioso.

2. Aquí lo mejor es poner en `snprintf` la ruta absoluta de `echo`, que sería `/bin/echo`. Esto evitaría que, por más que se cambie el `PATH` del sistema, siempre se ejecute el mismo binario de `echo` y no uno malicioso. Si el atacante quiere modificar `/bin/echo`, requiere privilegios de `root`.

3. Para el buffer overflow, la mejor opción es hacer la siguiente comprobación:

```C
if (tam_imprimir < 0) {
    perror("Error: tam_imprimir no puede ser negativo\n");
    exit(1);
}
```

---

## Ejercicio 16

Contamos con el siguiente código:

```C
/**
* Dado un usuario y una clave, indica si la misma es válida
*/
extern bool clave_es_valida(char* usuario, char* clave);
bool validar_clave_para_usuario(char *usuario){
    // fmt = " %......."
    char fmt[8];
    fmt[0] = '%';
    printf("Ingrese un largo para la clave: ");
    // fmt = " %NNNN\0"
    scanf(" %4s", fmt+1);
    int l = strlen(fmt+1);
    // max_size <- atoi(NNNN)
    unsigned char max_size = atoi(fmt+1);
    char clave[max_size+1];
    // fmt = " %NNNNs\0"
    fmt[l+1] = 's';
    fmt[l+2] = '\0';
    scanf(fmt, clave);
    return clave_es_valida(usuario, clave);
}
int main(int argc, char **argv){
    setuid(0);
    bool es_valida = validar_clave_para_usuario(argv[1]);
    if(es_valida) {
        system("/bin/bash");
    } else {
        exit(EXIT_FAILURE);
    }
}
```

---

### Descripción del programa

Lo que hace el programa es, dado un input del usuario, primero poner el uid efectivo del proceso en `0`, lo que significa que a partir de ese momento va a ejecutarse con permisos de `root`. Luego entra en la función `validar_clave_para_usuario` para terminar de hacer el login: si el login sale bien, abre una terminal nueva con permisos de `root` y, si sale mal, hace un `exit`.

Dentro de la función `validar_clave_para_usuario`, primero se define un buffer de `char` de tamaño 8 llamado `fmt`, y en su primer índice se pone `%`. Luego se le pide al usuario ingresar por `stdin` un largo. Con `scanf(" %4s", fmt+1)` se leen únicamente los primeros 4 caracteres ingresados. Si se ingresan de más, se ignoran y quedan en el buffer de entrada para la próxima lectura de `stdin`.

Luego se guarda en el formato la longitud máxima de la clave. Si se le pasa un número más grande que 255 o uno negativo, `max_size` se va a truncar, por lo que sus valores posibles van de 0 a 255. En principio, el string `fmt` debería tener la pinta `"%NUMs\0"`, donde `NUM` es un número entre 0 y 255.

Cuando se hace `scanf(fmt, clave)`, en principio se va a guardar en `clave` un input del usuario de entre 0 y 255 caracteres.

---

### Vulnerabilidad

El problema de seguridad está principalmente en cómo se arma el formato. Al hacer `unsigned char max_size = atoi(fmt+1)`, si le pasamos un número muy grande, este se va a achicar tomándolo módulo 256. El problema es que `max_size` no va a coincidir con el número del string de formato si le pasamos un número de 4 dígitos.

Entonces, por ejemplo, si le pasamos un número muy grande que sea congruente a 0 módulo 256, como 9984, `max_size` va a valer 1, por lo tanto nuestro buffer va a tener tamaño `1`, mientras que en el `scanf` vamos a estar esperando leer 9984 caracteres. Así se puede hacer un **buffer overflow** del buffer `clave`.

Por medio de este buffer overflow podemos, sin importar si ingresamos una clave válida o no, modificar la dirección de retorno para que haga lo que nosotros queramos. Por ejemplo, puede entrar a la parte verdadera del `if` y obtener acceso a una shell como `root`, o podemos hacer que ejecute como `root` el código que nosotros queramos.

En resumen, en este código la vulnerabilidad proviene principalmente de una **conversión insegura de tipos** en la línea `unsigned char max_size = atoi(fmt+1);`. Esta vulnerabilidad permite hacer un *buffer overflow* mediante un *integer overflow*, lo que puede llevar a un **escalamiento de privilegios** que afecta todas las características fundamentales de la seguridad de la información.

---

### Impacto

Los posibles impactos sobre los tres principios básicos de la seguridad de la información son:

* **Confidencialidad:** como el ataque conlleva un **escalado de privilegios** producido por un *buffer overflow* que reemplaza la dirección de retorno, podríamos ejecutar una shell con privilegios de `root`, lo cual nos da acceso a todo el sistema y, así, a datos sensibles de los usuarios.

* **Integridad:** por medio del **escalado de privilegios** podemos modificar lo que queramos del sistema, por ejemplo, cambiar las contraseñas de todos los usuarios, lo que de alguna manera también podría afectar la **Disponibilidad**.

* **Disponibilidad:** al tener mayores privilegios podemos ejecutar comandos que destruyan el sistema por completo, como por ejemplo `rm -rf /`, borrando todo el árbol de directorios y dejándolo inutilizable.

---

### Solución

Para arreglar este programa habría que modificar la función `validar_clave_para_usuario`. Allí habría que cambiar cómo construimos la variable `max_size` y también agregar un chequeo: si el número que nos pasan es negativo, se devuelve `false`.

```C
bool validar_clave_para_usuario(char *usuario){
    // fmt = " %......."
    char fmt[8];
    fmt[0] = '%';
    printf("Ingrese un largo para la clave: ");
    // fmt = " %NNNN\0"
    scanf(" %4s", fmt+1);
    int l = strlen(fmt+1);
    // max_size <- atoi(NNNN)
    int max_size = atoi(fmt+1);
    if(max_size < 1){
        return false;
    }
    char clave[max_size+1];
    // fmt = " %NNNNs\0"
    fmt[l+1] = 's';
    fmt[l+2] = '\0';
    scanf(fmt, clave);
    return clave_es_valida(usuario, clave);
}
```

Así, en caso de que ingresen un número negativo, directamente lo rechazamos para que no ocurra un *integer overflow*. Si es positivo, nos aseguramos de que coincidan la longitud del formato con el que vamos a hacer el `scanf` y la longitud del buffer `clave`.

Como el máximo valor que nos pueden pasar es 9999 para positivos y -999 para negativos, no vamos a tener problemas de *integer overflow*, porque un `int` puede representar todo ese rango sin problema.

---

### Mitigaciones

* **Stack canary:** una forma de mitigar el *buffer overflow* del lado del sistema operativo o del compilador es colocar un canario en el stack. Si al terminar de ejecutar la función el valor del canario se vio modificado porque el ataque intentó cambiar la dirección de retorno, este saltará y cortará la ejecución por un posible ataque.

* **Stack randomization:** otra forma posible de mitigar el escalamiento de privilegios por el *buffer overflow* es con *stack randomization*. Así, por más que el atacante pueda hacer el *buffer overflow* para pisar la dirección de retorno y poner una que le sirva para realizar el ataque, no le servirá, ya que las direcciones están randomizadas en cada ejecución y entonces no sabrá a dónde saltar.

* **Data Execution Prevention (DEP):** otra opción de seguridad del compilador o del sistema operativo es el *Data Execution Prevention*, para que no se pueda ejecutar código del stack. La idea del ataque sería, por medio del *overflow*, inyectar código en el stack y mover la dirección de retorno y el *instruction pointer* a código dentro del stack para poder seguir ejecutando con privilegios elevados. Lo que hace DEP es no ejecutar código que esté en regiones como el stack o el heap.

---

## Ejercicio 18

En cierto sistema cuyo filesystem soporta links simbólicos corre un juego, no muy bien programado, que les permite a los ganadores figurar en el "salón de la fama", que no es más que un directorio donde figura un archivo por cada ganador, conteniendo una frase a elección del ganador. El juego corre con máximo privilegio.

Nos dan un código y tenemos que describir dos ataques distintos: uno que involucre una inyección de shell y otro que haga uso de los links.

---

### Ataque 1: inyección de shell

La primera forma que se me ocurre es poner el comando en el input `frase`. Podemos hacer que `frase` sea lo siguiente: `hackeado maquinola'; /bin/sh`. Como el juego corre con máximo privilegio, la shell que abrimos tiene privilegios de `root`.

Una condición necesaria para que esto funcione es que no exista el archivo del ganador que pasamos por parámetro; si no, no entra en el `if` donde se ejecuta el `system`.

---

### Ataque 2: links simbólicos y race condition

El ataque que explota los links simbólicos y una *race condition* consiste en lo siguiente:

1. Pasarle al programa el nombre de un archivo que no exista en el sistema, para que vaya a la parte del código donde crea el archivo.

2. Mientras el programa está creando el archivo, el atacante tiene que reemplazar ese archivo inexistente por un enlace simbólico a otro archivo que sí exista.

3. Cuando se haga el `echo`, se van a pisar los datos del archivo destino del symlink con lo que diga la frase.

Así se podrían eliminar los datos de otros usuarios, vulnerando la **integridad** del sistema.

---

### Solución

Para arreglar esto y que no se puedan aprovechar los links simbólicos, habría que poner la restricción de que los paths se creen en una carpeta en la que el usuario no tenga permiso para escribir el archivo.