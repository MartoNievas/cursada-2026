# Resumen del Paper / Libro: El Patrón Visitor
**Referencia:** *The Design Patterns Smalltalk Companion* (Alpern, Benson, Lee, Rising, Smith; con contribuciones de Ralph Johnson y John Vlissides) / Adaptación del libro de GoF a Smalltalk.

---

## 1. Intención y Otros Nombres
- **Intención:** Representar una operación a ser realizada sobre los elementos de una estructura de objetos. Visitor permite definir una nueva operación sin cambiar las clases de los elementos sobre los cuales opera.
- **Otros Nombres:** *Visitante*, *Doble Despacho (Double Dispatch)*.

---

## 2. Motivación y Diagnóstico
En compiladores, jerarquías gráficas o estructuras compuestas (Composite), frecuentemente se necesita aplicar operaciones que dependen tanto de la operación misma como del tipo concreto de cada elemento de la estructura (por ejemplo: comprobación de tipos, optimización de código, generación de código de máquina, o cálculo de inventario).

### El Diagnóstico en Smalltalk:
1. **Dispersión de operaciones y violación de cohesión (Intento ingenuo):**
   * Definir cada nueva operación como un método distribuido a lo largo de todas las subclases del árbol (ej. `generateCode`, `prettyPrint`, `typeCheck` en cada nodo del AST) contamina las clases de dominio con lógica ajena a su propósito principal.
   * Si una clase cambia de requerimientos de análisis, se deben reabrir decenas de clases para alterar o agregar métodos.
2. **Uso de condicionales de tipo (Antipatrón procedural):**
   * Concentrar la operación en un único método que recorre el árbol preguntando con `isKindOf:` o `isMemberOf:` rompe el encapsulamiento y el polimorfismo, volviendo al código frágil frente a nuevos tipos de nodos.
3. **Solución por Doble Despacho (*Double Dispatch*):**
   * Se crea una jerarquía de visitantes donde cada clase encapsula una operación completa (ej. `CodeGeneratorVisitor`, `PrettyPrinterVisitor`).
   * Cada elemento de la estructura implementa un método simple: `accept: aVisitor`.
   * El elemento reenvía el mensaje al visitante identificándose a sí mismo mediante el selector: `aVisitor visitConcreteElementA: self`.
   * La operación final que se ejecuta queda determinada en tiempo de ejecución por dos cosas: **el tipo de visitante** (la operación) y **el tipo de elemento** (el receptor de los datos).

---

## 3. Aplicabilidad
El patrón Visitor se utiliza cuando:
- Una estructura de objetos contiene muchas clases de elementos con interfaces distintas y se desea realizar operaciones sobre ellos que dependen de sus clases concretas.
- Se deben realizar muchas operaciones distintas y no relacionadas sobre objetos de una estructura, y se desea evitar contaminar sus clases con estas operaciones.
- La jerarquía de clases de los elementos **rara vez cambia**, pero con frecuencia se **definen nuevas operaciones** sobre la estructura.

---

## 4. Estructura y Participantes

```
               Elemento (ASTNode / Component)
             - accept: aVisitor
                    /               \
                   /                 \
     ElementoConcretoA             ElementoConcretoB
      (VariableNode)                (AssignmentNode)
   - accept: aVisitor             - accept: aVisitor
     (aVisitor                      (aVisitor
      visitVariable: self)           visitAssignment: self)


               Visitante (ASTVisitor)
             - visitVariable: aNode
             - visitAssignment: aNode
                    /               \
                   /                 \
     VisitanteConcreto1            VisitanteConcreto2
      (CodeGenerator)               (PrettyPrinter)
   - visitVariable: aNode         - visitVariable: aNode
   - visitAssignment: aNode       - visitAssignment: aNode
```

- **Elemento (`Element` / `ASTNode`):** Define una operación `accept:` que toma un visitante como argumento.
- **ElementoConcreto (`ConcreteElement` / `VariableNode`, `AssignmentNode`):** Implementa `accept:` invocando el método correspondiente del visitante mediante doble despacho (`aVisitor visit<TipoDeElemento>: self`).
- **Visitante (`Visitor` / `ASTVisitor`):** Declara una operación de visita para cada clase de `ConcreteElement` en la estructura.
- **VisitanteConcreto (`ConcreteVisitor` / `CodeGenerator`, `PrettyPrinter`):** Implementa cada operación declarada por `Visitor`. Puede mantener un estado acumulativo a lo largo del recorrido.
- **EstructuraDeObjetos (`ObjectStructure` / `AST`, `Composite`):** Puede enumerar sus elementos o ser una jerarquía compuesta que propaga la aceptación del visitante.

---

## 5. Colaboraciones
1. El cliente crea un objeto `ConcreteVisitor` y lo envía a la estructura de objetos.
2. Un `ConcreteElement` recibe el mensaje `accept: aVisitor`.
3. El `ConcreteElement` ejecuta doble despacho llamando al visitante con el método específico para su clase: `aVisitor visitConcreteElementA: self`.
4. El `ConcreteVisitor` ejecuta la lógica correspondiente a esa clase de elemento, accediendo al estado del mismo si es necesario, y opcionalmente ordenando continuar la visita a sus hijos si se trata de un nodo compuesto.

---

## 6. Consecuencias

### Ventajas:
- **Facilidad para agregar nuevas operaciones:** Añadir una nueva operación a toda la jerarquía de elementos requiere únicamente crear una nueva subclase de `Visitor`, sin modificar ninguna clase de los elementos.
- **Agrupación de operaciones relacionadas:** Reúne la lógica de una operación completa en un solo lugar (la clase del visitante) en vez de dispersarla en 20 clases distintas.
- **Acumulación de estado:** El visitante puede llevar estado transitorio (como contadores, tablas de símbolos o streams de salida) mientras recorre la estructura, evitando pasar parámetros adicionales en cada método del elemento.

### Desventajas / Consideraciones en Smalltalk:
- **Dificultad extrema para agregar nuevos elementos:** Si se agrega una nueva subclase de `Element`, **todas** las subclases de `Visitor` existentes deben actualizarse para incluir el nuevo método de visita (`visitNuevoElemento:`).
- **Ruptura de encapsulamiento:** Para que el visitante haga su trabajo, los elementos a menudo deben exponer partes de su estado interno a través de accesores públicos, debilitando la privacidad del objeto.
- **Alternativa idiomática en Smalltalk (*perform:* dinámico):** En Smalltalk, gracias al late-binding, un elemento puede evitar codificar estáticamente los métodos en el visitante armando el selector dinámicamente con `#perform:` (ej. `aVisitor perform: ('visit', self class name, ':') asSymbol with: self`), aunque reduce la claridad y el control de dependencias.

---

## 7. Detalles de Implementación en Smalltalk

1. **Implementación de `accept:` en los Elementos:**
   * En Smalltalk, cada elemento concreto debe implementar su método de despacho específico. No alcanza con implementarlo en la clase base usando `self class`, porque el polimorfismo del mensaje al visitante requiere que el selector codifique el tipo explícito:
     ```smalltalk
     VariableNode >> accept: aVisitor
         ^aVisitor visitVariableNode: self
     ```
2. **Recorrido: ¿Quién controla el paseo?**
   * **El Visitante:** El visitante decide cuándo descender en los hijos (`aCompositeNode children do: [ :each | each accept: self ]`). Da mayor flexibilidad para alterar el orden del recorrido (pre-order, post-order).
   * **El Compuesto:** El compuesto se encarga de propagar el `accept:` a sus hijos. Simplifica el código de los visitantes pero fija la estrategia de recorrido.
3. **Manejo de Métodos por Defecto en el Visitor Abstracto:**
   * La superclase `Visitor` suele proveer implementaciones por defecto que deleguen en un método más general (por ejemplo, `visitBinaryExpression:` delega en `visitExpression:`, y este en `visitNode:`). Esto permite que visitantes especializados solo sobreescriban los nodos que les interesan.

---

## 8. Código de Ejemplo (Smalltalk - Recorrido de AST de Expresiones)

Jerarquía de Nodos (Elementos):

```smalltalk
Object subclass: #NodoExpresion
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-Visitor'

NodoExpresion >> accept: aVisitor
    self subclassResponsibility
```

```smalltalk
NodoExpresion subclass: #NodoNumero
    instanceVariableNames: 'valor'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-Visitor'

NodoNumero >> valor: unNumero
    valor := unNumero

NodoNumero >> valor
    ^valor

NodoNumero >> accept: aVisitor
    ^aVisitor visitNodoNumero: self
```

```smalltalk
NodoExpresion subclass: #NodoSuma
    instanceVariableNames: 'izquierda derecha'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-Visitor'

NodoSuma >> izquierda: unNodo derecha: otroNodo
    izquierda := unNodo.
    derecha := otroNodo.

NodoSuma >> izquierda
    ^izquierda

NodoSuma >> derecha
    ^derecha

NodoSuma >> accept: aVisitor
    ^aVisitor visitNodoSuma: self
```

Jerarquía de Visitantes:

```smalltalk
Object subclass: #VisitorExpresion
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-Visitor'

VisitorExpresion >> visitNodoNumero: aNodoNumero
    self subclassResponsibility

VisitorExpresion >> visitNodoSuma: aNodoSuma
    self subclassResponsibility
```

Visitante Concreto 1 (Evaluador aritmético):

```smalltalk
VisitorExpresion subclass: #EvaluadorVisitor
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-Visitor'

EvaluadorVisitor >> visitNodoNumero: aNodoNumero
    ^aNodoNumero valor

EvaluadorVisitor >> visitNodoSuma: aNodoSuma
    | resIzq resDer |
    resIzq := aNodoSuma izquierda accept: self.
    resDer := aNodoSuma derecha accept: self.
    ^resIzq + resDer
```

Visitante Concreto 2 (Pretty Printer):

```smalltalk
VisitorExpresion subclass: #PrintStringVisitor
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-Visitor'

PrintStringVisitor >> visitNodoNumero: aNodoNumero
    ^aNodoNumero valor asString

PrintStringVisitor >> visitNodoSuma: aNodoSuma
    | strIzq strDer |
    strIzq := aNodoSuma izquierda accept: self.
    strDer := aNodoSuma derecha accept: self.
    ^'(' , strIzq , ' + ' , strDer , ')'
```

Uso por el cliente:

```smalltalk
| arbol evaluador printer resultado impresion |
"Construcción de la expresión: (3 + 5)"
arbol := NodoSuma new
    izquierda: (NodoNumero new valor: 3)
    derecha: (NodoNumero new valor: 5).

"Operación 1: Evaluar la expresión sin modificar las clases de los nodos"
evaluador := EvaluadorVisitor new.
resultado := arbol accept: evaluador. "Devuelve 8"

"Operación 2: Imprimir la expresión sin modificar las clases de los nodos"
printer := PrintStringVisitor new.
impresion := arbol accept: printer. "Devuelve '(3 + 5)'"
```

---

## 9. Usos Conocidos en el Entorno Smalltalk
- **Compilador y ParseNodes (AST de Smalltalk):** El compilador de Smalltalk (en Squeak, Pharo y VisualWorks) utiliza visitantes o esquemas de doble despacho sobre las subclases de `ParseNode` (`MessageNode`, `AssignmentNode`, `BlockNode`) para formateo de código, análisis de variables semánticas y emisión de bytecodes.
- **Herramientas de Refactoring (Refactoring Browser):** El analizador sintáctico del Refactoring Browser usa visitantes para buscar patrones de código (*parse tree matching*), verificar precondiciones de transformaciones y renombrar selectores o variables en todo el AST.
- **Inspección e Impresión de Documentos:** En frameworks como VisualWorks UI o reportes, se recorren modelos jerárquicos para generar formatos disímiles (PDF, HTML, impresiones gráficas) mediante distintos visitantes de renderizado.

---

## 10. Patrones Relacionados
- **Composite:** Frecuentemente los elementos visitados están organizados en una estructura de árbol según el patrón Composite.
- **Interpreter:** Visitor se utiliza como complemento de Interpreter cuando se desea separar las operaciones de evaluación o análisis sintáctico de los nodos del lenguaje.
- **Iterator:** Mientras que Iterator se enfoca en recorrer linealmente una colección de objetos sin importar su tipo, Visitor se enfoca en ejecutar operaciones específicas según el tipo polimórfico concreto de cada objeto visitado.
