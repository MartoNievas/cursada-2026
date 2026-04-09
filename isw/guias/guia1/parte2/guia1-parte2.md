# Guía de Ejercicios - Ingeniería de Software I
## Parte 1: Introducción al paradigma, el lenguaje y sus herramientas
### Sección 2: Introducción al lenguaje Smalltalk

> Los enunciados de los ejercicios se encuentran en el PDF aparte [Enunciados](guia1-seccion2.pdf).

---

## Ejercicio 0: Debugger

### 0.1

![Debugger](img/debugger.png) 

| Sección | Descripción |
|:-------:|:-----------:|
| **Stack de llamadas** | Muestra la cadena de mensajes enviados hasta llegar al punto de ejecución actual |
| **Barra de estado** | Indica el estado del método actual y el change set al que pertenece |
| **Barra de navegación** | Permite explorar el código relacionado al método actual, como sus implementaciones, versiones y jerarquía |
| **Barra de acciones** | Controla el flujo de ejecución del debugger, permite avanzar, reiniciar o entrar en los métodos |
| **Panel de código** | Muestra el código fuente del método que se está ejecutando actualmente |
| **Panel self** | Muestra el objeto receptor y sus variables de instancia |
| **Receiver scope** | Muestra los valores de las variables del objeto receptor en el contexto actual |
| **thisContext** | Muestra las variables temporales del contexto de ejecución actual |
| **Context scope** | Muestra las variables del contexto del bloque o método en ejecución |

### 0.2

[Ver codigo](code/ejercicio0-2.st)

- **Into (Step Into):**
Entra dentro del método que se está ejecutando para ver su detalle paso a paso.

  **Over (Step Over):**
Ejecuta el método completo sin entrar en su implementación.

  **Through (Step Return):**
Ejecuta el resto del método actual y vuelve al contexto anterior.

- Lo que sucede al hacer click en **Restart** es que comienza nuevamente la ejecución del método actual.

- El debugger queda ubicado al inicio del método 2 y la variable `aVar` tiene el valor que tenía en el último mensaje de `m2`, es decir, ese último mensaje se respondió, pero reinicié la ejecución del mensaje `m2`.

---

## Ejercicio 1: Colecciones

### 1.1

- **a)** Como dice el nombre, son colecciones de tamaño fijo, entonces si intentamos agregar un elemento mandaría una excepción.

  ![Fix length collection](img/collection.png) 

- **b) Ordered Collections**

  ```Smalltalk
    x := OrderedCollection with: 4 with: 3 with: 2 with: 1.

    x add: 42.
    x add: 2.

    x size.
  ```

   La colección cuenta con 6 elementos. Utilizando el mensaje `size` se puede visualizar su tamaño, y si imprimimos la colección podremos ver que el 2 aparece 2 veces. 

- **c) Sets**
  
  ```Smalltalk
  x := Set with: 4 with: 3 with: 2 with: 1.

  x add: 42.
  x add: 2.

  x size.
  ```

  La colección tiene 5 elementos, ya que como es un conjunto el 2 solo aparece una vez.

- **d) Dictionary**

  ```Smalltalk
  x := Dictionary new.
  x add: #a->4; add: #b->3; add: #c->1; add: #d->2; yourself.

  x add: #e->42.

  x size .

  x keys.
  x values.

  x at: #a.

  x at: #z ifAbsent: [24].
  ```
  La colección tiene 5 elementos.

### 1.2

- **e)**  Conversión de array a Set y OrderedCollection.

  ```Smalltalk
  x := #(1 2 3 4).

  x asSet .

  x asOrderedCollection .
  ```

- **f)** Conversión de Set a Array.
  
  ```Smalltalk
  x := Set with: 4 with: 3 with: 2 with: 1.

  x asArray .
  ```
    
- **g)** Lo que retorna al convertir un diccionario en array es la lista con los valores del diccionario.

### 1.3

Código que filtra impares con `#whileTrue`.
  
  ```Smalltalk
|elements index odds|

elements := #(1 2 4 6 9).
odds := OrderedCollection new.
index := 1.

[index <= elements size] whileTrue: [
    ((elements at: index) odd) ifTrue: [odds add: (elements at: index)].
    index := index + 1.
].

odds.
```

### 1.8

Código que filtra impares con `#do`.
```Smalltalk 
|elements odds|

elements := #(1 2 4 6 9).
odds := OrderedCollection new.

elements do: [:element | element odd ifTrue: [odds add: element ]].

odds.
```

La ventaja que nos ofrece `#do:` contra `#whileTrue` es que nos ahorra tener que verificar una condición de salida tan trivial como lo es el índice, además de que el código es mucho más declarativo con `#do:`. Por otro lado, no tenemos que utilizar un contador.

### 1.9

Código que filtra impares con `#select`.

```Smalltalk
|elements odds|

elements := #(1 2 4 6 9).
odds := OrderedCollection new.

odds := elements select: [:element | element odd].

odds. #(1 9) .
```
Ventajas de `#select:` contra `#do:`: todavía más declarativo, no hace falta insertar cada elemento, filtra en base a un predicado.

### 1.10 y 1.11

Primero vamos con el código con el mensaje `#whileTrue:`:

```Smalltalk
|elements double index|

elements  := #(1 2 3 4 5).
index := 1.
double := OrderedCollection  new.

[index <= elements size] whileTrue: [
		double add: (elements at: index) * 2.
		index := index + 1.
	].

double .
```

Ahora con el código con el mensaje `#do:`:

```Smalltalk
|elements double|

elements  := #(1 2 3 4 5).
double := OrderedCollection  new.

elements do: [:element | double add: element *2].

double .
```

El valor se debe acumular en otro objeto auxiliar de tipo OrderedCollection.

### 1.12

Ahora vamos con el mensaje específico para resolver esto de manera compacta, el cual es `#collect:`:

```Smalltalk
|elements double|

elements  := #(1 2 3 4 5).
double := OrderedCollection  new.

double  := elements collect: [:aElement | aElement  * 2]
```

Este nuevo mensaje retorna un nuevo objeto de tipo Array que contiene el resultado de aplicar el closure.

### 1.13

Primero la versión con `#whileTrue` para encontrar un par:

```Smalltalk
|elements even index|

elements  := #(1 2 3 4 5).
index := 1.

even := [index  <= elements size] whileTrue: [ 
	(elements at: index ) even ifTrue: [
			^ elements at: index .
		].
		index := index + 1.
	].
```

Ahora con el mensaje `#do:`:

```Smalltalk
|elements even| 

elements := #(1 2 3 4 5).

even := elements do: [:element | element even ifTrue: [^ element ]].
```

Ahora con el mensaje específico `#findFirst:`, al cual se le debe pasar un closure con el predicado que debe cumplir el elemento de la colección:

```Smalltalk
|elements even| 

elements := #(1 2 3 4 5).

even := elements findFirst: [:element | element even]. 2 .
```

### 1.14

Lo que ocurre si utilizamos una secuencia sin pares es que retorna 0 por defecto.

### 1.15

Código modificado para generar un error si no hay pares.

```Smalltalk
|elements | 

elements := #(1 3 2  5).

firstIndex := elements findFirst: [:element | element even].
firstIndex := 0 ifTrue: [self  error: 'No hay pares'].
```

### 1.16 y 1.17

Asumimos que `#whileTrue` y `#do` ya sabemos hacerlos. Vamos con el mensaje específico `#inject:into:`.

>**Nota:** el `inject:` es el caso base y `into:` toma el acumulador y el elemento i-ésimo.

```Smalltalk
|elements sum|

elements := #(1 2 3 4 5).

sum := elements inject: 0 into: [:aPartialSum :aNumber | aPartialSum  + aNumber ]. 
```

Y el mensaje específico para la suma es `#sum`:

```Smalltalk
|elements sum|

elements := #(1 2 3 4 5).

sum := elements sum.
```


### 1.18

Código para filtrar vocales conservando el orden relativo:

```Smalltalk
|aString |

aString := 'hola mi nombre es martin'.

aString select: [:aChar | aChar isVowel ].
```

>**Nota:** `#select:` es básicamente un filter de programación funcional.

### 1.19

Se observa que comparten una interfaz de mensajes.

### 1.20

Algunas las conocía de **PLP**.


---

## Ejercicio 2: Bloques (Closures)

### a)

La definición de **Blocks** en el libro **Smalltalk-80 The Language and its Implementation** es:

### b)

El valor que retorna un bloque al enviar el mensaje `value` es el valor del último mensaje en la secuencia.

### c)

Con el código:

```Smalltalk
|x|
x := [y := 1. z := 2].
x value.
```

cuando hago el `value` de `x` se imprime 2 por pantalla.

- i. Lo que sucede si querés acceder a una variable definida en el bloque por fuera del mismo es que se imprime el valor que se definió en el bloque.

- ii. Lo que pasa es que el bloque captura la variable y le cambia el valor por el asignado en el mismo.

- iii. Un ejemplo de bloque con 2 parámetros es el siguiente:

```Smalltalk
|x|
x := [:aNumber1 :aNumber2 | aNumber1  + aNumber2 ].

x value: 1 value: 2
```

---

## Ejercicio 3: Símbolos

### c)

El resultado es que se crea un nuevo objeto con todos los caracteres concatenados (uno al lado del otro sin separación).

---

## Ejercicio 4: Medidas

### 4.2

El resultado de `10 * peso + 10 * dollar` es un error por el tema de la precedencia de las operaciones, lo que genera un `MessageNotUnderstood` en **BaseUnit** con el mensaje `multiplyCompoundMeasure`.

Para que se evalúe de forma correcta debería escribirse así: `(10 * peso) + (10 * dollar)`.

### 4.3

Vamos a poner las colaboraciones con la predicción de lo que se va a obtener:

- `10 * peso + (10 * dollar)`: se va a obtener `10 * dollars + 10 * pesos.` 

- `10 * peso + (10 * dollar) - (2 * dollar)`: se va a obtener `10 * pesos + 8 * dollars.`

- `10 * peso + (10 * dollar) - (2*dollar) - (8 * dollar).`: se va a obtener `10 * pesos`.

### 4.4

El peso es un objeto del tipo **BaseUnit**.

### 4.5

Es una **SimpleMeasure**. Ya no sigue siendo una unidad como antes, ahora es una cantidad.

### 4.6

El amount de un número es el mismo número y la unidad en este caso es la **NullUnit**.

### 4.7

Ambos devuelven una CompoundMeasure, ya que mezclan distintas unidades.

### 4.8

En este contexto el símbolo **$$** es lo que se le asigna al colaborador interno `sign`, que representa el signo de la unidad.

### 4.9

```Smalltalk
| metros centimetros |

metros := BaseUnit nameForOne: 'metro' nameForMany: 'metros'.

centimetros := ProportionalDerivedUnit baseUnit: metros conversionFactor: 1/100 named: 'centimetro'.

(10 * metros) + (500 * centimetros). 
```

### 4.10

```Smalltalk
| metros |

metros := BaseUnit nameForOne: 'metro' nameForMany: 'metros'.
diezMetros := 10 * metros.

pulgadas := ProportionalDerivedUnit baseUnit: metros conversionFactor: 1/39 named: 'pulgadas'.
sesentaPulgadas := 60 * pulgadas .

diezMetros  + sesentaPulgadas .
```

### 4.11

```Smalltalk
| kelvin celcius fahrenheit |

kelvin := BaseUnit nameForOne: 'kelvin' nameForMany: 'kelvin'.

celcius := NotProportionalDerivedUnit 
    baseUnit: kelvin 
    conversionBlock: [:k | k - (5463/20)] 
    reciprocalConversionBlock: [:c | c + (5463/20)] 
    named: 'celcius'.

fahrenheit := NotProportionalDerivedUnit  
    baseUnit: kelvin 
    conversionBlock: [:k | (k - (5463/20)) * (9/5) + 32]  
    reciprocalConversionBlock: [:f | (f - 32) * (5/9) + (5463/20)] 
    named: 'fahrenheit'.

(30 * kelvin) + (20 * celcius) + (10 * fahrenheit).
```

---

## Ejercicio 5: Fechas

### 5.1

**Evaluaciones**

### 5.2

```Smalltalk
FixedGregorianDate today next: 7 * day .
```

### 5.3

```Smalltalk
FixedGregorianDate today  next: 24 * second .
```

Esto genera un error, ya que la unidad mínima es un día.

### 5.4

```Smalltalk
FixedGregorianDate today  next: 86400 * second.
```

Esto no genera error ya que le estamos sumando un día.

### 5.5

- a) Lo que pasa es que genera un **MessageNotUnderstood**. Esto porque `2024` es un objeto de tipo SmallInteger y no tiene el método para responder al mensaje.

- b) Lo que ocurre al evaluar es que da `true`. Como está representado como una fecha, sí puede responder el mensaje. Esto porque `2024` es un objeto de tipo SmallInteger y no tiene el método para responder al mensaje.

### 5.6

La colaboración corregida es la siguiente:

```Smalltalk
TimeOfDay now next: 3600 * second .
```

Esto se debe a que se espera una unidad de tiempo como parámetro.
