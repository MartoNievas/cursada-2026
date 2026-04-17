# Taller: Syscalls y Señales

## Ejercicio 1

[Ver código](src/ejercicio1.c)

## Ejercicio 2

### Conclusión del análisis de ejecución (strace)

Al ejecutar el programa, se observa la creación de dos procesos: el **padre (PID 44751)** y el **hijo (PID 44752)**. El comportamiento que presentan es un intercambio coordinado ("zig-zag") con las siguientes características:

- **Intercambio de mensajes:** El proceso **padre** toma la iniciativa imprimiendo **"sup!"** y luego aguarda un segundo. El proceso **hijo** responde a la acción del padre imprimiendo **"ya va!"**.
- **Repetición y cambio de flujo:** Este intercambio se repite cuatro veces. Tras la última respuesta, el hijo interrumpe la espera del padre para notificarle que procederá a la ejecución del comando solicitado.
- **Búsqueda y ejecución:** El hijo realiza una búsqueda en los directorios del sistema hasta encontrar el binario correspondiente al parámetro (en este caso, `/usr/bin/echo`). Una vez localizado, el proceso hijo reemplaza su propia imagen en memoria por la del comando para imprimir el texto **"imprimir este texto"**.
- **Finalización:** El proceso padre permanece a la espera de que el hijo termine su tarea. Una vez que el comando `echo` finaliza con éxito, el padre retoma el control por un instante para confirmar el cierre ordenado de ambos procesos.

### IPC en los procesos

Estos procesos utilizan señales para mantenerse comunicados entre sí y recibir una respuesta ante un evento. Se utilizan las siguientes señales:

- **SIGURG:** La envía el padre al hijo para avisarle que debe responder al "sup!".
- **SIGINT:** La envía el proceso hijo al padre para despertarlo del `sleep()`, comunicando así que ya terminaron las rondas y que procederá a ejecutar el comando final.
- **SIGCHLD:** La envía el **SO** en nombre del hijo para avisar al padre que su ejecución terminó.

### Información del strace

Lo que podemos deducir a partir del strace es la forma de comunicación, las señales utilizadas y cómo se gestiona la creación de procesos.

## Ejercicio 3

[Ver código](src/hai.c)
