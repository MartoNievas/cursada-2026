### The Power Of Simplicity

#### Abstract del paper
**SELF** es un lenguaje orientado a objetos diseñado para la programación exploratoria. Destaca por su enfoque minimalista, basado en ideas simples y concretas: prototipos, ranuras (*slots*) y comportamiento. Al utilizar prototipos, fusiona la herencia y la instanciación en un marco más flexible. Las ranuras unifican variables y procedimientos en una sola estructura, permitiendo que la herencia maneje el ámbito léxico. Finalmente, al no hacer distinción entre estado y comportamiento, **SELF** reduce drásticamente las diferencias estructurales entre objetos, procedimientos y cierres léxicos (*closures*), ofreciendo un modelo computacional mucho más directo y expresivo.

---

#### Introducción
En este *paper* se define **SELF**, un lenguaje basado en prototipos diseñado para soportar la programación exploratoria. Por su naturaleza, incluye tipado en tiempo de ejecución (sin declaraciones de tipos) y recuperación automática de memoria (*garbage collection*).

A diferencia de **Smalltalk** (el cual sirve como punto de referencia común), **SELF** no incluye clases ni variables. En su lugar, adopta una metáfora de prototipos para la creación de objetos. Además, mientras que la mayoría de los lenguajes soportan el acceso directo a variables además del paso de mensajes, los objetos en **SELF** acceden a su información de estado única y exclusivamente mediante mensajes enviados a *self*. Naturalmente, esto provoca un flujo constante de mensajes dirigidos a la propia instancia, por lo que el lenguaje fue bautizado en honor a estos mensajes.

---

#### Conceptos Clave
A continuación se detallan los principios de diseño que guían el desarrollo de **SELF**:

*   **Mensajes en el nivel más bajo (*Messages-at-the-bottom*):** **SELF** presenta el paso de mensajes como la operación fundamental. Proporciona acceso al estado almacenado única y exclusivamente mediante mensajes. No existen variables tradicionales, sino simplemente ranuras (*slots*) que contienen objetos que se devuelven a sí mismos al ser evaluados.
*   **La navaja de Ockham (*Occam’s razor*):** Fiel a la economía conceptual, **SELF** omite las clases y las variables. Cualquier objeto puede actuar como una instancia individual o servir como un repositorio de información compartida. No hay distinción alguna entre acceder a una variable y enviar un mensaje. El núcleo (*kernel*) del lenguaje carece de estructuras de control; todo el flujo se modela de manera elegante utilizando **polimorfismo** y **clausuras** (*closures*). Además, los objetos y procedimientos se tejen con el mismo hilo al representar los procedimientos como prototipos de registros de activación.
*   **Concreción:** **SELF** intenta ser lo más concreto y tangible posible, rechazando descripciones abstractas. Mientras que en los lenguajes basados en clases un objeto se crea instanciando un "plano" o plano abstracto, en un lenguaje basado en prototipos como **SELF** un objeto nuevo se crea clonando (copiando) un prototipo existente. Absolutamente cualquier objeto del sistema puede ser clonado.

---

#### Prototipos vs. Clases
Siguiendo con la filosofía de simplicidad, **SELF** carece de un puntero a clase (*class pointer*), algo habitual en otros lenguajes orientados a objetos como Smalltalk, C++, Ada, etc..

En su lugar, un objeto en **SELF** contiene ranuras con nombre (*named slots*) que pueden almacenar tanto estado (datos) como comportamiento (métodos). Si un objeto recibe un mensaje y no encuentra una ranura coincidente, la búsqueda continúa a través de un puntero al padre (*parent pointer*, indicado convencionalmente con un asterisco, como `parent*`). Es de esta manera que **SELF** implementa la **herencia**, permitiendo compartir comportamiento y alterar la conducta de muchos objetos con un solo cambio.

La eliminación de las clases permite tener relaciones mucho más simples. En lugar de lidiar con dos tipos de relaciones diferentes ("es una instancia de" y "es una subclase de"), en un sistema basado en prototipos existe una única relación estructural entre los objetos: la relación **"hereda de"** (*inherits from*).

Este enfoque presenta cuatro ventajas fundamentales frente a los lenguajes basados en clases:

1.  **Creación por copia:** Crear objetos clonando es una metáfora biológica mucho más simple y directa que la instanciación basada en interpretar un plano abstracto de construcción.
2.  **Módulos preexistentes más concretos:** Los prototipos son ejemplos vivos, reales y funcionales que el programador puede examinar directamente en busca de un representante típico, en lugar de descripciones conceptuales y abstractas de inicialización, lo que facilita enormemente su comprensión y reutilización.
3.  **Soporte natural para objetos únicos (*one-of-a-kind*):** Al poder tener ranuras con su propio comportamiento específico, se pueden crear y personalizar objetos únicos (como los booleanos `true` y `false`) sin la incomodidad de tener que definir una clase entera para una sola instancia.
4.  **Fin de la meta-regresión:** En los sistemas basados en clases, un objeto necesita una clase para existir, que a su vez necesita una metaclase, y así *ad infinitum*. Los prototipos rompen este ciclo infinito al ser objetos completamente autosuficientes que contienen su propio comportamiento y estructura.

**El problema del prototipo especial:** Si el comportamiento compartido se guardara en el mismo prototipo, el sistema necesitaría dos formas de crear objetos: una para crear descendientes que hereden de él y otra para copiar objetos que no son prototipos, volviendo a los prototipos objetos "especiales" y rompiendo la uniformidad. La solución de **SELF** es extraer el comportamiento compartido y colocarlo en un objeto padre separado (llamado *traits*). De esta manera, el prototipo es absolutamente idéntico a cualquier otro miembro de su familia, y el objeto de comportamiento compartido actúa de forma similar a una clase, pero sin contener información de representación, solo de comportamiento.

---

#### Unificando Estado y Comportamiento
Para sostener la idea de que no existen variables tradicionales, en **SELF** todo acceso a la información se realiza enviando mensajes a las ranuras. 

Por ejemplo, para leer una coordenada, el objeto se envía a sí mismo el mensaje `x`. Para modificarla, se envía el mensaje `x:` seguido del nuevo valor. Esto se implementa incluyendo una ranura llamada `x:` que contiene una primitiva de asignación (representada por `!`). La elisión sintáctica del receptor *self* permite que esta manipulación sea tan compacta como en cualquier otro lenguaje.

Esta unificación de acceso aporta beneficios operativos enormes:

*   **Transparencia:** Leer un valor estático almacenado o calcular dinámicamente un resultado se ve exactamente igual desde la sintaxis del código que lo invoca. El emisor del mensaje no necesita saber cómo se obtiene la información.
*   **Flexibilidad extrema:** Permite reemplazar un dato estático por código ejecutable en tiempo real sin romper la compatibilidad con otros objetos. Por ejemplo, se puede tomar un punto, eliminar su ranura de escritura `x:` y cambiar la ranura de lectura `x` para que ejecute un generador de números aleatorios. Todo el código heredado seguirá funcionando perfectamente.
*   **Variables Activas y Demonios (*Active variables and dæmons*):** Facilita la interceptación de la lectura o escritura de un dato (por ejemplo, reemplazando el mensaje de asignación `x:` por un método que lance un punto de interrupción o *breakpoint*), algo muy complejo de lograr de manera limpia en lenguajes convencionales.
*   **Compartición de estado (*Shared state*):** Permite que múltiples objetos compartan variables físicas reales ubicando las ranuras de lectura y escritura en un objeto padre común a ambos objetos.

---

#### Clausuras y Métodos
En **SELF**, las clausuras (*closures*) se representan mediante un objeto que contiene un enlace de entorno (*environment link*) y un método llamado `value`, `value:`, `value:With:`, etc., dependiendo de la cantidad de argumentos.

*   **Variables locales:** En **SELF**, las ranuras (*slots*) de un registro de activación cumplen esta función. Los objetos que representan métodos son, de hecho, prototipos de registros de activación que se copian (clonan) e invocan para ejecutar la subrutina. Por lo tanto, las variables locales se asignan reservando ranuras para ellas en el prototipo de activación, permitiendo que se inicialicen con cualquier valor, incluidos métodos privados y otras clausuras.
*   **Enlace de entorno (*Environment link*):** Los métodos deben contener un enlace a su ámbito envolvente para resolver las variables no locales. En **SELF**, el puntero al padre (`parent*`) del registro de activación realiza esta función de enlace de entorno. Si una ranura no se encuentra en el ámbito actual, la búsqueda continúa por el puntero al padre hacia el ámbito léxico exterior.
*   **Ámbito léxico y el *self* implícito:** Para acceder a las variables locales y de instancia con la misma sintaxis, la búsqueda de mensajes de un *self* implícito inicia en el registro de activación actual, pero el receptor del mensaje (el contexto de ejecución principal) se mantiene como el receptor original. Esto es conceptualmente opuesto al constructo `super` de Smalltalk, el cual empieza la búsqueda en la superclase pero mantiene el receptor original.

---

#### Especulación y Filosofía de SELF
El diseño de **SELF** conduce a temas filosóficos recurrentes sobre la naturaleza de la computación orientada a objetos:

*   **Conductismo (*Behaviorism*):** En la mayoría de los lenguajes, los objetos son pasivos; un objeto "es lo que es". En **SELF**, un objeto **es lo que hace**. Debido a que el acceso a variables es idéntico al paso de mensajes, los objetos pasivos ordinarios pueden verse simplemente como métodos que siempre se devuelven a sí mismos al ser evaluados. Por ejemplo, el número `17` no representa un estado inmutable pasivo, sino un objeto que responde a mensajes aritméticos comportándose de cierta manera y devolviéndose a sí mismo.
*   **Computación como Refinamiento (*Computation viewed as refinement*):** En lugar de ver los objetos como datos utilizados por métodos, en **SELF** la activación de un método se puede interpretar como la creación de un refinamiento de corta vida del receptor (ya que el padre del registro de activación temporal apunta directamente al receptor del mensaje). De manera similar, la activación de un bloque crea un refinamiento temporal del registro de activación del contexto léxico envolvente.
*   **Padres como partes compartidas (*Parents viewed as shared parts*):** Los punteros a padres pueden interpretarse como componentes compartidos del objeto. Desde este punto de vista, un punto de **SELF** contiene una parte privada (sus ranuras `x` e `y`), una parte compartida con otros puntos (las operaciones matemáticas de su traits) y una parte compartida con todos los objetos (el comportamiento común de clonación en la raíz).

---

#### Sintaxis de SELF
Para representar los objetos textualmente, **SELF** introduce una sintaxis concisa y elegante que reduce el ruido visual:

*   **Estructura de un objeto:** Los objetos se escriben encerrados entre paréntesis y opcionalmente contienen una lista de ranuras encerrada entre barras verticales `| ... |`. Si es un método, el código se escribe después de las barras. Los bloques (*blocks*) se escriben de igual forma pero entre corchetes `[ ... ]`.
*   **Definición de ranuras (*slots*):** Las ranuras se separan por puntos (el punto final es opcional). Existen diferentes formas de declararlas:
    *   `x`: Define dos ranuras. Una ranura de lectura `x` inicializada en `nil`, y una ranura de escritura `x:` inicializada con la primitiva de asignación (`!`). Es el equivalente a declarar una variable de Smalltalk.
    *   `x <– expr`: Define dos ranuras. Una de lectura `x` inicializada con el valor de la expresión, y una de escritura `x:` con la primitiva de asignación (`!`).
    *   `x = expr`: Define una **única ranura de solo lectura** `x` inicializada con el valor de la expresión. Se utiliza típicamente para definir constantes, métodos y enlaces a padres (`parent* = ...`).
    *   `:arg`: Define una ranura de argumento que se asocia al parámetro del mensaje correspondiente.
*   **Reglas sintácticas de los mensajes:**
    *   Se omite el receptor cuando este es el *self* implícito.
    *   El valor de retorno de un método es siempre el resultado de la última expresión evaluada.
    *   Los mensajes de palabras clave (*keyword messages*) se asocian de derecha a izquierda.
    *   Se utiliza capitalización (*case-sensitivity*) para facilitar la lectura de múltiples palabras clave: la primera palabra va en minúsculas y las subsiguientes en mayúsculas (por ejemplo, `display:At:`).

---

#### Ejemplos de Código (El Poder Práctico de SELF)

##### 1. Implementación de un Punto (*Point*)
El siguiente código (basándose en primitivas del sistema como `_AddSlotsIfAbsent:` y `_Define:`) muestra cómo se estructuran las cualidades compartidas (*traits*) y los prototipos de puntos en un sistema **SELF** real:

```self
"1. Agregamos las categorías básicas al sistema si no existen"
_AddSlotsIfAbsent: ( | 
    traits = ().       "Contenedor para objetos traits (comportamiento compartido)"
    prototypes* = ().  "Contenedor para prototipos (padre de referencia)"
| )

"2. Definimos traits clonable, que contiene la capacidad de copia básica"
traits _AddSlotsIfAbsent: ( | clonable = () | )
traits clonable _Define: ( |
    copy = ( _Clone ). "Invoca la primitiva interna de clonación"
| )

"3. Definimos traits point, que hereda de clonable y añade comportamiento matemático"
traits _AddSlotsIfAbsent: ( | point = () | )
traits point _Define: ( |
    parent* = traits clonable. "Hereda la capacidad de copia"
    
    "Construye una representación textual"
    printString = ( x printString, '@', y printString ).
    
    "Suma de puntos: asignación x: e y: retorna self por convención"
    + aPoint = ( | newPoint |
        newPoint: copy.
        newPoint x: x + aPoint x.
        newPoint y: y + aPoint y.
        newPoint
    ).
    
    "Resta de puntos reduciendo la sintaxis aprovechando que la asignación retorna self"
    – aPoint = ( (copy x: x – aPoint x) y: y – aPoint y ).
| )

"4. Definimos el objeto prototipo point con variables inicializadas en 0"
prototypes _AddSlotsIfAbsent: ( | point = () | )
prototypes point _Define: ( |
    parent* = traits point. "Hereda el comportamiento compartido"
    x <– 0.                 "Ranura de lectura x y escritura x:"
    y <– 0.                 "Ranura de lectura y y escritura y:"
| )

"5. Añadimos un atajo sintáctico a los enteros para crear puntos con @"
traits integer _AddSlots: ( |
    @ y = ( (point copy x: self) y: y ).
| )
```

##### 2. El Árbol Binario y Herencia Dinámica
Este ejemplo muestra una de las características más sorprendentes de **SELF**: el uso de la **herencia dinámica** para cambiar el comportamiento de un objeto en tiempo de ejecución modificando su puntero padre:

```self
"Definimos el traits de un árbol vacío"
traits _AddSlotsIfAbsent: ( | emptyTree = () | )
traits emptyTree _Define: ( |
    parent* = traits clonable.
    includes: x = ( false ). "Un árbol vacío nunca contiene elementos"
    
    "Al insertar un elemento, el árbol vacío muta dinámicamente"
    insert: x = ( 
        parent: treeNode copy contents: x 
    ).
    size = 0.
    do: aBlock = ( self ).
| )

"El prototipo del árbol se inicializa apuntando a emptyTree como padre"
prototypes _AddSlotsIfAbsent: ( | tree = () | )
prototypes tree _Define: ( |
    parent* <– traits emptyTree. "Padre asignable (permite herencia dinámica)"
| )

"Definimos el traits de un nodo con contenido"
traits _AddSlotsIfAbsent: ( | treeNode = () | )
traits treeNode _Define: ( |
    parent* = traits clonable.
    
    includes: x = ( | subT |
        x = contents ifTrue: [^true].
        subT: x < contents ifTrue: [left] False: [right].
        subT includes: x
    ).
    
    insert: x = ( | subT |
        x = contents ifTrue: [^self].
        subT: x < contents ifTrue: [left] False: [right].
        subT insert: x.
        self
    ).
    size = ( left size + 1 + right size ).
    do: aBlock = (
        left do: aBlock. 
        aBlock value: contents. 
        right do: aBlock. 
        self
    ).
    copy = ( (resend.copy left: left copy) right: right copy ).
| )

"Definimos el prototipo de un nodo de árbol"
prototypes _AddSlotsIfAbsent: ( | treeNode = () | )
prototypes treeNode _Define: ( |
    parent* = traits treeNode.
    left <– tree.     "Ranuras inicializadas con árboles vacíos"
    right <– tree.
    contents.         "Ranura de datos inicializada en nil"
| )
```

*Nota de herencia dinámica:* Cuando llamamos a `insert:` en un objeto `tree` cuyo padre es `traits emptyTree`, el método `insert:` redefine el puntero padre (`parent`) del árbol para que ahora sea un clon del `treeNode` con el dato insertado. A partir de ese momento, el árbol hereda automáticamente todo el comportamiento complejo de nodos y subbúsquedas sin haber requerido una reconstrucción de la estructura.

---

#### Conclusión
**SELF** ofrece una síntesis brillante de simplicidad conceptual y expresividad. Al demostrar que componentes supuestamente fundamentales como las clases y las variables no son necesarios, el lenguaje elimina la regresión de las metaclases, disuelve la barrera ficticia entre instanciación y herencia, y unifica objetos, métodos y clausuras en un modelo coherente.

Sin embargo, esta simplificación extrema genera una tensión inherente: al reducir la variedad de constructos lingüísticos, también disminuyen las pistas visuales e informacionales sobre la estructura general del sistema, delegando en el entorno de desarrollo la responsabilidad de proveer herramientas de navegación y organización. En última instancia, **SELF** demuestra que limitar los conceptos en el núcleo del lenguaje no reduce su poder, sino que expande su flexibilidad para permitir que el programador descubra o diseñe sus propias metáforas computacionales.
