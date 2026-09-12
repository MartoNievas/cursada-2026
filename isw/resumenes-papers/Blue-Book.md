# Traducción Técnica de Smalltalk-80 (Capítulos 6, 7 y 8)

## Introducción a la Parte Dos: El Entorno y Protocolo de Clases
La semántica y sintaxis de Smalltalk-80 son relativamente simples. Sin embargo, el sistema es grande y poderoso debido al gran número y tipos de objetos disponibles. Hay ocho categorías significativas de clases en el sistema Smalltalk-80: núcleo (*kernel*) y soporte de núcleo, medidas lineales, números, colecciones, flujos (*streams*), clases, procesos independientes y gráficos. El protocolo de estos tipos de objetos se revisa detalladamente en la Parte Dos del libro.

Las clases en el sistema Smalltalk-80 se definen en una jerarquía lineal. Las especificaciones adoptan un enfoque enciclopédico: se definen categorías de mensajes, se anota cada mensaje y se proporcionan ejemplos. Al presentar el protocolo de una clase, sin embargo, solo se describen los mensajes agregados por dicha clase. El protocolo completo de mensajes se determina examinando el protocolo especificado en la clase y en cada una de sus superclases. Por lo tanto, es útil presentar las clases comenzando con una descripción de la clase `Object` y proceder en profundidad, de modo que el protocolo heredado pueda entenderse en conjunto con el nuevo protocolo.

---

## Capítulo 6: Protocol for All Objects (Protocolo para Todos los Objetos)
La especificación de la clase `Object` aquí presentada se centra en la funcionalidad estándar compartida por todos los componentes del sistema.

### Probando la Funcionalidad de un Objeto (Testing)
Cada objeto es una instancia de una clase. La funcionalidad de un objeto está determinada por su clase. Esta funcionalidad se prueba de dos maneras: nombrando explícitamente una clase para determinar si es la clase o la superclase del objeto, y especificando un *selector de mensaje* (*message selector*) para determinar si el objeto puede responder a él. Esto refleja dos formas de pensar acerca de la relación entre instancias de diferentes clases: en términos de la jerarquía de clase/subclase, o en términos de protocolos de mensajes compartidos (*shared message protocols*).

### Copiando Objetos (Copying Objects)
El sistema permite duplicar objetos mediante el mensaje `copy`. Evaluar expresiones de copiado ilustra la diferencia técnica entre la identidad del objeto (probada mediante `==`) y la igualdad de valores (probada mediante `=`). A continuación se muestra la evaluación de expresiones de copiado para arreglos literales y cadenas de texto:

```smalltalk
a <- #('first' 'second' 'third')      "Arreglo literal"
b <- a copy
a = b                                  "Responde true (mismo contenido)"
a == b                                 "Responde false (identidades distintas)"
(a at: 1) == (b at: 1)                 "Responde true (elementos internos compartidos)"
b at: 1 put: 'newFirst'.
a = b                                  "Responde false (b ha cambiado, a no)"

a <- 'hello'
b <- a copy
a = b                                  "Responde true"
a == b                                 "Responde false"
```

Para entender la diferencia crítica entre `shallowCopy` (copia superficial) y `deepCopy` (copia profunda), considere la clase `PersonnelRecord`, la cual incluye una variable de instancia `insurancePlan` (una instancia de la clase `Insurance` con un límite de cobertura médica determinado). Si creamos un registro prototípico `employeeRecord` para clonar nuevos empleados mediante `copy` (una copia superficial), la nueva instancia `joeSmithRecord` compartirá exactamente el mismo plan de seguro que el prototipo.

Si la política de la empresa cambia y se evalúa la expresión para modificar el plan de seguro en el prototipo (por ejemplo, restableciendo el límite de cobertura médica), este cambio afectará inmediatamente a `joeSmithRecord` debido a que ambos comparten la referencia al mismo objeto `Insurance`. Una copia profunda (`deepCopy`) habría duplicado de forma recursiva también el objeto del plan de seguro, rompiendo este enlace compartido.

### Accediendo a las Partes de un Objeto (Accessing)
Los mensajes de acceso en Smalltalk-80 se presentan típicamente en pares. Un mensaje de cada par tiene el prefijo `basic` (como `basicAt:`, `basicAt:put:` y `basicSize`). Esto indica que se trata de un mensaje fundamental del sistema cuya implementación no debe ser modificada (*overridden*) en ninguna subclase. El propósito de este diseño es permitir que el protocolo externo común (`at:`, `at:put:` y `size`) pueda ser personalizado o sobrescrito por subclases para manejar casos especiales, garantizando al mismo tiempo que los desarrolladores y el sistema conserven un método directo para invocar las implementaciones primitivas de la máquina virtual. El mensaje `basicSize` puede ser enviado a cualquier objeto; si el objeto no posee una longitud variable, la respuesta de la máquina virtual es 0.

### Impresión y Almacenamiento (Printing and Storing)
El protocolo de mensajes soporta la conversión de objetos a representaciones de texto legibles y archivables. La clase `Object` implementa la funcionalidad base de impresión, que luego la mayoría de las subclases sobrescriben para proporcionar descripciones más ricas. Los argumentos de estos mensajes son típicamente instancias de la clase `Stream` (que se especifica en el Capítulo 12).

El mensaje `printString` en la clase `Object` crea un `WriteStream` temporal, le pide al objeto que se imprima en él usando el mensaje `printOn:`, y luego retorna el contenido de la secuencia de texto resultante como un objeto `String`. A continuación se muestra la implementación precisa del método `printString` provisto en las fuentes:

```smalltalk
printString
    | aStream |
    aStream <- WriteStream on: (String new: 16).
    self printOn: aStream.
    ^aStream contents
```

La diferencia técnica con el mensaje `storeString` es que este último está diseñado para producir una cadena de texto con formato de código ejecutable de Smalltalk-80 válido. Al ser evaluado, este texto debería poder reconstruir el objeto original. Por ejemplo, mientras que un conjunto (`Set`) imprime como `Set ($a $b $c)`, su `storeString` produce `(Set new add: $a; add: $b; add: $c; yourself)`.

### Manejo de Errores (Error Handling)
La clase `Object` define mensajes estándar para reportar errores en tiempo de ejecución. Una subclase puede optar por sobrescribir los mensajes de manejo de errores (como `error:`) con el fin de proporcionar un soporte especial para depurar o corregir la situación errónea de manera interactiva.

---

## Capítulo 7: Linear Measures (Medidas Lineales)
El sistema Smalltalk-80 proporciona un conjunto de clases diseñadas para representar y manipular objetos que cuantifican o miden magnitudes basadas en un ordenamiento lineal. Los ejemplos de magnitudes lineales en el mundo real se agrupan principalmente en tres categorías:
*   **Cantidades temporales:** Objetos que miden el tiempo, tales como fechas (`Date`) y horas (`Time`).
*   **Cantidades espaciales:** Mediciones del espacio como la distancia (`Distance`, que no está implementada en el sistema Smalltalk-80 estándar pero sirve como ejemplo conceptual).
*   **Cantidades numéricas:** Representaciones matemáticas de valores que se pueden comparar linealmente, como números reales y racionales.

### Clase Magnitude (Magnitud)
La clase abstracta `Magnitude` sirve como superclase común y proporciona el protocolo unificado para responder a preguntas de comparación lineal. Sus subclases directas e indirectas heredan la habilidad de ser comparadas en una sola dimensión. Las subclases clave presentes en el sistema son:
1.  `Date`: Representación de fechas civiles.
2.  `Time`: Representación de marcas de tiempo precisas.
3.  `Number`: Superclase de todas las clases numéricas matemáticas.
4.  `Character`: Representa caracteres individuales de texto. Es un ejemplo interesante de objeto inmutable en el sistema (por ejemplo, el carácter literal `$A`).
5.  `LookupKey`: Utilizada como clave en las asociaciones de diccionarios, pospuesta para especificación técnica en los capítulos de colecciones.

Aunque `Magnitude` hereda la comparación de igualdad (`=`) de `Object`, toda subclase concreta de `Magnitude` debe redefinir de manera obligatoria el mensaje `<` (menor que). La clase `Magnitude` implementa `=` como un mensaje de responsabilidad de subclase (`subclassResponsibility`):

```smalltalk
= aMagnitude
    self subclassResponsibility
```

Si una subclase concreta de `Magnitude` no implementa el mensaje `=`, cualquier intento de enviar este mensaje a una de sus instancias provocará un error indicando que la subclase debió haber implementado el mensaje heredado, en lugar de utilizar la declaración abstracta.

---

## Capítulo 8: Numerical Classes (Clases Numéricas)
El sistema numérico de Smalltalk-80 se organiza bajo la clase `Number`. Este capítulo especifica los algoritmos técnicos de división entera, precisión matemática y el comportamiento de la generación de números pseudoaleatorios.

### División Entera y Operaciones de Truncamiento
Un aspecto técnico de gran relevancia en el protocolo numérico es la existencia de dos esquemas distintos de división entera y truncamiento. La distinción matemática y de comportamiento se describe de la siguiente manera:
*   **Truncamiento hacia el Infinito Negativo:** Representado por los selectores `//` (para el cociente entero) y `\\` (para el resto entero, conocido formalmente como la operación de módulo).
*   **Truncamiento hacia Cero:** Representado por los selectores `quo:` (para el cociente entero) y `rem:` (para el resto entero).

**Regla de los Signos:** El resultado de los mensajes `quo:`, `rem:` o `//` siempre devuelve un valor cuyo signo es positivo si el receptor (*receiver*) y el argumento poseen el mismo signo, y negativo si sus signos son diferentes. Por el contrario, la operación de módulo (`\\`) siempre produce un resultado positivo, sin importar los signos del receptor y el argumento.

### Tabla Comparativa de Comportamiento de Truncamiento (Ejemplos Reales)

| Expresión Smalltalk | Operación Matemática | Efecto de Truncamiento | Resultado |
| :--- | :--- | :--- | :--- |
| `6 quo: 2` | 6 / 2 | Hacia cero | `3` |
| `7 quo: 2` | 7 / 2 | Hacia cero | `3` |
| `7 rem: 2` | 7 % 2 | Resto (hacia cero) | `1` |
| `7 // 2` | 7 / 2 | Hacia infinito negativo | `3` |
| `7 \\ 2` | 7 % 2 | Módulo (infinito neg.) | `1` |
| `-7 quo: 2` | -7 / 2 | Hacia cero | `-3` |
| `-7 rem: 2` | -7 % 2 | Resto (hacia cero) | `-1` |
| `-7 // 2` | -7 / 2 | Hacia infinito negativo | `-4` |
| `-7 \\ 2` | -7 % 2 | Módulo (infinito neg.) | `1` |

### Estructura de las Clases Numéricas
La jerarquía del núcleo numérico en Smalltalk-80 se compone de clases abstractas y concretas:
*   `Float`: Representa números de punto flotante de precisión de hardware estándar (IEEE single-precision 32-bit).
*   `Fraction`: Representa de manera exacta números racionales mediante un numerador y un denominador (ambos instancias de `Integer`). Las operaciones aritméticas se simplifican automáticamente a su forma irreducible.
*   `Integer`: Superclase de las representaciones enteras concretas, subdividida internamente en:
    *   `SmallInteger`: para enteros de paso directo representados directamente en el puntero del objeto de forma eficiente en espacio.
    *   `LargePositiveInteger` y `LargeNegativeInteger`: clases de enteros grandes para cálculo de precisión arbitraria por software (sin límite de magnitud).
