# Resumen del Patrón: State Pattern
**Autores:** Erich Gamma, Richard Helm, Ralph Johnson, John Vlissides (Gang of Four)

---

## 1. Intención

Permite que un objeto altere su comportamiento cuando su estado interno cambia. Pareciera que el objeto cambia de clase.

Es también conocido como **Objects for States**.

## 2. Motivación

En el libro se menciona la clase `TCPConnection` la cual representa una conexión de red, la cual puede tener varios estados distintos y cuando la misma recibe una solicitud de otro objeto, responde de manera diferente según sea su estado actual.

La idea clave del patrón es introducir una clase abstracta llamada `TCPState` se puede generalizar a cualquier objeto que tenga estados distintos, esta clase representa los estados de la conexión en este caso, la misma también define una interfaz común, para que las subclases puedan implementar un comportamiento específico `TCPClosed`, `TCPEstablished`, etc.

La clase `TCPConnection` mantiene un objeto estado que representa el estado actual de la conexión **TCP**, siempre que la clase `TCPConnection` cambie de estado cambie el objeto estado que tiene almacenado.

Entonces la motivación general del patrón es poder representar/modelar entidades cuyo comportamiento varía según su ciclo de vida operacional, en lugar de tener que utilizar condicionales basados en flags, delegamos las solicitudes que dependen del estado al objeto que lo representa en este caso `TCPState` y se resuelven utilizando polimorfismo.

## 3. Aplicabilidad

Podemos utilizar el patrón en cualquiera de los siguientes casos:

* El comportamiento de un objeto depende de su estado, y debe cambiar su comportamiento en tiempo de ejecución en función de dicho estado.

* Las operaciones tienen estructuras condicionales de gran tamaño que dependen del estado del objeto, donde el estado suele estar representado por una o más constantes enumeradas. El patrón **State** coloca cada rama del condicional en una clase separada.

## 4. Estructura y Participantes

* **Context (`TCPConnection`)**:

    * Define la interfaz de interés para los clientes.
    * Mantiene una instancia de una subclase de `ConcreteState` que define el estado actual.

* **State (`TCPState`):**

    * Define una interfaz para encapsular el comportamiento asociado con un estado particular del `Context`.

* **Subclases de ConcreteState (`TCPEstablished`, `TCPListen`, `TCPClosed`):**

    * Cada subclase concreta implementa un comportamiento asociado con un estado de `Context`.

## 5. Colaboraciones

* `Context` delega las solicitudes dependientes del estado al objeto `ConcreteState` actual.
* Un contexto puede pasarse a sí mismo como argumento al objeto State que maneja la solicitud. Esto permite al objeto de estado acceder al contexto si es necesario.
* `Context` es la interfaz principal para los clientes, los mismos pueden configurar el contexto con objetos `State`.
* Tanto `Context` como las subclases de `ConcreteState` pueden decidir qué estado sucede a otro y bajo qué circunstancias se lleva a cabo la transición.

## 6. Consecuencias

Las ventajas y desventajas que presenta el patrón **State** son:

1. Localiza el comportamiento específico de cada estado y particiona el comportamiento para estados diferentes, esto facilita el agregar nuevos estados ya que es tan fácil como agregar una subclase de `TCPState`, además evita código repetido.

2. Hace explícitas las transiciones de estado, cuando se utilizan valores de variables internas, no hay una representación explícita; sino que simplemente se reduce a una asignación de variables, al introducir objetos separados se vuelven explícitas y protege a `Context` de estados inconsistentes, debido a que las transiciones son atómicas.

3. Los objetos de estado pueden ser compartidos, si estos mismos no contienen variables, los contextos pueden compartir un mismo objeto `State`. Cuando el estado se comparte de este modo, tales objetos son esencialmente Flyweights sin estado intrínseco, sino únicamente comportamiento.

## 7. Implementación

Como primera pregunta aparece **¿Quién define las transiciones de estado?**. El patrón no dicta qué participante define los criterios para las transiciones de estado. Podrían implementarse enteramente en `Context`, pero suele ser más modular y flexible permitir que las subclases de `State` seleccionen su sucesor y cuándo deben realizar la transición.

### Criterios y Alternativas de Diseño

#### 1. Transiciones centralizadas en `Context`
* **Mecanismo:** El `Context` evalúa internamente las condiciones tras delegar una acción y reasigna directamente su propia variable de referencia de estado.
* **Ventajas:**
  * Las subclases de `State` se mantienen completamente desacopladas e independientes entre sí, ya que ninguna necesita conocer a sus hermanas.
* **Desventajas:**
  * Si los criterios son dinámicos o complejos, la lógica de transición suele degenerar en condicionales (`switch` o `if-else`), reintroduciendo en el `Context` el problema que el patrón buscaba eliminar.

#### 2. Transiciones descentralizadas en las subclases de `State`
* **Mecanismo:** Cada subclase de `ConcreteState` encapsula las reglas de transición específicas de su estado.
  * Para efectuar el cambio, el `Context` se pasa a sí mismo como argumento (por ejemplo, en las operaciones dependientes de estado).
  * El `Context` debe proveer una interfaz explícita (como un método protegido o público `changeState:`) que permita a los objetos `State` reasignar el estado actual del contexto.
* **Ventajas:**
  * **Modularidad y extensibilidad:** Se elimina la lógica condicional en `Context`; agregar nuevos estados o modificar reglas existentes solo involucra editar o agregar subclases de `State`.
* **Desventajas (*Trade-off*):**
  * **Acoplamiento entre subclases hermanas:** Cada subclase de `State` debe conocer e instanciar (o referenciar) a la siguiente subclase concreta a la cual transiciona, introduciendo dependencias de compilación entre ellas.

---

### Otras Consideraciones Clave de Implementación

* **Alternativa basada en tablas (*Table-driven*):** Se pueden mapear transiciones mediante tablas de búsqueda estáticas que asocien entradas con estados siguientes. Esto independiza las reglas del código, pero suele ser menos eficiente, vuelve la lógica opaca y dificulta asociar acciones de cómputo arbitrarias a cada transición en comparación con el polimorfismo puro.
* **Creación y destrucción de objetos `State`:**
  * *Bajo demanda:* Se instancian únicamente al transicionar y se destruyen al salir, ahorrando memoria si no todos los estados se visitan.
  * *Instanciación previa:* Se crean una única vez y se reutilizan, eliminando el sobrecosto de asignación dinámica si las transiciones son de alta frecuencia. Si no manejan variables de instancia (estado intrínseco), se modelan típicamente como *Singletons* o *Flyweights*.
* **Uso de delegación explícita:** En lenguajes de objetos puros, la delegación se materializa pasando `self` como colaborador en las llamadas al estado, garantizando que el `Context` conserve su identidad mientras delega el comportamiento reactivo.