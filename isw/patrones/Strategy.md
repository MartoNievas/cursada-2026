# Resumen del Patrón: Strategy Pattern
**Autores:** Erich Gamma, Richard Helm, Ralph Johnson, John Vlissides (Gang of Four)

---

## 1. Intención

Define una familia de algoritmos, encapsula cada uno de ellos y los hace intercambiables. **Strategy** permite que el algoritmo varíe independientemente de los clientes que lo utilizan.

El patrón también es conocido como **Policy**.

## 2. Motivación

La motivación esencial es poder encapsular comportamiento el cual no es esencial a la clase cliente, ya que de otro modo tiene varios inconvenientes, como:

* Los clientes que precisan de ese comportamiento tienen que incorporar el código, lo cual genera código repetido, además hace más difícil de mantener la clase del cliente, sobre todo si tiene múltiples algoritmos/comportamientos.

* No es deseable tener algoritmos/comportamientos diferentes en una misma clase si no se usan de manera concurrente.

* Resulta complejo añadir nuevos comportamientos y alterar los existentes cuando la lógica forma parte de una clase cliente.

Esto se puede evitar encapsulando los distintos algoritmos en clases, a estas clases se las denomina **estrategias**.

Podemos considerar el siguiente ejemplo: tenemos la clase `Composition` que se encarga de mantener y actualizar saltos de línea del texto en un editor. Las estrategias de salto de línea no se implementan dentro de `Composition`, sino que están por separado en subclases mediante la clase abstracta `Compositor`, las subclases se encargan de resolver el algoritmo específico:

* `SimpleCompositor`: Implementa una estrategia simple que calcula un salto de línea a la vez.

* `TeXCompositor`: Implementa el algoritmo de **TeX**.

* `ArrayCompositor`: Implementa una estrategia que determina los cortes de modo que cada fila posea un número fijo de elementos.

Una instancia de `Composition` mantiene una referencia a un objeto `Compositor` y la responsabilidad de formatear el texto se delega al `Compositor` concreto.

## 3. Aplicabilidad

El patrón **Strategy** se puede utilizar en las siguientes situaciones:

* Múltiples clases relacionadas difieren únicamente en su comportamiento. Las estrategias proveen un mecanismo para configurar cada comportamiento.

* Si se requieren múltiples variantes de un algoritmo. Por ejemplo, si tuviéramos diferentes algoritmos de ordenamiento, podríamos tener una jerarquía polimórfica de los mismos que se usen en diferentes situaciones, cada uno con sus **Trade-Offs**.

* Un algoritmo utiliza una estructura de datos que el cliente no debería conocer.

* Si una clase define múltiples comportamientos que se manifiestan a partir de estructuras condicionales, en lugar de ramificar se puede crear una jerarquía polimórfica y utilizar polimorfismo para reemplazar **ifs**.

## 4. Estructura y Participantes

* **Strategy (`Compositor`):**
  * Declara una interfaz común y polimórfica para todos los algoritmos soportados.
  * Es la abstracción que `Context` utiliza para ejecutar un algoritmo específico.

* **ConcreteStrategy (ej. `SimpleCompositor`, `TeXCompositor`, `ArrayCompositor`):**
  * Implementa el algoritmo/comportamiento concreto definido en la interfaz `Strategy` que utilizará `Context` para delegar.

* **Context (`Composition`):**
  * Mantiene una referencia a un objeto `ConcreteStrategy`.
  * Expone la interfaz a los clientes (`ContextInterface`).
  * Puede suministrar datos a la estrategia o pasarse a sí mismo como colaborador para que la estrategia consulte su estado interno.

## 5. Colaboraciones

1. **Ejecución delegada:** `Context` redirige las operaciones de los clientes hacia su objeto `ConcreteStrategy` actual para realizar el cómputo.

2. **Paso de datos:** `Context` y `ConcreteStrategy` colaboran pasando información como argumentos directos o mediante callbacks sobre `Context`.

3. **Configuración por el cliente:** El cliente generalmente crea una instancia de `ConcreteStrategy` y configura el `Context` con ella, a partir de ese momento el cliente solo interactúa con `Context`.

## 6. Consecuencias

El patrón **Strategy** presenta las siguientes ventajas y desventajas:

1. **Familias de algoritmos relacionados:** Las jerarquías de clases `Strategy` definen una familia de algoritmos o comportamientos que se pueden reutilizar. La herencia permite factorizar y compartir la funcionalidad común de los algoritmos.

2. **Una alternativa a la creación de subclases (*Subclassing*):** Podríamos subclasificar directamente `Context`, pero esto cablea rígidamente el comportamiento a `Context`, mezclando la implementación del algoritmo con la de `Context`. Además, esta forma imposibilita cambiar el algoritmo de forma dinámica.

3. **Las estrategias eliminan sentencias condicionales:** Encapsular el comportamiento en las diferentes `Strategy` permite eliminar las sentencias condicionales que vivían en `Context` utilizando polimorfismo.

4. **Elección de implementaciones:** Las estrategias brindan diferentes implementaciones para un mismo comportamiento, las cuales permiten decidir al cliente cuál sería la óptima para su caso particular.

5. **Los clientes deben conocer las distintas estrategias:** Una desventaja clara es que el cliente debe conocer las diferentes estrategias, ya que la creación del `Context` depende de asignarle una estrategia, por lo que los clientes pueden quedar expuestos a detalles de implementación. Por eso **Strategy** solo debe emplearse cuando la variación del comportamiento resulta relevante para los clientes.

6. **Sobrecosto de comunicación entre Strategy y Context (*Communication overhead*):** Como `Strategy` es una jerarquía polimórfica, todas las subclases implementan la misma interfaz, el mismo algoritmo/comportamiento, por lo que si en algún caso la implementación resulta trivial podrían no utilizarse todos los colaboradores del mensaje. Esto genera un acoplamiento más estrecho entre `Strategy` y `Context`.

7. **Incremento en el número de objetos:** Las estrategias aumentan la cantidad de objetos dentro del sistema. A veces este costo puede mitigarse implementando estrategias sin estado (*stateless*) que los contextos puedan compartir como Flyweights.

## 7. Implementación

Al implementar el patrón **Strategy**, deben considerarse los siguientes aspectos técnicos y compromisos de diseño:

### 1. Definición de las interfaces de `Strategy` y `Context`

Las interfaces de `Strategy` y `Context` deben permitir que un `ConcreteStrategy` acceda de forma eficiente y no invasiva a cualquier dato requerido del contexto para computar el algoritmo. Existen dos enfoques habituales para el flujo de información:

* **Pasaje de datos como argumentos (`Data Passing`):**
  * `Context` envía los datos explícitamente a través de los parámetros del método del algoritmo (por ejemplo, `strategy computeWith: data1 and: data2`).
  * **Ventaja:** Desacopla por completo a `Strategy` respecto de la clase e interfaz de `Context`.
  * **Desventaja (*Overhead*):** Obliga a definir una interfaz lo bastante amplia para el peor caso. Ciertas estrategias concretas simples recibirán argumentos que nunca utilizarán.

* **Pasaje de la referencia del contexto (`Context Passing / Callbacks`):**
  * `Context` se pasa a sí mismo (`this` o `self`) como argumento en la invocación (`strategy computeFor: self`), o la estrategia guarda una referencia persistente a su contexto.
  * **Ventaja:** Elimina el pasaje superfluo de parámetros; la estrategia solicita únicamente los colaboradores o atributos específicos que necesita.
  * **Desventaja:** Aumenta el acoplamiento, ya que las subclases de `Strategy` quedan atadas a la interfaz pública o a los métodos de acceso de `Context`.

---

### 2. Estrategias como parámetros de plantilla (*Templates / Generics*)

En lenguajes con tipado estático como C++, si no es un requisito intercambiar la estrategia dinámicamente en tiempo de ejecución, se puede configurar el contexto mediante plantillas (`template <class AStrategy> class Context`).

* **Ventajas:**
  * Enlaza el algoritmo en tiempo de compilación (*early/static binding*).
  * Elimina la sobrecarga de indirección asociada a tablas de funciones virtuales (`vtable lookup`).
  * Ahorra el almacenamiento en memoria del puntero o referencia hacia el objeto estrategia.
* **Limitación:** Congela la estrategia seleccionada durante la compilación, perdiendo la mutabilidad dinámica característica del patrón en tiempo de ejecución.

---

### 3. Hacer que los objetos `Strategy` sean opcionales (*Default Behavior*)

Para simplificar el uso del contexto por parte de los clientes:

* La clase `Context` puede verificar la presencia de su colaborador `Strategy` antes de invocarlo.
* Si la referencia es nula o no fue configurada, `Context` ejecuta un comportamiento predeterminado por defecto.
* **Beneficio:** Los clientes únicamente configuran una instancia de `ConcreteStrategy` cuando desean sobrescribir el comportamiento estándar, reduciendo el código repetitivo en escenarios comunes.

---

### 4. Ciclo de vida y compartición de instancias (`Flyweight / Stateless Strategies`)

* Si las clases `ConcreteStrategy` no poseen variables de instancia (es decir, encapsulan lógica pura y no mantienen estado intrínseco), no es necesario instanciarlas repetidamente.
* Pueden compartirse entre múltiples instancias de `Context` modelándolas como *Singletons* o reutilizándolas a través del patrón *Flyweight*, minimizando el consumo de memoria y la presión sobre el recolector de basura (*garbage collector*).

## Usos Conocidos

* **ET++:** Emplea el patrón Strategy para encapsular diferentes algoritmos de distribución de texto en líneas (TextCompositor y sus variantes).

* **InterViews:** Utiliza estrategias denominadas Layouts para encapsular diversas políticas de alineación y distribución espacial de elementos de interfaz gráfica.

* **RTL System (Compiladores):** Utiliza estrategias para abstraer diferentes mecanismos de asignación de registros de procesador y esquemas de generación de código según la arquitectura del hardware de destino.

* **Frameworks de Colecciones en Smalltalk/CLI:** Algoritmos de ordenamiento parametrizados por bloques o clausuras (sorting blocks) constituyen instanciaciones directas del patrón Strategy.

## Patrones Relacionados

* **Flyweight:** Las instancias de ConcreteStrategy frecuentemente carecen de estado interno propio, lo que permite compartirlas entre múltiples contextos como Flyweights.

* **State:** Comparte una estructura idéntica basada en delegación y composición, pero difiere en la intención: State varía el comportamiento asociado a transiciones internas automáticas del ciclo de vida del objeto, mientras que Strategy provee algoritmos independientes configurados típicamente por el cliente.

* **Template Method:** Emplea herencia para variar partes internas de un algoritmo en subclases; Strategy emplea delegación y composición para intercambiar el algoritmo entero de forma dinámica.