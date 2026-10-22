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

El problema de seguridad se introduce en la funcion `gets` es insegura, debido a que no hace chequeo de rangos, lee `stdin` hasta encontrar un `\n` o un `EOF`, sin importar el tamaño del buffer de destino que en este caso es `char nombre[80]`, el problema de seguridad es una vulnerabilidad de **desbordamiento de búfer en el stack**.

---

### b)

Este problema de seguridad puede dar al usuario la posibilidad de:

1. **Sobrescribir variables locales adyacentes** del mismo stack frame, alterando la lógica de ejecución del programa.

2. **Sobrescribir registros respaldados en la pila**, principalmente el marco de pila anterior (Saved Frame Pointer, EBP/RBP).

3. **Sobrescribir la dirección de retorno** (Saved Instruction Pointer, EIP/RIP) de la función saludo. Al finalizar la función y ejecutarse la instrucción ret, el procesador cargará la dirección manipulada por el atacante, permitiendo redirigir la ejecución hacia código arbitrario (shellcode, cadenas ROP o llamadas a bibliotecas como system()).

---

### c)

Como el desbordamiento ocurre en saludo(), no es posible afectar el stack frame de las funciones printf o gets, ya que la escritura del buffer avanza hacia direcciones de memoria más altas, mientras que los stack frames de estas dos funciones se ubican en direcciones más bajas.

---

### d)

El problema no se elimina quitando el segundo `printf` ya que el problema de fondo lo tiene `gets` debido a que no chequea limites de escritura del buffer y simplemente escribe hasta encontrar un `\n` o `EOF`, por lo tanto no es la solucion quitar el segundo `printf`

## Ejercicio 4

El siguiente es un sistema de login que valida los datos contra una base de datos.

```C
struct credential {
    char name[32];
    char pass[32];
}
bool login(void) {
    char realpass[32];
    struct credential user;
    // Pregunta el usuario
    printf("User: ");
    fgets(user.name, sizeof(user), stdin);
    // Obtiene la contraseña real desde la base de datos y lo guarda en realpass
    db_get_pass_for_user(user.name, realpass, sizeof(realpass));
    // Pregunta la contraseña
    printf("Pass: ");
    fgets(user.pass, sizeof(user), stdin);
    return strncmp(user.pass, realpass, sizeof(realpass)-1) == 0;
    // True si user.pass == realpass
}
```

Se asume que la funcion `db_get_pass_for_user` es totalmente correcta y no escribe fuera de `realpass`

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
      │  │ char realpass[32]                                │  <-- el segundo fgets tiene acceso hasta aqui
      │  │   ...                                            │
      │  │   realpass[0]                                    │
      │  ├──────────────────────────────────────────────────┤
      │  │ struct credential user (64 bytes en total):      │
      │  │   char pass[32]                                  │  <-- el primer fgets llega hasta aqui
      │  │     ...                                          │
      │  │     user.pass[0]                                 │  <-- el segundo fgets comienza aqui
      │  │   --------------------------------------------   │
      │  │   char name[32]                                  │
      │  │     ...                                          │
      │  │     user.name[0]                                 │  <-- Inicio de user.name, el primer fgets empieza aqui
      ▼  └──────────────────────────────────────────────────┘
Direcciones BAJAS (0x0000...)
```

Viendo el diagrama, con los dos fgets el usuario tiene acceso a todos los buffers que se utilizan incluidos ambos que se utilizan para la comparacion final.

---

### b)

El usuario podria sabiendo que la contrasenia tiene 32 bytes, podria en el segundo fgets introducir una texto de 32 bytes concatenado 2 veces asi sobreescribiendo la contraseña real que se almacena en el buffer `realpass`.

---

### Ejercicio 5

La siguiente función se utiliza para verificar la contraseña del usuario actual **user** en el programa que desbloquea la sesión luego de activarse el protector de pantalla del sistema. El usuario ingresa la misma por teclado.

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

* `void load_pass_from(buf, buf_size, salt, user, file)` lee del **file** la contraseña del **user** y la almacena en el **buff** escribiendo a los sumo **buf_size - 1** y el caracter nulo, guarda ademas el **salt** el cual el valor de los caracteres que se usaron para incriptar la contraseña en **file**, si no encuentra al usuario se genera un contraseña invalida en **buf** no encontrable por **crypt**

* `char* crypt(pass, salt)` devuelve la contraseña **pass** encriptada usando el valor **salt**.

* `/etc/shadow` almacena información sensible del sistema y un usuario común no tiene acceso a este archivo, solo el root o los que esten en el grupo **shadow**.

### a)

El mecanismo que le permite a un usuario normal tener acceso momentáneo a `/etc/shadow` es la función `setuid`.

Los procesos tienen dos `uid`: el real, que es el del usuario que inició el proceso, y el efectivo, que indica qué permisos tiene actualmente el proceso y puede irse modificando.

`setuid` puede cambiar el `effective id`, haciendo que el owner de este proceso sea `root` para poder tener acceso a `/etc/shadow`.

El sistema le puede dar momentáneamente acceso a `/etc/shadow` y, una vez que se termina de hacer el proceso del `login`, se le degradan los permisos al proceso, haciendo que pierda los privilegios de `root`.

---

### b)

Esta función tiene problemas de seguridad debido a que se usa el famoso `gets`. Como `gets` no deja de leer hasta que se ingrese un `\n` o un `EOF`, podemos producir un **stack buffer overflow**

Entonces por el orden secuencial del programa el usuario mediante un string de 384 bytes va a tener acceso a `realpass` y `salt`, si se invirtiera el orden en el que se pide el input, entonces no tendriamos el problema de la contraseña, pero si podria sobreescribir la direccion de retorno de la funcion `bool check_pass(const char *user)`.

Por lo tanto el usuario tiene acceso tanto a la direccion de retorno del programa como a todas las variables locales de la funcion.

---

### c) 

Sí, compromete la integridad del sistema completo.Aunque los usuarios que ejecutan el programa ya cuenten con acceso a una terminal, para que la función pueda leer el archivo sensible `/etc/shadow` el binario ejecutable debe tener configurado el bit setuid perteneciente a `root`. Por lo tanto, el proceso se ejecuta con privilegios efectivos de superusuario (`EUID = 0`).

Dado que la función `gets(pass)` introduce un desbordamiento de búfer en el stack sin límite de tamaño, un usuario no solo puede manipular las variables locales para saltear la autenticación, sino que puede **sobrescribir la dirección de retorno de la función** `check_pass` (Saved Instruction Pointer).

Esto permite desviar el flujo de ejecución hacia código inyectado (shellcode) o utilizar técnicas como Return-to-libc para invocar una shell (por ejemplo `/bin/sh`). Como el proceso retiene los privilegios efectivos de `root`, la shell resultante se ejecutará con permisos de superusuario, permitiendo **una escalada local de privilegios (Privilege Escalation)** total que vulnera por completo la seguridad del sistema operativo.