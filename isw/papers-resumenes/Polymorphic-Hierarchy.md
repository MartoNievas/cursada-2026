# Polymorphic Hierarchy

## Introducción

**Bobby Woolf** nos comenta en este paper que al menos la mitad de los métodos que escribe son código repetido, como *getters*, *setters*, métodos de inicialización, o métodos que ya fueron implementados en la superclase del objeto.

Además comenta que la reimplementación de estos métodos es la clave del polimorfismo y que, usada de manera correcta, los métodos polimórficos conducen a clases polimórficas y, en última instancia, a **jerarquías polimórficas**.

---

## Reutilizando descripciones de métodos

Woolf usa el método `printOn:` como ejemplo para ilustrar cómo subimplementa métodos de superclases.

En lugar de reescribir comentarios extensos, simplemente documenta su implementación con algo como *"Lee la implementación de la superclase"*, porque su método básicamente hacía lo mismo que el de la superclase.

Además señala que su implementación está en el mismo protocolo de métodos (`printing`) que el original, lo que refuerza la idea de que ambos métodos tienen el mismo propósito.

---

## Una implementación definitoria

Cuando el autor implementa un método, solo existe una descripción: la del método que **define** la jerarquía. Este suele tener una implementación muy simple (como retornar `self` o lanzar `subclassResponsibility`), pero es quien documenta el propósito del método para toda la jerarquía. Por lo tanto, cualquier implementación en las subclases debe esencialmente hacer lo mismo, aunque sus implementaciones concretas sean distintas.

En Smalltalk se aplica este principio con la costumbre de hacer que un método simplemente llame a otro con casi el mismo nombre, salvo por parámetros extra. Por ejemplo:

- `Object>>changed` envía a `changed:`
- `Object>>changed:` envía a `changed:with:`

No es necesario describir el propósito de los tres métodos; con documentarlo en `changed` es suficiente.

---

## Anatomía de la descripción

¿Qué ponemos en la descripción de un método? El autor da tres lineamientos:

1. **Evitar reformular el nombre del método.** Por ejemplo, un método llamado `codigoDeProducto` cuya descripción sea *"Devuelve el código del producto"* es redundante. Un nombre adecuado para esa descripción podría ser simplemente `getter`.

2. **Describir el método en su totalidad**, no comentar línea por línea. En su lugar, se extrae el código complejo a un nuevo método con un nombre descriptivo, y los comentarios entre líneas se convierten en la descripción de ese nuevo método.

3. **Dividir la descripción en dos partes** (ver sección siguiente).

---

## Propósito e implementación

El autor diferencia claramente dos partes en la descripción de un método:

- **Propósito:** Explica qué hace el método. Se expresa como: *"Si enviás este mensaje a este objeto, esto es lo que ocurrirá"*. El propósito **sí es reutilizable**; de hecho, lo ideal es que todas las implementaciones de un método dentro de la misma jerarquía compartan el mismo propósito.

- **Implementación:** Es opcional. Solo se documenta ante código complejo o poco claro; de lo contrario, es preferible mejorar el código en su lugar. La implementación **no debería ser reutilizable**: si lo fuera, estaríamos ante código repetido que podría abstraerse en un nuevo método.

---

## Reutilización de descripción para el polimorfismo

Al principio, Woolf veía las clases como unidades aisladas y elegía superclases solo para heredar funcionalidad. Con el tiempo entendió que las clases deben pensarse en términos de jerarquías.

Como ejemplo, considera la jerarquía `Collection`. Una colección puede aceptar peticiones para añadir y eliminar elementos, iterar, etc. Pero `Collection` no sabe *cómo* resolver estas peticiones; eso depende de la implementación concreta (árbol, array, set, etc.).

Además menciona que cuando se crea una subclase, la superclase debería hacer casi exactamente lo mismo que esa nueva subclase. La subclase puede agregar comportamientos extra, pero el **propósito debe ser el mismo**.

---

## El propósito es el polimorfismo

Woolf menciona que cuando todas las implementaciones en una jerarquía comparten el mismo propósito, son **polimórficas**. Y cuando todos los métodos que hereda la subclase se reimplementan de manera polimórfica, la jerarquía en su conjunto también resulta polimórfica, porque todas sus instancias se comportan de la misma forma, es decir, cumplen el mismo propósito.

Como ejemplo propone el objeto `Empleado`, que mantiene una lista `cosasQueHacer`. No sabemos cómo se ordenará la lista, pero sí sabemos que usará una `Collection` (puede ser `OrderedCollection` o `SortedCollection`). Sin saber cuál exactamente, ya sabemos que responderá a mensajes como `add:`, `remove:`, etc.

---

## Definiendo polimorfismo

Para que dos métodos sean polimórficos no solo deben tener el mismo nombre: también deben comportarse de la misma forma, es decir, tener el mismo **propósito**. Esto implica que:

- Los parámetros deben ser del mismo tipo (no necesariamente los mismos parámetros).
- Deben producir los mismos efectos secundarios.
- Deben retornar el mismo tipo de resultado.

Si dos clases comparten la misma interfaz, como `OrderedCollection` y `SortedCollection`, se consideran polimórficas porque implementan el mismo conjunto de mensajes con el mismo propósito. En la práctica, las clases no siempre comparten exactamente la misma interfaz, pero sí una **interfaz base** polimórfica, es decir, un conjunto mínimo de mensajes compartidos que permite usarlas de forma intercambiable.

---

## Haciendo una jerarquía polimórfica

Cuando un método se reimplementa en una subclase con el mismo propósito que en la superclase, se documenta con **"Ver implementación en superclase"**. Esto fomenta pensar los métodos de forma polimórfica, haciendo las jerarquías más flexibles, reusables y extensibles.

### Problema 1: No existe implementación en la superclase

Si dos clases implementan el mismo mensaje polimórficamente pero sin una superclase común que lo defina, el código está indicando que **falta esa implementación**. La solución es introducirla en la superclase: documentar el propósito allí, darle una implementación por defecto, y luego las subclases pueden usar el comentario estándar.

### Problema 2: No existe una superclase adecuada

Si las dos clases no tienen una superclase común específica (solo una genérica como `Object`), no conviene agregar un mensaje de dominio en una clase tan general.

La solución es crear una **nueva clase abstracta** que describa el comportamiento polimórfico compartido, y subclasificar ambas clases concretas a partir de ella. Así la jerarquía pasa a existir y se puede agregar la implementación en la superclase normalmente.

---

## Patrón Template Class

La clase abstracta que se introduce para crear una jerarquía polimórfica se denomina **Template Class**. Este patrón crea jerarquías polimórficas definiendo la interfaz de una clase y dejando los detalles de implementación para las subclases.

---

## La jerarquía de ValueModel

La jerarquía `ValueModel` en VisualWorks es un buen ejemplo de jerarquía polimórfica. La clase `ValueModel` define la jerarquía indicando que todas sus instancias entenderán mensajes como `value`, `value:` y `onChangeSend:to:`. Todas las subclases implementan estos mensajes según su propio funcionamiento, pero respetando la interfaz, es decir, el propósito.

Esto permite que el código colaborador use cualquier instancia de la jerarquía sin importar la subclase concreta, aprovechando el polimorfismo a nivel de clase.
