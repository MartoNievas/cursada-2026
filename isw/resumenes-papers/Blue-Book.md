# Resumen de Smalltalk-80 (Bluebook): Capítulos 6, 7, 8 y Protocolo de Colecciones

---

## Capítulo 6: Protocolo para Todos los Objetos (`Class Object`)

Todo en el sistema es un objeto y hereda el comportamiento por defecto definido en la clase raíz `Object`.

### 1. Testeo de Funcionalidad (Introspección)
* **`class`**: Devuelve el objeto que representa la clase del receptor.
* **`isKindOf: aClass`**: Responde `true` si `aClass` es la clase del receptor o una de sus superclases (evalúa herencia).
* **`isMemberOf: aClass`**: Responde `true` solo si el receptor es una instancia directa de `aClass` (equivale a `self class == aClass`).
* **`respondsTo: aSymbol`**: Responde `true` si el diccionario de métodos de la clase del receptor (o alguna superclase) contiene el selector `aSymbol`.

### 2. Comparación de Objetos (`==`, `=`, `hash`)
* **Equivalencia / Identidad (`==` y `~~`)**: Evalúa si el receptor y el argumento son exactamente **el mismo objeto** en memoria.
* **Igualdad (`=` y `~=`)**: Evalúa si dos objetos **representan el mismo componente o valor** (ej. `3 = (6/2)` o `#(a b c) = #(a b c)`).
  * *Particularidad*: La implementación por defecto de `=` en `Object` es `==`. Cada nueva subclase que agregue variables de instancia suele redefinir `=` para especificar qué variables determinan la igualdad.
* **`hash`**: Devuelve un `Integer` calculado a partir de la representación del receptor, utilizado típicamente para indexar el objeto en colecciones con hashing.
  * *Regla fundamental de `hash` y `=`*: **Dos objetos que son iguales (`=`) DEBEN devolver exactamente el mismo valor de `hash`**. Objetos desiguales pueden o no devolver el mismo `hash`. Por lo tanto, **siempre que se redefine `=`, se debe verificar/redefinir `hash`**.
* **Identidad con `nil`**: `isNil` (equivale a `== nil`) y `notNil` (equivale a `~~ nil`).

### 3. Copia de Objetos
* **`shallowCopy` (Copia superficial)**: Crea una nueva instancia que **comparte** las referencias a las variables de instancia del receptor original.
* **`deepCopy` (Copia profunda)**: Crea una nueva instancia con su propia copia independiente de cada variable de instancia.
* **`copy`**: Por defecto ejecuta `shallowCopy`. Si una subclase necesita una combinación especial de variables compartidas y no compartidas, se redefine `copy` en lugar de `shallowCopy` o `deepCopy`.

### 4. Acceso a Partes Indexadas (`at:` vs `basicAt:`)
Para objetos con variables de instancia indexadas (como `Array`), `Object` provee pares de mensajes:
* **Protocolo externo**: `at: index`, `at: index put: anObject`, `size`. Pueden ser sobreescritos por las subclases para manejar casos especiales.
* **Protocolo primitivo (`basic...`)**: `basicAt: index`, `basicAt: index put: anObject`, `basicSize`. Tienen prohibido ser modificados en subclases para garantizar siempre el acceso directo a las primitivas del sistema. Si un objeto no tiene variables indexadas, `basicSize` devuelve `0`.

### 5. Impresión y Almacenamiento
* **Impresión (`printString`, `printOn: aStream`)**: Devuelve o escribe en un stream una descripción legible del objeto (por defecto, el nombre de su clase precedido por `'a '` o `'an '`).
* **Almacenamiento (`storeString`, `storeOn: aStream`)**: Devuelve una expresión de Smalltalk en formato `String` que, al ser evaluada, permite **reconstruir** un objeto equivalente (ej. `(Set new add: $a; add: $b)`).

### 6. Manejo de Errores
* **`doesNotUnderstand: aMessage`**: Enviado automáticamente por el intérprete al objeto original cuando un mensaje no se encuentra en toda su cadena de superclases.
* **`error: aString`**: Reporta un error explícito al usuario con el texto indicado.
* **`primitiveFailed`**: Reporta que una primitiva de la máquina virtual falló.
* **`subclassResponsibility`**: Indica que un método de una superclase abstracta debía haber sido implementado por la subclase.
* **`shouldNotImplement`**: Indica que una subclase anula un mensaje heredado porque no es apropiado para su representación.

---

## Capítulo 7: Medidas Lineales (`Class Magnitude`)

Representa objetos que pueden compararse a lo largo de una dimensión lineal (orden total).

### 1. Clase `Magnitude` (Superclase Abstracta)
* **Comparación**: `<`, `<=`, `>`, `>=`, `between: min and: max`.
* **Testing**: `min: aMagnitude`, `max: aMagnitude`.
* **Particularidad**: Aunque `Magnitude` hereda `=` de `Object`, lo redefine como `self subclassResponsibility` para obligar a que cada subclase cuantificable defina su propio criterio de igualdad.

### 2. Clases `Date` y `Time`
* Destacan por poseer un rico **protocolo de clase** (en su metaclase) para consultas generales y creación de instancias:
  * **`Date`**: Consultas como `daysInYear:`, `leapYear:`, `dayOfWeek:`; creación con `Date today`, `fromDays:`, `newDay:month:year:`; aritmética con `addDays:`, `subtractDays:`, `subtractDate:`.
  * **`Time`**: Consultas como `millisecondClockValue`, `millisecondsToRun: timedBlock` (mide el tiempo de ejecución de un bloque); creación con `Time now`, `fromSeconds:`; aritmética con `addTime:`, `subtractTime:`.
* **Conversión común**: Tanto `Date` como `Time` entienden `asSeconds` para poder operar aritméticamente entre sí.

### 3. Clase `Character` y Objetos Inmutables
* Existen exactamente **256 instancias únicas** de `Character` (asociadas al código ASCII extendido), creadas al inicializar el sistema.
* **Objetos Inmutables**: Su estado interno nunca puede cambiar. En Smalltalk-80, **`Character`, `SmallInteger` y `Symbol` son objetos inmutables**. Al ser únicos en memoria, cuando se solicita un `Character` (ej. `$A` o `Character value: 65`), siempre se devuelve la referencia a la misma instancia preexistente.
* **Protocolo**: `asciiValue`, `digitValue`, `isLetter`, `isDigit`, `isAlphaNumeric`, `isLowercase`, `isUppercase`, `isVowel`, `isSeparator`, `asLowercase`, `asUppercase`. No soporta aritmética directa (`$A + 1` da error).

---

## Capítulo 8: Clases Numéricas (`Class Number`)

Smalltalk aplica la metáfora de envío de mensajes de manera uniforme incluso en la aritmética. Los números son inmutables (el objeto `3` jamás cambia su estado a `4`).

### 1. Jerarquía y Generalidad (Coerción)
`Number` (abstracta) tiene tres subclases: `Float`, `Fraction` e `Integer` (abstracta, que a su vez agrupa a `SmallInteger`, `LargePositiveInteger` y `LargeNegativeInteger`).
* **Jerarquía de Generalidad** (de mayor a menor generalidad):
  1. `Float` (aproximado, mayor generalidad)
  2. `Fraction` (racional exacto)
  3. `LargePositiveInteger` / `LargeNegativeInteger`
  4. `SmallInteger` (menor generalidad)
* **Mecanismo de Coerción (`retry:coercing:`, `coerce:`, `generality`)**: Al operar entre números de distinta clase (ej. `32.45 * 4`), el sistema convierte automáticamente el operando de menor `generality` al tipo del de mayor `generality` (`4` pasa a `4.0`) para preservar la conmutatividad y evitar pérdida de información.
* **División Exacta (`/`)**: Dividir dos enteros con `/` que no dan un resultado entero devuelve automáticamente una instancia de **`Fraction`** reducida (ej. `7 / 2` devuelve la fracción `(7/2)`).

### 2. División Entera y Resto (`//`, `\\` vs `quo:`, `rem:`)
Smalltalk distingue dos convenciones de truncamiento para resultados negativos:
* **Truncamiento hacia infinito negativo**:
  * `//` (cociente entero): `-7 // 2` da `-4`.
  * `\\` (módulo/resto): `-7 \\ 2` da `1` (siempre produce resultado positivo si el divisor es positivo).
* **Truncamiento hacia cero**:
  * `quo:` (cociente entero): `-7 quo: 2` da `-3`.
  * `rem:` (resto): `-7 rem: 2` da `-1`.

### 3. Redondeo, Iteración y Manipulación de Bits
* **Truncamiento y Redondeo**: `ceiling` (hacia $+\infty$), `floor` (hacia $-\infty$), `truncated` (hacia cero), `rounded` (entero más cercano), `truncateTo:`, `roundTo:`.
* **Creación de Intervalos y Lazos**: `to: stop`, `to: stop by: step`, `to: stop do: aBlock`, `to: stop by: step do: aBlock`. En `Integer`, también `timesRepeat: aBlock`.
* **Protocolo de `Integer`**:
  * Factorización: `factorial`, `gcd:`, `lcm:`.
  * Bits (tratando al entero como secuencia binaria en complemento a dos): `bitAnd:`, `bitOr:`, `bitXor:`, `bitInvert`, `bitShift:`, `bitAt:`, `highBit`, `allMask:`, `anyMask:`, `noMask:`.

### 4. Clase `Random`
* Generador de números pseudoaleatorios (basado en el método congruencial lineal de Lehmer) que responde al mensaje **`next`** devolviendo un `Float` distribuido uniformemente en el intervalo `(0.0, 1.0)`.

---

## Anexo: Protocolo para Todas las Colecciones (Capítulo 9)

*(Nota: En el Bluebook, el protocolo común de colecciones se detalla en el Capítulo 9 bajo la clase abstracta `Collection`, subclase de `Object`).*

### 1. Agregar, Remover y Testear Elementos
* **Agregado**:
  * `add: newObject`: Agrega el elemento y **devuelve `newObject`** (no devuelve la colección).
  * `addAll: aCollection`: Agrega todos los elementos de la colección argumento.
* **Remoción**:
  * `remove: oldObject`: Remueve una ocurrencia igual (`=`) a `oldObject` y la devuelve. Si no existe, reporta un error.
  * `remove: oldObject ifAbsent: anExceptionBlock`: Si el elemento no está, evalúa el bloque de excepción sin dar error.
  * `removeAll: aCollection`: Remueve cada elemento de `aCollection`.
* **Testeo**:
  * `includes: anObject`: Responde `true` si algún elemento es igual (`=`) a `anObject`.
  * `isEmpty`: Responde `true` si no tiene elementos (`size = 0`).
  * `occurrencesOf: anObject`: Responde cuántos elementos son iguales (`=`) a `anObject`.

### 2. Enumeración de Elementos (Con Bloques)
Excepto `do:`, `detect:` e `inject:into:`, los mensajes de enumeración devuelven **"una nueva colección como el receptor"** (de la misma clase, salvo `Interval` que devuelve una `OrderedCollection` porque no se pueden almacenar elementos arbitrarios en un `Interval`):
* **`do: aBlock`**: Evalúa el bloque de 1 argumento para cada elemento.
* **`select: aBlock`**: Devuelve una nueva colección con los elementos donde el bloque evalúa a `true`.
* **`reject: aBlock`**: Devuelve una nueva colección con los elementos donde el bloque evalúa a `false`.
* **`collect: aBlock`**: Devuelve una nueva colección con los resultados de evaluar el bloque en cada elemento.
* **`detect: aBlock` / `detect: aBlock ifNone: exceptionBlock`**: Devuelve el **primer elemento** para el cual el bloque da `true`. Si ninguno cumple, da error o evalúa `exceptionBlock`.
* **`inject: thisValue into: binaryBlock`**: Acumula un resultado evaluando un bloque de 2 argumentos `[:acumulador :elemento | ...]`, comenzando con el valor inicial `thisValue`.

### 3. Creación de Instancias y Conversión
* **Creación con elementos (`Collection class`)**: `with:Obj1`, `with:Obj1 with:Obj2` (hasta 4 argumentos con `with:with:with:with:`).
* **Conversión entre colecciones**:
  * `asBag` (desordenada, permite duplicados).
  * `asSet` (desordenada, **elimina duplicados**).
  * `asOrderedCollection` (ordenada secuencialmente).
  * `asSortedCollection` / `asSortedCollection: aBlock` (ordenada por `<=` o según el bloque de ordenamiento).