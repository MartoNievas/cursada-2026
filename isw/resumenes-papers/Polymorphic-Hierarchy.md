# Resumen: Principles of the Polymorphic Hierarchy
**Autor:** Bobby Woolf (1996)
**Traducción y Referencias:** Leveroni - Algoritmos y Programación III (FIUBA)

---

## 1. Introducción y Motivación
En el desarrollo orientado a objetos, una fracción considerable del código escrito (a menudo cerca de la mitad) no corresponde a lógica de dominio completamente inédita, sino a métodos repetitivos como *getters*, *setters*, inicializadores o reimplementaciones de métodos ya definidos en superclases.

El autor plantea que la **reimplementación consciente y consistente de estos métodos es la clave fundamental del polimorfismo**. Cuando los métodos polimórficos se organizan adecuadamente, conducen a clases polimórficas y, en última instancia, a **jerarquías polimórficas** sólidas, flexibles y reusables.

---

## 2. Documentación y Reutilización de Descripciones
Para mantener la coherencia en una jerarquía sin duplicar documentación ni esfuerzo:
* **Uso del comentario *"Ver implementación en superclase"*:** En lugar de reescribir descripciones extensas en las subclases, los métodos que reimplementan un mensaje con el mismo propósito deben remitir a la definición en la superclase.
* **Mismo protocolo de métodos:** Los métodos que reimplementan un mensaje de la superclase deben ubicarse en el mismo protocolo (por ejemplo, el protocolo `printing` para el mensaje `printOn:`), lo que refuerza visualmente que comparten la misma intención.
* **Implementación definitoria:** En toda la jerarquía existe una única descripción primaria: la del método en la superclase que **define** la interfaz. Aunque la implementación en la superclase sea abstracta o elemental (como devolver `self` o lanzar `subclassResponsibility`), es la encargada de documentar el propósito del mensaje para todas las subclases.
* **Mensajes delegados o auxiliares:** En Smalltalk es habitual que mensajes con menos argumentos deleguen en versiones más completas (ej. `changed` envía a `changed:`, y este a `changed:with:`). Basta con documentar el propósito en el método principal con más parámetros (`changed:with:`) y remitir los demás a él.

---

## 3. Anatomía de la Descripción de un Método
Woolf establece tres lineamientos principales para la redacción de descripciones:
1. **Evitar la redundancia con el nombre:** Un método llamado `codigoDeProducto` cuya descripción sea *"Devuelve el código del producto"* resulta innecesario. En su lugar, se utilizan etiquetas directas como `Getter` o `Setter`.
2. **Describir el método en su totalidad:** Debe evitarse comentar línea por línea. Cuando un bloque de código resulta complejo o confuso, se debe refactorizar extrayéndolo a un nuevo método con un nombre descriptivo; la explicación pasa a ser la descripción del nuevo método.
3. **División estricta entre Propósito e Implementación:**
   * **Propósito (el *qué*):** Explica qué efecto o resultado produce el mensaje. **Es reusable** y debe ser compartido por todas las implementaciones del mensaje en la jerarquía.
   * **Detalles de Implementación (el *cómo*):** Es opcional y explica justificativos técnicos o complejidades internas del código. **No es reusable**; si dos subclases comparten detalles de implementación, existe código duplicado que debería abstraerse.

---

## 4. Definición Estricta de Polimorfismo
El paper enfatiza que **compartir el mismo nombre de método no implica polimorfismo**.

* **Contraste explícito (`value` y `value:`):**
  En la clase `ValueModel`, los mensajes `value` y `value:` funcionan como *getter* y *setter* del valor contenido. En cambio, en `BlockClosure` (bloques), los mismos mensajes se utilizan para ejecutar/evaluar el bloque. Aunque tienen nombres idénticos, sus propósitos son completamente distintos, por lo que **no son polimórficos**.
* **Requisitos para el Polimorfismo Real:** Dos métodos son polimórficos solo si comparten:
  1. El mismo **propósito** o comportamiento abstracto.
  2. Los mismos **tipos de parámetros**.
  3. Los mismos **efectos secundarios** sobre el estado del objeto.
  4. El mismo **tipo de retorno**.
* **Interfaz Base:** Para que dos o más clases sean polimórficas entre sí, deben compartir una **interfaz base polimórfica** (un conjunto común de mensajes con el mismo propósito), permitiendo que los objetos colaboradores las utilicen de manera intercambiable.

---

## 5. Resolución de Problemas de Diseño
Al estructurar jerarquías polimórficas pueden surgir dos obstáculos comunes:

* **Problema 1: Falta de implementación en la superclase.**
  Si dos clases implementan un método polimórficamente pero no tienen un método común en la superclase que lo defina, el código indica que falta una abstracción. La solución es subir la definición a la superclase, documentar allí el propósito general y proveer una implementación por defecto o abstracta.
* **Problema 2: Ausencia de una superclase común específica.**
  Si dos clases comparten comportamientos polimórficos pero su única superclase común es una clase genérica (como `Object` o `ApplicationModel`), no se debe contaminar la clase general con mensajes específicos de un dominio particular. La solución es crear una **nueva clase abstracta** intermedia que defina la interfaz compartida y hacer que las clases concretas hereden de ella.

---

## 6. Patrón Template Class y Ejemplos Concretos
El patrón **Template Class** describe la clase abstracta que se ubica en la cúspide de una jerarquía polimórfica para definir la interfaz base y delegar los detalles concretos a sus subclases.

* **Relación con *Template Method* (GoF):**
  Mientras que el patrón *Template Method* (Gamma et al., 1995) define la estructura de un algoritmo dentro de un método particular dejando pasos específicos a las subclases, una ***Template Class*** define la interfaz completa para un tipo de objeto (una clase) y suele estar constituida por múltiples *Template Methods*.

* **Ejemplos destacados en el paper:**
  1. **Jerarquía `Collection`:** La clase abstracta `Collection` define lo que puede hacer una colección (`add:`, `remove:`, `do:`, `size`), mientras que subclases concretas como `Set` o `OrderedCollection` definen *cómo* se realiza mediante estructuras de datos específicas (tablas hash, listas, etc.).
  2. **Caso `Empleado` y `cosasQueHacer`:** Un objeto `Empleado` que posee la lista `cosasQueHacer` puede trabajar de forma transparente tanto con una `OrderedCollection` como con una `SortedCollection`. El colaborador sólo necesita conocer la interfaz base de `Collection` (`add:`, `remove:`, `first`, etc.).
  3. **Jerarquía `ValueModel` en VisualWorks:** `ValueModel` establece que todas sus subclases (`ValueHolder`, `AspectAdaptor`, `TypeConverter`) responderán a `value`, `value:` y `onChangeSend:to:`, garantizando la intercambiabilidad total de sus instancias.

---

## 7. Conclusión y Lecturas Recomendadas
Las jerarquías polimórficas encapsulan código altamente reusable, extensible y mantenible, convirtiendo a las clases en estructuras intercambiables en lugar de bloques aislados.

* **Lectura complementaria recomendada por el autor:**
  Woolf concluye sugiriendo la lectura de ***"Reusability Through Self-Encapsulation"*** de Ken Auer (1995), un lenguaje de patrones que detalla cómo construir jerarquías de clases altamente reusables mediante herencia mientras se preserva rigurosamente el encapsulamiento de cada clase.
