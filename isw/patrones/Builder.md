# Resumen del Paper / Libro: El Patrón Builder
**Referencia:** *The Design Patterns Smalltalk Companion* (Alpern, Benson, Lee, Rising, Smith; con contribuciones de Ralph Johnson y John Vlissides) / Adaptación del libro de GoF a Smalltalk.

---

## 1. Intención y Otros Nombres
- **Intención:** Separar la construcción de un objeto complejo de su representación, de modo que el mismo proceso de construcción pueda crear diferentes representaciones.
- **Otros Nombres:** *Constructor*.

---

## 2. Motivación y Diagnóstico
En sistemas orientados a objetos, a menudo se necesita instanciar y configurar objetos complejos que contienen múltiples partes relacionadas (como un analizador de documentos que produce vistas ricas, árboles de sintaxis abstracta o representaciones en texto plano, o la inicialización de vistas complejas compuestas).

### El Diagnóstico en Smalltalk:
1. **Acoplamiento entre análisis y creación (Intento ingenuo):**
   * Si el objeto que lee la estructura (por ejemplo, un parser de RTF, HTML o un lector de configuraciones) instancia directamente las clases concretas que representarán el resultado, queda rígidamente acoplado a un único formato de salida.
   * Agregar un nuevo tipo de salida (por ejemplo, exportar a texto ASCII en vez de a una jerarquía gráfica de texto con estilos) exige modificar o duplicar la lógica de análisis (*parsing*).
2. **Separación por construcción paso a paso (Director y Builder):**
   * Se aísla el algoritmo que determina *qué partes componen al objeto y en qué orden se procesan* dentro de un objeto **Director** (ej. `RTFReader`).
   * Se delega la tarea de instanciar y ensamblar las piezas concretas a un objeto **Builder** mediante un protocolo polimórfico de construcción incremental (`buildPart`, `convertCharacter:`, `fontChange:`).
   * Al intercambiar el Builder provisto al Director, el mismo recorrido genera productos con estructuras y clases internas completamente disímiles.

---

## 3. Aplicabilidad
El patrón Builder se utiliza cuando:
- El algoritmo de creación de un objeto complejo debe ser independiente de las partes que lo componen y de cómo se ensamblan.
- El proceso de construcción debe permitir diferentes representaciones internas para el objeto que se está construyendo.
- La construcción involucra una secuencia obligatoria de pasos incrementales o variables que resulta engorrosa de encapsular en constructores tradicionales con listas extensas de parámetros.

---

## 4. Estructura y Participantes

```
   Director (RTFReader)                          Builder (TextConverter)
- builder: aBuilder                - buildPart / convertCharacter: aChar
- construct                        - result / getResult
        │                                         ▲
        │ usa                                     │
        ▼                                         │
┌──────────────┐                       ┌─────────────────────┐
│              ├──────────────────────►│                     │
└──────────────┘                       └──────────┬──────────┘
                                                  │
                                  ┌───────────────┴───────────────┐
                                  │                               │
                       ConcreteBuilderA                ConcreteBuilderB
                     (ASCIIConverter)                (LayoutConverter)
                   - convertCharacter: aChar       - convertCharacter: aChar
                   - result                        - result
                          │                               │ crea
                          ▼ crea                          ▼
                  ProductA (String)              ProductB (TextLayout)
```

- **Director (`Director` / `RTFReader`):** Controla el proceso de construcción. Conoce la secuencia correcta de pasos y le envía mensajes al Builder, pero desconoce la estructura concreta del producto final.
- **Builder (`Builder` / `TextConverter`):** Declara una interfaz abstracta con el protocolo de construcción incremental para todas las partes posibles del producto.
- **BuilderConcreto (`ConcreteBuilder` / `ASCIIConverter`, `TextLayoutConverter`):** Implementa el protocolo de construcción, mantiene el estado del producto durante el ensamblado y provee una interfaz para recuperarlo (`result`).
- **Producto (`Product` / `String`, `TextLayout`):** Representa el objeto complejo resultante. A diferencia de otros patrones creacionales, los productos no necesitan compartir una superclase común.
- **Cliente (`Client`):** Crea el Builder concreto, lo asocia al Director, ordena iniciar la construcción (`director construct`) y finalmente le pide el producto resultante al Builder.

---

## 5. Colaboraciones
1. El cliente crea una instancia de un `ConcreteBuilder`.
2. El cliente instancia el `Director` y le asigna el builder recién creado (`director builder: aBuilder`).
3. El cliente le ordena al `Director` que inicie el proceso (`director construct`).
4. El `Director` procesa la entrada y le envía mensajes sucesivos al Builder a medida que detecta las distintas partes (`builder convertFont: ...`, `builder convertCharacter: ...`).
5. El `ConcreteBuilder` acumula y ensambla internamente las partes recibidas.
6. El cliente recupera el producto terminado consultando directamente al Builder (`aBuilder result`).

---

## 6. Consecuencias

### Ventajas:
- **Variación libre de la representación interna:** Permite alternar la estructura interna del producto sin tocar la lógica del Director; el Builder encapsula cómo se conectan y construyen las partes.
- **Aislamiento de código de construcción y representación:** Modulariza algoritmos complejos de análisis o cálculo estructural, separándolos de las clases que almacenan el modelo de datos.
- **Control granular sobre el proceso de construcción:** A diferencia de una factoría abstracta que crea el objeto de una sola vez, Builder lo hace paso a paso bajo el control explícito del Director.

### Desventajas / Consideraciones en Smalltalk:
- **Ausencia de interfaz común para los productos:** Como los productos suelen ser de naturalezas totalmente distintas (por ejemplo, un simple `String` vs. un grafo de `VisualComponent`), el método `#result` no tiene un contrato polimórfico común más allá de retornar un objeto, dejando la responsabilidad del uso en el cliente.
- **Métodos hook vacíos en Builder abstracto:** En Smalltalk es común que la superclase `Builder` defina los métodos de construcción con implementaciones vacías (`^self`) en vez de `subclassResponsibility`. Esto permite que builders simples (como un extractor que solo busca enlaces) ignoren la mayoría de los eventos sin verse obligados a implementar todo el protocolo.

---

## 7. Detalles de Implementación en Smalltalk

1. **Protocolo vacío por defecto (*Null Implementation*):**
   * En Smalltalk, la clase abstracta `Builder` raramente lanza excepciones en sus métodos de paso. Provee métodos por defecto sin operación (`^self`), facilitando que los `ConcreteBuilder` solo sobreescriban los pasos que realmente les interesa capturar.
2. **Métodos de Configuración en Cascada:**
   * Dado el soporte nativo de Smalltalk para mensajes en cascada (`;`), a menudo el Director se simplifica o se prescinde de él si el cliente asume el rol de invocar directamente la secuencia de construcción sobre el builder:
     ```smalltalk
     builder
         addHeader: 'Reporte';
         addSection: 'Datos';
         buildFooter.
     ```
3. **Manejo del Producto:**
   * El producto suele instanciarse en el `#initialize` del builder concreto o crearse perezosamente (*lazily*) en el primer paso de construcción, manteniéndose en una variable de instancia hasta que el cliente envía `#result` o `#build`.

---

## 8. Código de Ejemplo (Smalltalk - Conversor de Documentos Simplificado)

Componente abstracto Builder:

```smalltalk
Object subclass: #DocumentBuilder
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-Builder'

DocumentBuilder >> addTitle: aString
    "Implementación nula por defecto"
    ^self

DocumentBuilder >> addParagraph: aString
    "Implementación nula por defecto"
    ^self

DocumentBuilder >> result
    self subclassResponsibility
```

Builders concretos:

```smalltalk
DocumentBuilder subclass: #PlainTextBuilder
    instanceVariableNames: 'stream'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-Builder'

PlainTextBuilder >> initialize
    super initialize.
    stream := WriteStream on: String new.

PlainTextBuilder >> addTitle: aString
    stream nextPutAll: aString asUppercase; newLine; newLine.

PlainTextBuilder >> addParagraph: aString
    stream nextPutAll: aString; newLine; newLine.

PlainTextBuilder >> result
    ^stream contents
```

```smalltalk
DocumentBuilder subclass: #HTMLDocumentBuilder
    instanceVariableNames: 'stream'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-Builder'

HTMLDocumentBuilder >> initialize
    super initialize.
    stream := WriteStream on: String new.
    stream nextPutAll: '<html><body>'; newLine.

HTMLDocumentBuilder >> addTitle: aString
    stream nextPutAll: '<h1>'; nextPutAll: aString; nextPutAll: '</h1>'; newLine.

HTMLDocumentBuilder >> addParagraph: aString
    stream nextPutAll: '<p>'; nextPutAll: aString; nextPutAll: '</p>'; newLine.

HTMLDocumentBuilder >> result
    stream nextPutAll: '</body></html>'.
    ^stream contents
```

Director:

```smalltalk
Object subclass: #DocumentReader
    instanceVariableNames: 'builder'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-Builder'

DocumentReader >> builder: aDocumentBuilder
    builder := aDocumentBuilder

DocumentReader >> parse: anArrayOfLines
    "El algoritmo de lectura define los pasos y el orden"
    anArrayOfLines isEmpty ifTrue: [ ^self ].

    builder addTitle: anArrayOfLines first.

    anArrayOfLines allButFirst do: [ :eachLine |
        builder addParagraph: eachLine
    ]
```

Uso por el cliente:

```smalltalk
| reader txtBuilder htmlBuilder textoPlano documentoHtml lineas |
lineas := #('Patrones de Disenio' 'El patron Builder separa la construccion...' 'Fin del reporte.').

reader := DocumentReader new.

"Construcción en texto plano"
txtBuilder := PlainTextBuilder new.
reader builder: txtBuilder.
reader parse: lineas.
textoPlano := txtBuilder result.

"Construcción en HTML con el mismo proceso de lectura"
htmlBuilder := HTMLDocumentBuilder new.
reader builder: htmlBuilder.
reader parse: lineas.
documentoHtml := htmlBuilder result.
```

---

## 9. Usos Conocidos en el Entorno Smalltalk
- **TextConverter / Parsing de Streams:** La jerarquía de convertidores de codificación de caracteres y formato enriquecido en Squeak, Pharo y VisualWorks actúa frecuentemente como builder, procesando flujos crudos para construir representaciones en memoria.
- **UI Builders (VisualWorks UIPainter / Spec):** Los frameworks de interfaz gráfica utilizan constructores que reciben especificaciones declarativas y van instanciando y vinculando los componentes visuales (`Window`, `Button`, `InputField`) paso a paso.
- **Compiladores y AST Builders:** Al analizar el código fuente, el parser recorre los tokens y delega en un *AST Builder* la instanciación de los nodos del árbol (`MessageNode`, `BlockNode`), permitiendo construir árboles de ejecución reales o simples analizadores estáticos.

---

## 10. Patrones Relacionados
- **Abstract Factory:** Ambos son patrones creacionales, pero Abstract Factory se centra en crear familias de objetos independientes de manera inmediata, mientras que Builder se enfoca en construir un único objeto complejo paso a paso.
- **Composite:** Frecuentemente el producto que construye un Builder concreto es una estructura jerárquica basada en Composite.
- **Template Method:** El método `construct` del Director a menudo sigue la estructura de un algoritmo fijo que llama a pasos primitivos parametrizados (en este caso delegados al Builder en lugar de a subclases).
