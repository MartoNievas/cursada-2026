# Resumen del Capítulo: Method Object
**Autor:** Kent Beck (*Smalltalk Best Practice Patterns*, 1996)

---

### 1. El Problema Planteado
> **¿Cómo se escribe un método en el que muchas líneas de código comparten muchos argumentos y variables temporales?**

El comportamiento central en un sistema complejo suele volverse complicado. Inicialmente, esa complejidad no se reconoce y el comportamiento se concentra en un único método. Gradualmente, este método crece acumulando líneas de código, múltiples parámetros y abundantes variables temporales, convirtiéndose en un código difícil de mantener.

---

### 2. ¿Por qué falla Composed Method inicialmente?
Intentar aplicar el patrón **Composed Method** (extraer bloques de código en pequeños métodos auxiliares) sobre un método de estas características fracasa y oscurece la situación. Dado que casi todas las secciones del método original necesitan acceder a las mismas variables temporales y parámetros, cualquier submétodo que se intente extraer requerirá pasar entre **6 y 8 parámetros** en su llamada. Esto produce signaturas de métodos ilegibles y no ahorra líneas de código.

---

### 3. La Solución: Method Object
La solución consiste en **crear un objeto dedicado a representar una única invocación del método**.

Al convertir la llamada al método en un objeto:
* Los objetos tradicionales suelen ser *sustantivos*; un **Method Object** es un *verbo*.
* El receptor original, cada parámetro y cada variable temporal del método se transforman en **variables de instancia** compartidas dentro del nuevo objeto.
* Este espacio de nombres compartido permite luego aplicar **Composed Method** de manera limpia y elegante, descomponiendo la lógica en métodos pequeños sin necesidad de pasar ningún parámetro.

---

### 4. Pasos para Implementar Method Object

1. **Crear la clase:** Definir una nueva clase cuyo nombre se derive directamente del selector del método original (ej. `EnviadorDeTareas`).
2. **Definir variables de instancia:** Agregar una variable de instancia para el receptor original del método (`self`), una por cada argumento y una por cada variable temporal.
3. **Crear el Constructor:** Definir un método de clase/constructor que reciba el receptor original y los argumentos del método original.
4. **Implementar el método `#computar`:** Crear el método de instancia `#computar` en la nueva clase copiando el cuerpo del método original (reemplazando los nombres de parámetros por las variables de instancia y eliminando la declaración de temporales).
5. **Reemplazar el método original:** Modificar el método original para que instancie la nueva clase y le envíe el mensaje `#computar`.

---

### 5. Ejemplo de Código (Smalltalk)

#### Código Original Monolítico:
```smalltalk
Obligacion >> enviarTarea: unaTarea trabajo: unTrabajo
    | noProcesado procesado copiado ejecutado |
    "... 150 líneas de código complejo y muy comentado... "
```

#### Aplicación de Method Object:

1. **Creación de la Clase y Variables:**
```smalltalk
Class: EnviadorDeTareas
superclass: Object
instance variables: obligacion tarea trabajo sinProcesar procesado copiado ejecutado
```

2. **Constructor de Clase:**
```smalltalk
EnviadorDeTareas class >> obligacion: unaObligacion tarea: unaTarea trabajo: unTrabajo
    ^self new definirObligacion: unaObligacion tarea: unaTarea trabajo: unTrabajo
```

3. **Método `#computar` y Reemplazo en el Método Original:**
```smalltalk
"Método original refactorizado:"
Obligacion >> enviarTarea: unaTarea trabajo: unTrabajo
    (EnviadorDeTareas obligacion: self tarea: unaTarea trabajo: unTrabajo) computar
```

---

### 6. Refactorización Posterior con Composed Method
Una vez creado el `Method Object`, la refactorización es simple. Como todas las partes de la lógica comparten las variables de instancia del objeto, se pueden extraer sub-métodos sin pasar argumentos. Por ejemplo, la sección que preparaba una tarea se extrae a un método privado `#prepararTarea`:

```smalltalk
EnviadorDeTareas >> computar
    self prepararTarea.
    self procesarTarea.
    self registrarEjecucion.
```

---

### 7. Consecuencias y Beneficios
* **Transformación de código complejo:** Métodos de 150 líneas se reducen a un método `#computar` que se lee como documentación ejecutable.
* **Simplificación y detección de errores:** Permite eliminar variables temporales innecesarias y facilita encontrar y corregir errores ocultos en la lógica original.
* **Valor del patrón:** Aunque se utiliza en situaciones puntuales, Kent Beck destaca que cuando se necesita refactorizar lógica altamente acoplada, es un patrón indispensable (*"cuando lo necesitás, REALMENTE lo necesitás"*).
