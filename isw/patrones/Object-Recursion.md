# Resumen del Paper: El Patrón Object Recursion
**Autor:** Bobby Woolf (1998)

---

### 1. Intención y Otros Nombres
* **Intención:** Distribuir el procesamiento de una solicitud sobre una estructura delegando polimórficamente. *Object Recursion* permite, de forma transparente, que una solicitud se divida sucesivamente en partes más pequeñas que son más fáciles de manejar.
* **También conocido como:** *Recursive Delegation* (Delegación Recursiva).

---

### 2. Motivación y Diagnóstico
Surge de la necesidad de determinar si dos objetos son equivalentes. Mientras que para objetos simples y primitivas basta con operaciones nativas, comparar objetos complejos arbitrarios resulta difícil.

#### Comparación con el enfoque "Comparador Externo":
Un primer enfoque ingenuo es usar un objeto externo **Comparador** que reciba dos objetos complejos, los descomponga en partes y los compare. Este enfoque presenta serias desventajas:
* El comparador debe conocer la estructura interna y el tipo de los objetos, rompiendo el **encapsulamiento**.
* Cuanto más complejo es el objeto, más complejo y frágil es el código del comparador.
* Cada nueva clase exige modificar o extender el comparador.
* Si la implementación del objeto cambia, el comparador se rompe.

#### La Solución con Object Recursion:
Un enfoque orientado a objetos es pedirle al objeto que se compare a sí mismo con otro. El objeto compara sus partes delegando sucesivamente en cada una de ellas, haciendo que el mensaje navegue por la estructura enlazada hasta llegar a objetos primitivos simples.

---

### 3. Claves y Aplicabilidad

#### Claves del Patrón:
1. **Dos clases polimórficas:** Una maneja la consulta de forma recursiva (`Recurser`) y otra maneja el caso base de forma directa sin recursión (`Terminator`).
2. **Mensaje de inicio separado:** Un mensaje separado, situado usualmente en una tercera clase no polimórfica (`Initiator`), para iniciar la consulta.

#### Aplicabilidad:
* Cuando se pasa un mensaje por una estructura enlazada con destino final desconocido.
* Cuando se envían mensajes a todos los nodos de una estructura enlazada.
* Cuando se distribuye la responsabilidad de un comportamiento a lo largo de una estructura enlazada.

---

### 4. Estructura y Participantes

```
  Initiator (Cliente) ----> <<Handler>> (Comparable)
       makeRequest()            handleRequest()
                                /            \
                               /              \
                    Recurser (Motor)       Terminator (Integer)
                    successor.handleRequest()   [handle directly]
```

* **`Initiator` (Cliente):** Inicia la solicitud mediante `makeRequest()`. Su mensaje **no es polimórfico** con la jerarquía de recursión.
* **`Handler` (`Comparable`):** Interfaz o clase abstracta común que declara el protocolo para manejar la solicitud (`handleRequest()`).
* **`Recurser` (`Engine` / Motor):** Implementación de `Handler` que ejecuta procesamiento local (`preHandleRequest()` / `postHandleRequest()`) y delega recursivamente el resto a sus sucesores.
* **`Terminator` (`Integer`):** Implementación de `Handler` que resuelve la solicitud de forma directa sin delegar a ningún sucesor, marcando el fin de la recursión.

---

### 5. Colaboración
1. El `Initiator` solicita el procesamiento enviando el mensaje inicial a su `Handler` (`makeRequest()`).
2. Si el `Handler` es un `Recurser`, ejecuta su trabajo local, invoca a su sucesor (`successor.handleRequest()`) y retorna un resultado combinado. Si tiene múltiples sucesores, delega en cada uno secuencial o asincrónicamente.
3. Si el `Handler` es un `Terminator`, resuelve la solicitud directamente y devuelve el resultado sin realizar delegaciones.

---

### 6. Consecuencias

#### Ventajas:
* **Procesamiento distribuido:** La solicitud se divide a lo largo de una red de manejadores tan compleja como sea necesario.
* **Flexibilidad en las responsabilidades:** El `Initiator` ignora la cantidad, organización y distribución de los manejadores. La estructura se puede reconfigurar dinámicamente en tiempo de ejecución.
* **Flexibilidad de roles:** Un objeto puede actuar como `Recurser` para un mensaje y como `Terminator` para otro.
* **Aumento del encapsulamiento:** Encapsula las decisiones de procesamiento dentro de cada objeto participante.

#### Desventajas:
* **Complejidad de programación:** La recursividad orientada a objetos puede volver al sistema más difícil de entender, rastrear y mantener si se sobreutiliza.

---

### 7. Detalles de Implementación

1. **Tipos separados del Initiator:** El mensaje `Initiator.makeRequest()` no debe ser polimórfico con `Recurser.handleRequest()`. Esto evita que el método sea eliminado por refactorizaciones automáticas al asumir erróneamente que solo se invoca a sí mismo.
2. **Definición del sucesor:** Solo el `Recurser` necesita referencias activas a sus sucesores. Si el `Terminator` hereda la variable de sucesor de `Handler`, esta permanece en `null`.

---

### 8. Código de Ejemplo (Igualdad Recursiva)

```java
// Caso Base / Terminator: String
public class String {
    public boolean equals(String anotherString) {
        // Comparación de caracteres primitivos
    }
}

// Recurser Nivel 1: NombreDePersona
public class NombreDePersona {
    private String nombre, apellido;

    public boolean equals(NombreDePersona otro) {
        return nombre.equals(otro.nombre) && apellido.equals(otro.apellido);
    }
}

// Recurser Nivel 2: EntradaDeGuia
public class EntradaDeGuia {
    private NombreDePersona nombre;

    public boolean equals(EntradaDeGuia otraEntrada) {
        return nombre.equals(otraEntrada.nombre);
    }
}
```

---

### 9. Usos Conocidos
* **Igualdad y Hashing:** Comparación recursiva de objetos complejos delegando en sus partes hasta llegar a primitivas.
* **Clonación y Copia:** Uso de `copy()` con dos mensajes (`simpleCopy()` y `postCopy()`) para propagar la copia en profundidad.
* **Serialización de Objetos:** Conversión recursiva de un objeto y sus partes persistentes a formato binario o texto.
* **Representación como Cadena (`toString()` / `printString`):** Formateo del estado base y delegación a sus componentes.
* **Estructuras de Árbol e Interfaces Gráficas:** Transmisión de eventos, invalidación de regiones y redibujado desde las hojas hasta la raíz o viceversa.

---

### 10. Patrones Relacionados
* **Composite y Decorator:** Son patrones **estructurales** donde la recursión suele ser explícita en solo un nivel. *Object Recursion* es un patrón **comportamental/algorítmico** de profundidad ilimitada.
* **Chain of Responsibility:** Contiene *Object Recursion* para navegar por la cadena o árbol buscando un manejador adecuado.
* **Interpreter:** El mensaje `interpret()` recorre el árbol de sintaxis abstracta utilizando *Object Recursion* (`Client` = `Initiator`, `AbstractExpression` = `Handler`, `NonterminalExpression` = `Recurser`, `TerminalExpression` = `Terminator`).
* **Iterator:** Los iteradores internos en estructuras enlazadas o ramificadas emplean *Object Recursion*.
* **Adapter / Proxy:** Cadenas de Adapters o Proxies representan formas de delegación a un nivel de profundidad.
