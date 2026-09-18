# El Patrón Object Recursion
**Autor: Bobby Woolf (1998)**

## Intención
Distribuir el procesamiento de una solicitud sobre una estructura delegando polimórficamente. Object Recursion permite, de forma transparente, que una solicitud se divida varias veces en partes más pequeñas que son más fáciles de manejar.

## También conocido como
Recursive Delegation (Delegación Recursiva).

## Motivación
Surge de la necesidad de determinar si dos objetos son equivalentes. Mientras que para objetos simples y primitivas basta con operaciones nativas, comparar objetos complejos arbitrarios resulta difícil.

Un primer enfoque es usar un objeto externo **Comparador** que acepte dos objetos complejos, los divida en partes y compare cada parte. Sin embargo, este enfoque presenta desventajas importantes:
* El comparador debe reconocer qué tipo de objeto son los sujetos y saber cómo descomponerlos.
* Cuanto más complejo es un sujeto, más complejo se vuelve el código para compararlo.
* Cada nueva clase exige modificar o extender el comparador.
* La descomposición depende fuertemente de la implementación, por lo que si esta cambia, el comparador también debe modificarse.
* Los objetos comparados deben exponer protocolos adicionales para la descomposición, lo que rompe su encapsulamiento.

**Object Recursion** resuelve esto mediante un algoritmo donde un objeto se compara a sí mismo con otro, diciéndole a sus partes que se comparen entre sí sucesivamente, delegando la responsabilidad a lo largo de la estructura enlazada.

## Características
Un sistema que incorpora el patrón **Object Recursion** tiene las siguientes características:
* Dos clases polimórficas: una maneja la consulta recursivamente (**Recurser**) y otra simplemente maneja el caso base sin recursión (**Terminator**).
* Un mensaje separado, usualmente en una tercera clase no polimórfica (**Initiator**), para iniciar la consulta.

## Aplicabilidad
Este patrón se puede usar cuando:
* Estamos pasando un mensaje por una estructura enlazada donde el destino final es desconocido.
* Estamos enviando mensajes a nodos de una estructura enlazada.
* Queremos distribuir la responsabilidad de un comportamiento a lo largo de una estructura enlazada.

## Participantes y Estructura
* **Initiator**: Inicia la solicitud pidiendo a su Handler que la maneje (makeRequest()). Su mensaje no es polimórfico con la jerarquía de recursión.
* **Handler**: Interfaz o clase abstracta común que declara el protocolo para manejar la solicitud (handleRequest()).
* **Recurser**: Implementación de Handler que realiza una parte del trabajo y delega recursivamente el resto a uno o más sucesores. Puede ejecutar comportamiento adicional antes (preHandleRequest()) y/o después (postHandleRequest()) de delegar.
* **Terminator**: Implementación de Handler que resuelve la solicitud de forma directa sin delegar a ningún sucesor, marcando el fin de la recursión.

## Colaboración
1. El **Initiator** solicita el procesamiento enviando el mensaje inicial a su Handler (makeRequest()).
2. Cuando el **Handler** es un **Recurser**, ejecuta su procesamiento local, le pide a su sucesor (otro Handler) que maneje la solicitud y devuelve un resultado derivado de la respuesta del sucesor. Si tiene múltiples sucesores, delega a cada uno por turnos o de forma asincrónica.
3. Cuando el **Handler** es un **Terminator**, maneja la solicitud por completo sin delegarla a ningún sucesor y devuelve el resultado directo (si lo hubiera).

## Consecuencias

**Ventajas**
* **Procesamiento distribuido**: La solicitud se distribuye a lo largo de una estructura de handlers tan compleja como sea necesaria para completar la tarea.
* **Flexibilidad en las responsabilidades**: El Initiator no necesita conocer cuántos handlers existen, cómo están organizados ni cómo está distribuido el procesamiento. La estructura puede reconfigurarse dinámicamente en tiempo de ejecución.
* **Flexibilidad de roles**: Un objeto puede actuar como Recurser para una solicitud específica y como Terminator para otra.
* **Aumento del encapsulamiento**: Encapsula las decisiones sobre cómo manejar la solicitud dentro del objeto que la procesa.

**Desventajas**
* **Complejidad de programación**: La recursividad, ya sea procedural u orientada a objetos, es un concepto difícil de entender; su sobreuso puede volver al sistema más complejo de entender y mantener.

## Detalles de Implementación
* **Tipos separados del Initiator**: El mensaje Initiator.makeRequest() no debe ser polimórfico con el mensaje Recurser.handleRequest(). Esto evita que los métodos recursivos se eliminen por asumir erróneamente que solo se invocan entre sí, garantizando un punto de entrada explícito.
* **Definir el sucesor**: Solo el Recurser necesita referencias activas a sus sucesores. En el Terminator, si la referencia al sucesor se hereda de Handler, no se utiliza y su valor permanece nulo.

## Ejemplos y Usos Conocidos
* **Igualdad de objetos**: Comparación recursiva donde objetos complejos (como EntradaDeGuia o NombreDePersona) delegan la verificación en sus partes hasta llegar a objetos primitivos o simples (String, Integer, Float, etc.) que actúan como terminadores.
* **Serialización de objetos**: El algoritmo serializa la base del objeto y luego invoca recursivamente la serialización de todas sus partes persistentes hasta llegar a primitivas.
* **Representación como cadena (toString() / printString)**: Muestra la base como una cadena y le pide recursivamente a sus partes relevantes que se muestren a sí mismas.
* **Estructuras de árbol e interfaces gráficas**: Pasaje de mensajes desde las hojas hasta la raíz o de la raíz a las hojas (por ejemplo, en árboles gráficos para registrar pedidos de invalidación o transmitir redibujados).

## Patrones Relacionados
* **Composite y Decorator**: Aunque Composite y Decorator delegan a sus componentes/hijos, son patrones estructurales donde la recursión es explícita en solo un nivel, mientras que en **Object Recursion** (patrón de comportamiento) la profundidad es ilimitada.
* **Chain of Responsibility**: Contiene **Object Recursion** para navegar por una lista enlazada o árbol hasta encontrar un manejador adecuado.
* **Adapter**: Una cadena de Adapters delega comportamiento pero carece de polimorfismo, lo cual va en contra del espíritu de **Object Recursion**.
* **Interpreter**: El mensaje interpret() recorre el árbol de sintaxis abstracta usando **Object Recursion** (Client = Initiator, AbstractExpression = Handler, NonterminalExpression = Recurser, TerminalExpression = Terminator).
* **Iterator**: Algunas implementaciones de iteradores internos en estructuras compuestas utilizan **Object Recursion**.
