# Metamodelo

El metamodelo en **Smalltalk** es el conjunto de directivas o reglas que nos permite construir el sistema.

- **Regla 1:** Todo es un objeto.
- **Regla 2:** Todo objeto es una instancia de una clase.
- **Regla 3:** Toda clase tiene una superclase.
- **Regla 4:** Todo sucede por mensajes enviados.
- **Regla 5:** El method lookup sigue la cadena de herencia.
- **Regla 6:** Toda clase es una instancia de una metaclase.
- **Regla 7:** Una clase puede tener comportamiento propio, ya que cada clase es instancia de su propia metaclase, y la jerarquía de metaclases copia 1-a-1 la jerarquía de clases, permitiendo herencia y redefinición de ese comportamiento.
- **Regla 8:** Toda metaclase hereda de **Class** y **Behavior**.
- **Regla 9:** Toda metaclase es instancia de **Metaclass**.
- **Regla 10:** La metaclase de **Metaclass** es una instancia de **Metaclass**. Esta regla hace que el metamodelo sea circular.

---

# Method Lookup, VTBL y Dispatch Dinámico

## Lenguajes Dinámicamente Tipados

### ¿Qué es Method Lookup?

**Method Lookup** es el algoritmo que se utiliza para buscar un método a partir de un **receptor** y un **mensaje**, es decir que el sistema debe decidir qué implementación ejecutar.

### Dispatch Table Search (DTS)

Es el mecanismo que se utiliza para la búsqueda de métodos cuando no hay resultados cacheados.

### Global Lookup Cache (GLC)

Como su nombre indica, es una cache global de búsqueda de métodos que guarda resultados de búsquedas previas. Si hay un **hit** se usa directamente; si hay **miss** se vuelve a realizar la búsqueda. La clave es: clase del receptor + nombre del método.

### Inline Cache (IC)

Es una cache por cada punto de envío del mensaje. Almacena el tipo del receptor y el método resuelto. Si el tipo cambia, la cache se invalida y vuelve a buscar.

### Polymorphic Inline Cache (PIC)

Es una extensión de la cache anterior que almacena los tipos posibles de receptores. Cada tipo se asocia a su método correspondiente y se usa cuando un mismo punto de envío recibe objetos de distintas clases.

---

## Lenguajes Estáticamente Tipados: VTBL (Virtual Table)

En estos se utiliza la **Virtual Table (VTBL)**:

- Cada clase tiene su propia **VTBL**.
- La dimensión de la **VTBL** depende de la jerarquía de herencia.
- En la tabla quedan almacenadas las direcciones de los métodos.
- En tiempo de ejecución, se accede a la **VTBL** del objeto y se usa un **offset fijo** para obtener el método.

---

## Funcionamiento del Method Lookup en Smalltalk

En Smalltalk, todo es envío de mensajes, y cada vez que se envía uno el sistema debe decidir qué método ejecutar. Para hacerlo rápido, usa varios niveles de búsqueda con caches.

### 1. Búsqueda en el Polymorphic Inline Cache (PIC)

El **PIC** está embebido en el código del punto de envío del mensaje (call site). Contiene varias clases posibles del receptor, almacena el método correspondiente a cada clase, incluye internamente al **Inline Cache** y está especializado para ese mensaje específico en ese lugar del programa.

**Proceso:**

1. Se compara la clase real del objeto receptor con las clases cacheadas.
2. Si hay coincidencia, se ejecuta el método directamente.
3. Si no hay coincidencia, se continúa la búsqueda en la **GLC**.

### 2. Búsqueda en la Global Lookup Cache (GLC)

La **GLC** es una cache global para todo el sistema, no asociada a un único punto de envío. Utiliza como clave la tupla:

$$
(selector,\ clase,\ método)
$$

Además usa el método de tres pruebas para acelerar la comparación de dichas tuplas:

1. Se consulta si el mensaje ya fue resuelto previamente para esa clase.
2. Si hay hit, se obtiene el método y se ejecuta.
3. Si hay miss, se continúa la búsqueda en la **DTS**.

### 3. Búsqueda en la Dispatch Table Search (DTS)

La **DTS** es el mecanismo completo de búsqueda sin utilizar caches:

1. Se busca el mensaje en el **Method Dictionary** de la clase del receptor.
2. Si no se encuentra, se busca en el **Method Dictionary** de la superclase.
3. Este proceso se repite hasta recorrer toda la jerarquía de clases.

Si el método es encontrado:

- Se cachea el resultado en la **GLC**.
- Se ejecuta el método.

### 4. Envío de doesNotUnderstand

Si el mensaje no se encuentra en ninguna clase de la jerarquía:

1. Se envía automáticamente al objeto receptor el mensaje **doesNotUnderstand**.
2. Este mensaje vuelve a ejecutar todo el algoritmo de Method Lookup.

---

# Excepciones

## Una Explicación Pragmática

Históricamente, el manejo de errores se realizaba mediante la técnica de código de retorno, donde las funciones devolvían códigos indicando éxito o error. Esta técnica presenta varios problemas:

- Genera código repetido.
- Es propensa a errores.
- Mezcla la lógica del programa con la administración del error.
- No está estandarizada.

Las excepciones nacen como una solución para eliminar el código repetido, separando la lógica normal del flujo del manejo de errores.

## Una Explicación Conceptual

Las excepciones se basan en la técnica **Design by Contract**: un contrato es un acuerdo de obligaciones entre objetos que, si se cumplen, garantizan un resultado definido.

En objetos, un contrato se compone de:

- **Pre-condiciones.**
- **Post-condiciones.**
- **Invariante.**

## ¿Cuándo Levantar una Excepción?

- Cuando se rompe un contrato, especialmente la pre-condición.
- No deben usarse excepciones como control de flujo.
- Ejemplo válido: división por cero.
- Ejemplo inválido: salir de un bucle con una excepción.

## ¿Quién Verifica los Contratos?

**Escuela C:**

- El emisor del mensaje verifica las pre-condiciones.
- Ventaja: performance.
- Desventaja: código repetido e inseguridad.

**Escuela Lisp:**

- El receptor del mensaje verifica las pre-condiciones.
- Ventaja: validaciones centralizadas y mayor seguridad.
- Desventaja: posible pérdida de rendimiento.

## ¿Quién Informa y Quién Handlea?

**Quién informa:**

- Generalmente los métodos más bajos del árbol de ejecución.
- Son los que realmente detectan que el contrato se rompió.

**Quién handlea:**

- Los métodos más altos del árbol de ejecución.
- Tienen más contexto para decidir qué hacer.

## Cómo se Pueden Handlear las Excepciones

**Implementaciones cerradas:**

- Se termina en el bloque donde ocurrió la excepción.
- Se pasa al siguiente handler.

**Implementaciones abiertas:**

- Se termina el bloque donde ocurrió la excepción.
- Se pasa al siguiente handler.
- Se puede reintentar el bloque.
- Se puede continuar con otra colaboración.

## Cómo se Deben Handlear

Las excepciones deben handlearse cuando se puede resolver el contrato que se rompió. No se deben handlear si no se puede hacer nada útil. Nunca se deben ocultar excepciones y además deben handlearse en la raíz del árbol de ejecución.

## Cuáles Informar

Existen tres estrategias:

1. Un tipo de excepción por cada condición.
2. Usar siempre el mismo tipo de excepción.
3. Un enfoque mixto.

Solo deben crearse nuevas excepciones si estas van a ser handleadas.

## Try-Catch vs on:do: en Smalltalk

En lenguajes como Java o C++ se usa:

```java
try { ... } catch (E e) { ... }
```

En Smalltalk se usa el mensaje:

```smalltalk
[bloque] on: Exception do: [handler]
```

Ambos mecanismos representan el mismo concepto.

## Excepciones Checked vs Unchecked

Las excepciones pueden clasificarse en dos grandes tipos:

**Checked:**

- Son excepciones que el compilador obliga a declarar o capturar.
- Representan errores esperables del entorno.
- Hacen explícito qué operaciones pueden fallar.
- Generan fuerte acoplamiento entre módulos.

**Unchecked:**

- No obligan a ser declaradas ni capturadas.
- Representan principalmente errores de programación.
- Suelen indicar fallas de lógica.
- Generan menor acoplamiento.
