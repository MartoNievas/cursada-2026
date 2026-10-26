# Resumen del Paper / Libro: El Patrón Strategy
**Referencia:** *Design Patterns: Elements of Reusable Object-Oriented Software* (Gamma, Helm, Johnson, Vlissides - GoF) / Adaptación y consideraciones idiomáticas en *The Design Patterns Smalltalk Companion*.

---

## 1. Intención y Otros Nombres
- **Intención:** Define una familia de algoritmos, encapsula cada uno de ellos y los hace intercambiables. Strategy permite que el algoritmo varíe independientemente de los clientes que lo utilizan.
- **Otros Nombres:** *Policy* (Política).

---

## 2. Motivación y Diagnóstico
En el diseño de sistemas interactivos (como procesadores de texto, sistemas de layout gráfico o motores de enrutamiento), a menudo una clase central requiere aplicar algoritmos complejos que admiten múltiples variantes (por ejemplo, partición de líneas de texto, compresión de datos o cálculo de rutas).

### El Diagnóstico del Problema:
1. **Acoplamiento rígido e inflación del cliente (Intento ingenuo):**
   * Incorporar la lógica del algoritmo dentro de la propia clase `Context` (como `Composition`) satura al objeto con responsabilidades ajenas a su dominio principal, dificultando su comprensión y mantenimiento.
   * Si coexisten múltiples algoritmos dentro de la misma clase, el código se fragmenta en ramas condicionales masivas para alternar entre ellos.
2. **Proliferación de subclases estáticas (Intento por herencia):**
   * Subclasificar `Composition` para cada algoritmo (`SimpleComposition`, `TeXComposition`) produce una explosión jerárquica rígida. No permite alterar el algoritmo de un objeto en tiempo de ejecución ni reutilizar el mismo algoritmo en otras clases cliente.
3. **Solución polimórfica (Encapsulación de políticas):**
   * Se crea una raíz abstracta `Compositor` que define una interfaz polimórfica de ejecución para la familia de algoritmos.
   * Cada variante algorítmica se encapsula en una subclase independiente (`SimpleCompositor`, `TeXCompositor`, `ArrayCompositor`).
   * `Composition` delega el formateo en una instancia de `Compositor` almacenada en una variable de instancia, pudiendo reemplazar la estrategia en cualquier momento sin afectar a los consumidores del contexto.

---

## 3. Aplicabilidad
El patrón Strategy se utiliza cuando:
- Múltiples clases relacionadas difieren únicamente en su comportamiento. Las estrategias proveen un mecanismo para configurar una clase con uno de entre varios comportamientos posibles.
- Se necesitan distintas variantes de un algoritmo (por ejemplo, algoritmos que reflejan diferentes compromisos de espacio vs. tiempo o precisión vs. rendimiento).
- Un algoritmo utiliza datos o estructuras auxiliares complejas que los clientes no deberían conocer ni manipular.
- Una clase define múltiples comportamientos representados por sentencias condicionales múltiples (`switch` o `if-else` encadenados). Strategy permite trasladar cada rama condicional a una clase propia y resolver la selección por polimorfismo.

---

## 4. Estructura y Participantes

```
             Cliente (Client)
                   │
                   ▼
           Context (Composition) ──────────────┐
         - compositor (Compositor)             │ compone / delega
         - repair()                            │
         - compositor: aCompositor             │
                                               ▼
                                      Strategy (Compositor)
                                    - compose()
                                          /   \
                                         /     \
                                        /       \
        ConcreteStrategyA (SimpleCompositor)    ConcreteStrategyB (TeXCompositor)
        - compose()                             - compose()
```

- **Strategy (`Strategy` / `Compositor`):** Declara una interfaz común para todos los algoritmos soportados. Es la abstracción que `Context` utiliza para invocar el algoritmo definido por un `ConcreteStrategy`.
- **ConcreteStrategy (`SimpleCompositor`, `TeXCompositor`, `ArrayCompositor`):** Implementa el algoritmo concreto utilizando la interfaz declarada por `Strategy`.
- **Context (`Context` / `Composition`):**
  - Mantiene una referencia a un objeto `ConcreteStrategy`.
  - Se configura con un objeto `Strategy` (en la inicialización o dinámicamente).
  - Puede definir una interfaz que permita a `Strategy` acceder a sus datos internos.
- **Cliente (`Client`):** Crea un objeto `ConcreteStrategy` específico y lo pasa al `Context`. A partir de allí, el cliente interactúa exclusivamente con el `Context`.

---

## 5. Colaboraciones
1. El cliente crea una instancia de un `ConcreteStrategy` y la asocia al `Context`.
2. Cuando el `Context` necesita ejecutar el algoritmo (por ejemplo, ante el mensaje `#repair`), delega el cómputo en su estrategia (`compositor compose`).
3. Para realizar el cálculo, el `Context` transfiere los datos requeridos a la estrategia:
   * Enviando los valores directamente como argumentos del método.
   * Pasándose a sí mismo (`self`) como colaborador para que la estrategia invoque callbacks sobre el contexto.
4. El cliente interactúa habitualmente con el `Context`, aunque es el encargado de proveer la estrategia inicial o de conmutarla cuando las condiciones operacionales lo requieran.

---

## 6. Consecuencias

### Ventajas:
- **Familias de algoritmos reutilizables:** Las jerarquías de `Strategy` definen familias de algoritmos aislados que pueden ser reutilizados por diferentes contextos a lo largo del sistema.
- **Alternativa superior al subclasificado:** Evita heredar del `Context`, lo que mezclaría la lógica del algoritmo con la gestión de los datos del dominio y congelaría la elección del comportamiento en tiempo de compilación.
- **Eliminación sistemática de condicionales:** Suprime bloques `if-else` o sentencias `switch` en el `Context`, reemplazando la selección manual de rutas por despacho dinámico polimórfico.
- **Libertad en la elección de implementaciones:** Permite a los clientes seleccionar estrategias optimizadas para contextos particulares (por ejemplo, priorizar velocidad de procesamiento sobre uso de memoria).

### Desventajas / Consideraciones en Smalltalk:
- **Exposición del cliente a detalles de diseño:** El cliente debe comprender las diferencias y *trade-offs* entre las distintas estrategias para elegir la apropiada, exponiendo criterios de implementación que idealmente estarían ocultos.
- **Sobrecosto de comunicación (*Communication Overhead*):** La interfaz abstracta de `Strategy` debe acomodar las necesidades de todas las estrategias de la familia. Esto suele provocar que estrategias simples reciban parámetros o colaboradores que jamás utilizarán.
- **Incremento en el volumen de objetos:** Se multiplica el número de instancias y clases en memoria, aunque puede mitigarse mediante estrategias desprovistas de variables de instancia compartidas como *Flyweights*.

---

## 7. Detalles de Implementación en Smalltalk

1. **Estrategias basadas en bloques (Pluggable Strategies):**
   * En Smalltalk, no siempre es obligatorio construir una jerarquía completa de clases `Strategy`. Si el algoritmo es conciso, una instancia de `BlockClosure` funciona como una estrategia idiomática ligera (por ejemplo, el bloque de ordenamiento provisto a un `SortedCollection`: `[ :a :b | a < b ]`).
2. **Estrategia por defecto en el Contexto:**
   * El `Context` puede inicializar una estrategia por defecto en su método `#initialize` (por ejemplo, un algoritmo simple y rápido). Así, los clientes comunes evitan la obligación de configurarlo a mano y solo inyectan una estrategia cuando necesitan un comportamiento especializado.
3. **Técnicas de pasaje de información:**
   * *Data Passing:* El contexto pasa valores escalares (`strategy calculateFor: width and: height`). Máximo desacoplamiento, pero la firma del método puede inflarse.
   * *Context Passing:* El contexto pasa `self` (`strategy compose: self`). Simplifica las firmas polimórficas y permite a la estrategia pedir únicamente los accesores que requiere, a costa de acoplar la estrategia al protocolo público del `Context`.
4. **Estrategias sin estado (Stateless / Flyweight):**
   * En Smalltalk es habitual mantener instancias únicas de estrategias en variables de clase o en un diccionario global si estas no retienen variables de instancia, evitando la sobrecarga en el *Garbage Collector*.

---

## 8. Código de Ejemplo (Smalltalk - Formateador de Líneas de Texto)

Contexto:

```smalltalk
Object subclass: #ComposicionTexto
    instanceVariableNames: 'texto compositor lineasFormateadas'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-Strategy'

ComposicionTexto >> initialize
    super initialize.
    texto := ''.
    compositor := CompositorSimple new. "Estrategia por defecto"
    lineasFormateadas := OrderedCollection new.

ComposicionTexto >> texto: unString
    texto := unString.
    self formatear.

ComposicionTexto >> compositor: unCompositor
    compositor := unCompositor.
    self formatear.

ComposicionTexto >> texto
    ^texto

ComposicionTexto >> lineasFormateadas
    ^lineasFormateadas

ComposicionTexto >> formatear
    "Delega la responsabilidad del cómputo pasando self como colaborador"
    lineasFormateadas := compositor componerLineasPara: self.
```

Estrategia abstracta:

```smalltalk
Object subclass: #Compositor
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-Strategy'

Compositor >> componerLineasPara: unaComposicion
    self subclassResponsibility
```

Estrategias concretas:

```smalltalk
Compositor subclass: #CompositorSimple
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-Strategy'

CompositorSimple >> componerLineasPara: unaComposicion
    "Corta el texto simplemente cada vez que encuentra un espacio"
    ^unaComposicion texto findTokens: ' '
```

```smalltalk
Compositor subclass: #CompositorTeX
    instanceVariableNames: 'longitudLinea'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-Strategy'

CompositorTeX >> initialize
    super initialize.
    longitudLinea := 15.

CompositorTeX >> longitudLinea: unEntero
    longitudLinea := unEntero

CompositorTeX >> componerLineasPara: unaComposicion
    "Algoritmo simulado que agrupa palabras respetando una longitud fija"
    | palabras lineas lineaActual |
    palabras := unaComposicion texto findTokens: ' '.
    lineas := OrderedCollection new.
    lineaActual := ''.
    
    palabras do: [ :cadaPalabra |
        (lineaActual size + cadaPalabra size > longitudLinea)
            ifTrue: [
                lineas add: lineaActual.
                lineaActual := cadaPalabra ]
            ifFalse: [
                lineaActual := lineaActual isEmpty
                    ifTrue: [ cadaPalabra ]
                    ifFalse: [ lineaActual , ' ' , cadaPalabra ] ] ].
                    
    lineaActual isEmpty ifFalse: [ lineas add: lineaActual ].
    ^lineas
```

Uso por el cliente:

```smalltalk
| composicion |
composicion := ComposicionTexto new.
composicion texto: 'El patron Strategy encapsula familias de algoritmos intercambiables'.

"1. Utiliza la estrategia simple por defecto"
Transcript show: 'Salida Simple: '; cr.
composicion lineasFormateadas do: [ :cada | Transcript show: cada; cr ].

"2. El cliente conmuta a una estrategia avanzada en tiempo de ejecución"
composicion compositor: (CompositorTeX new longitudLinea: 20).

Transcript show: 'Salida TeX: '; cr.
composicion lineasFormateadas do: [ :cada | Transcript show: cada; cr ].
```

---

## 9. Usos Conocidos en el Entorno Smalltalk
- **`SortedCollection` (SortBlock):** La colección ordenada utiliza una estrategia basada en un bloque binario (`sortBlock: [ :a :b | a <= b ]`) para gobernar el criterio de ordenamiento sin alterar la estructura interna de la colección.
- **VisualWorks (LayoutManagers / Controllers):** La distribución de submorfos o vistas hijas en contenedores gráficos delega en clases `LayoutManager` (como `RowLayout`, `TableLayout`), desacoplando el dibujo del cálculo de coordenadas.
- **Streams y Serializadores (Formatters):** Las herramientas de persistencia y serialización de objetos delegan el formato de salida (binario, JSON, XML) en formateadores intercambiables configurados sobre el stream base.

---

## 10. Patrones Relacionados
- **State:** Presenta una estructura idéntica basada en composición y delegación hacia una jerarquía polimórfica. Se diferencian radicalmente en la **intención**: Strategy parametriza un algoritmo estático o intercambiable configurado generalmente desde afuera por el cliente; State modela un ciclo de vida con transiciones automáticas y reactivas al estado interno del contexto.
- **Flyweight:** Es sumamente común que las instancias de `ConcreteStrategy` carezcan de variables de instancia, permitiendo que múltiples contextos compartan las mismas instancias como Flyweights.
- **Template Method:** Resuelve la variación de algoritmos mediante herencia estática (sobrescribiendo métodos hook en subclases); Strategy lo resuelve mediante composición dinámica (delegando la totalidad del algoritmo en un colaborador externo).
- **Decorator:** Decorator altera al componente agregándole responsabilidades por fuera (envolviéndolo); Strategy altera el comportamiento del contexto desde adentro reemplazando una de sus partes operativas.