# Ejercicio: Números Enteros y Fraccionarios

## Objetivo

Implementar la **suma, resta, multiplicación y división** entre números enteros y fraccionarios, sin usar `if` en los métodos a implementar.

---

## Estructura del ejercicio

El ejercicio tiene **dos partes**:

1. **Pre-Números** → archivo `Pre-Numeros-Ejercicio.st`
2. **Números** → archivo `Numeros-Ejercicio.st` *(punto de partida para la 2da parte)*

> `Pre-Numeros-Ejercicio Solu.st` es la solución a la primera parte, pero **no es el punto de partida para la segunda**.

---

## Reglas generales

- La solución final **no debe tener `if`** en los métodos a implementar.
- La implementación de `fibonacci` tampoco debe tener `if`.
- **Todos los tests deben pasar.**
- Los tests y su `setUp` **no pueden modificarse** en la 2da parte. En la 1ra parte sí se puede modificar el `setUp`.

---

## Restricciones del modelo

- Las fracciones **no pueden tener denominador 1**. Una fracción con denominador 1 se considera un entero.
- Los enteros **no pueden responder** los mensajes `#numerador` ni `#denominador`, ya que no son fracciones.
- Las operaciones aritméticas entre enteros usan las operaciones provistas por el sistema, por razones de performance.

---

## Estado inicial de los tests

Al correr los tests desde `Numeros-Ejercicio.st`:

- Pasan los tests de operaciones entre números del **mismo tipo** (entero con entero, fracción con fracción).
- Fallan los tests de operaciones entre **tipos distintos** (entero con fracción y viceversa).

---

## Guía de resolución

### Paso 1 — Entender el modelo
Antes de escribir código, debuggear los tests que ya pasan para entender cómo funcionan las clases `Numero`, `Entero` y `Fraccion`.

### Paso 2 — Resolver con `if`
Hacer pasar todos los tests usando `if` con el mensaje `#isKindOf:`.

### Paso 3 — Reemplazar `if` por polimorfismo
Aplicar el algoritmo visto en clase para eliminar los `if` y reemplazarlos con polimorfismo.

---

## Desafío opcional

Para quienes quieran llevar el reemplazo de `if` al extremo: eliminar también los `if` que ya venían en el ejercicio original, relacionados a división por cero, denominador igual a uno, etc.

Las soluciones a este desafío son muy interesantes y varían entre lenguajes de **prototipación** (ej. JavaScript) y de **clasificación** (ej. Smalltalk).
