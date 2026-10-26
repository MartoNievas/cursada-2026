# Resumen del Paper / Libro: El Patrón Template Method
**Referencia:** *Design Patterns: Elements of Reusable Object-Oriented Software* (Gamma, Helm, Johnson, Vlissides - GoF) / Adaptación y consideraciones idiomáticas en *The Design Patterns Smalltalk Companion*.

---

## 1. Intención y Otros Nombres
- **Intención:** Definir el esqueleto de un algoritmo dentro de una operación, difiriendo algunos pasos a las subclases. Template Method permite que las subclases redefinan ciertos pasos de un algoritmo sin alterar la estructura global ni el orden del mismo.
- **Otros Nombres:** *Método Plantilla*.

---

## 2. Motivación y Diagnóstico
En el diseño de frameworks y bibliotecas de clases orientadas a objetos, un desafío clásico es cómo coordinar algoritmos de alto nivel cuya secuencia de pasos es fija e invariante, pero cuyos detalles de bajo nivel dependen de cada caso particular de aplicación.

El libro presenta el ejemplo clásico del framework de documentos (`Application` y `Document`):
- `Application` gestiona el ciclo de vida y la apertura de documentos (`OpenDocument`).
- `Document` modela los datos almacenados en disco una vez leídos.
- Las aplicaciones concretas derivan ambas clases (ej. `DrawingApplication` / `DrawingDocument` para dibujo, `SpreadsheetApplication` / `SpreadsheetDocument` para hojas de cálculo).

### El Diagnóstico del Problema:
1. **Duplicación de la lógica de control (Intento procedimental):**
   * Si cada subclase concreta reimplementa todo el procedimiento de apertura (validar permisos, instanciar el documento, registrarlo en la colección interna, notificar a los observadores y cargar los datos), se duplica sistemáticamente la lógica de control.
   * Modificar el flujo base (por ejemplo, agregar una auditoría de seguridad antes de abrir un archivo) obligaría a editar cada una de las subclases del sistema.
2. **Incapacidad de la clase base para resolver los pasos concretos:**
   * La clase abstracta `Application` debe orquestar el flujo, pero desconoce qué clase concreta de `Document` debe crearse o cómo se parsea cada formato de archivo particular en disco.
3. **Solución por inversión de control (Template Method):**
   * La clase base implementa un método público —el **Template Method**— que codifica el flujo algorítmico invocando métodos abstractos (*primitivos*) y métodos por defecto (*hooks*).
   * Las subclases se limitan a implementar los métodos primitivos requeridos o a sobreescribir selectivamente los *hooks*, heredando toda la arquitectura de control sin escribir una sola línea de lógica de coordinación.

---

## 3. Aplicabilidad
El patrón Template Method se utiliza cuando:
- Se desea implementar las partes invariantes de un algoritmo una sola vez y delegar a las subclases la responsabilidad de implementar las partes que varían.
- El comportamiento común entre subclases debe ser factorizado y concentrado en una superclase compartida para eliminar la duplicación de código.
- Se busca controlar y restringir estrictamente los puntos de extensión permitidos para las subclases, exponiendo solo ganchos (*hook methods*) específicos en vez de permitir que sobreescriban el algoritmo entero.

---

## 4. Estructura y Participantes

```
             Cliente (Client)
                   │
                   ▼
       ClaseAbstracta (AbstractClass / Application)
     - templateMethod() ─────────────────────────────┐
     - primitiveOp1() [subclassResponsibility]       │ orquesta
     - primitiveOp2() [hook / default]               │
                           ▲                         │
                           │ hereda                  │
                           │                         ▼
       ClaseConcreta (ConcreteClass / MyApplication)
     - primitiveOp1()
     - primitiveOp2()
```

- **ClaseAbstracta (`AbstractClass` / `Application`):**
  - Define las **operaciones primitivas** abstractas que las subclases concretas deben implementar para llevar a cabo los pasos variables del algoritmo.
  - Implementa el **método plantilla** (`templateMethod`), el cual define el esqueleto y secuencia fija del algoritmo llamando a las operaciones primitivas, a operaciones concretas de la superclase y a operaciones de tipo *hook*.
- **ClaseConcreta (`ConcreteClass` / `DrawingApplication`, `SpreadsheetApplication`):**
  - Implementa las operaciones primitivas abstractas requeridas para los pasos específicos de su dominio.
  - Opcionalmente sobrescribe operaciones de tipo *hook* para alterar o complementar el comportamiento estándar del algoritmo.
- **Cliente (`Client`):**
  - Invoca el método plantilla sobre la instancia concreta de `ConcreteClass`, desconociendo si un paso puntual fue resuelto en la superclase o en una subclase.

---

## 5. Colaboraciones
1. El cliente envía el mensaje correspondiente al método plantilla (ej. `app openDocument: 'reporte.dat'`).
2. La ejecución entra al método implementado en la `ClaseAbstracta`.
3. El método plantilla ejecuta las validaciones o preparaciones invariantes de la clase base.
4. Cuando el flujo llega a un paso variable, el método plantilla invoca un método primitivo (como `self doCreateDocument` o `self readDocument`).
5. Gracias al despacho dinámico (*late binding*), el control se transfiere al método implementado por la `ClaseConcreta`.
6. La subclase ejecuta su lógica específica y retorna el control a la superclase para que continúe con el siguiente paso del algoritmo.

---

## 6. Consecuencias

### Ventajas:
- **Reutilización masiva de código:** Factoriza la estructura algorítmica de alto nivel en una clase centralizada, eliminando código duplicado en las subclases.
- **Inversión de Control (*The Hollywood Principle*):** Implementa la máxima *"No nos llames, nosotros te llamaremos"*. La superclase gobierna y orquesta el flujo general, decidiendo cuándo invocar a los métodos de la subclase y no al revés.
- **Control estricto de variabilidad:** Permite al diseñador de una biblioteca o framework delimitar con precisión milimétrica los puntos exactos donde el código de terceros puede inyectar comportamiento.

### Clasificación de Operaciones Invocadas por el Template Method:
1. **Operaciones concretas:** Métodos auxiliares generales definidos en la misma clase abstracta o utilidades de dominio.
2. **Operaciones primitivas:** Pasos abstractos obligatorios (en Smalltalk marcados con `self subclassResponsibility`).
3. **Hook Operations (Métodos Gancho):** Métodos que proveen un comportamiento por defecto (frecuentemente una implementación vacía `^self` o un valor booleano predeterminado) que las subclases pueden sobrescribir únicamente si lo desean.
4. **Factory Methods:** Métodos primitivos o hooks diseñados específicamente para instanciar objetos colaboradores requeridos por el algoritmo.

### Desventajas / Consideraciones en Smalltalk:
- **Herencia estática obligatoria:** El algoritmo queda rígidamente fijado en la jerarquía de herencia. No es posible intercambiar pasos del algoritmo dinámicamente en tiempo de ejecución para un mismo objeto (para ello se requiere el patrón *Strategy*).
- **Fragilidad en jerarquías profundas:** Modificar la secuencia interna del método plantilla en la superclase puede romper supuestos implícitos en las subclases si estas dependían del orden exacto en que se disparaban los métodos primitivos.

---

## 7. Detalles de Implementación en Smalltalk

1. **Primitivas Obligatorias (`subclassResponsibility`):**
   * A diferencia de C++ o Java donde el compilador valida la presencia de métodos `pure virtual` o `abstract`, en Smalltalk una operación primitiva obligatoria se declara enviando explícitamente:
     ```smalltalk
     Application >> doCreateDocument
         self subclassResponsibility
     ```
2. **Hooks por Defecto (*Null Implementation*):**
   * Las operaciones opcionales se definen en la superclase con cuerpo vacío o retornando `self` o un valor neutro, de modo que las subclases solo las implementen si necesitan intervenir:
     ```smalltalk
     Application >> aboutToOpenDocument: aDocument
         "Hook vacío: las subclases pueden extenderlo"
         ^self
     ```
3. **Convenciones de Nomenclatura:**
   * Es convención habitual en Smalltalk anteponer prefijos a los métodos destinados a ser redefinidos por subclases (por ejemplo, `do...`, `basic...`, `default...` o `primitive...`), diferenciándolos claramente de los métodos plantillas públicos.
4. **Protección del Template Method:**
   * En Smalltalk todos los métodos son públicos y polimórficos por diseño. Para indicar que el método plantilla no debe ser sobreescrito por las subclases, se documenta en el comentario del método o se clasifica bajo categorías protocolares como `'template methods - do not override'`.

---

## 8. Código de Ejemplo (Smalltalk - Procesamiento y Apertura de Documentos)

Clase Abstracta:

```smalltalk
Object subclass: #Aplicacion
    instanceVariableNames: 'documentos'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-TemplateMethod'

Aplicacion >> initialize
    super initialize.
    documentos := OrderedCollection new.

"--- Método Plantilla (Template Method) ---"
Aplicacion >> abrirDocumento: unaRuta
    | doc |
    (self puedeAbrirDocumento: unaRuta) ifFalse: [
        self error: 'No se puede abrir el documento en: ', unaRuta asString ].
        
    doc := self crearDocumentoPara: unaRuta. "Factory Method / Primitiva"
    
    documentos add: doc.
    self antesDeAbrirDocumento: doc.         "Hook opcional"
    doc abrir.
    doc leerDesde: unaRuta.
    ^doc

"--- Pasos Invariantes y Hooks por Defecto ---"
Aplicacion >> puedeAbrirDocumento: unaRuta
    "Comportamiento por defecto: valida que la ruta no esté vacía"
    ^unaRuta isNotEmpty

Aplicacion >> antesDeAbrirDocumento: unDocumento
    "Hook vacío para ser extendido por subclases"
    ^self

"--- Operaciones Primitivas Obligatorias ---"
Aplicacion >> crearDocumentoPara: unaRuta
    self subclassResponsibility
```

Documento y Aplicación Concreta:

```smalltalk
Object subclass: #DocumentoTexto
    instanceVariableNames: 'contenido'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-TemplateMethod'

DocumentoTexto >> abrir
    Transcript show: 'Inicializando buffer de texto...'; cr.

DocumentoTexto >> leerDesde: unaRuta
    Transcript show: 'Cargando texto plano desde: ', unaRuta asString; cr.
```

```smalltalk
Aplicacion subclass: #AplicacionTexto
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-TemplateMethod'

"Implementación obligatoria de la primitiva"
AplicacionTexto >> crearDocumentoPara: unaRuta
    ^DocumentoTexto new

"Sobreescritura del hook opcional"
AplicacionTexto >> antesDeAbrirDocumento: unDocumento
    Transcript show: 'Registrando auditoria: documento a punto de abrirse'; cr.
```

Uso por el cliente:

```smalltalk
| app doc |
app := AplicacionTexto new.

"El cliente invoca el template method sobre la subclase concreta"
doc := app abrirDocumento: '/home/usuario/notas.txt'.
```

---

## 9. Usos Conocidos en el Entorno Smalltalk
- **Jerarquía `Magnitude` (`<`, `>`, `<=`, `>=`):** El ejemplo fundacional en Smalltalk-80. La clase raíz `Magnitude` implementa `>`, `<=` y `>=` como métodos plantillas que orquestan comparaciones basadas únicamente en la operación primitiva obligatoria `<` implementada por cada subclase (`Number`, `Date`, `Character`, `Time`).
- **Colecciones e Iteración (`Collection`):** La clase abstracta `Collection` implementa métodos plantillas como `#select:`, `#reject:`, `#detect:` e `#includes:` expresados en términos de la primitiva pura `#do:`. Cualquier nueva subclase de colección solo necesita implementar `#do:` y `#add:` para heredar todo el protocolo funcional de Smalltalk.
- **VisualComponent / Morphic (Ciclo de Dibujo):** El método `#drawOn:` o `#displayOn:` actúa como método plantilla que prepara el contexto de transformación espacial, recorta límites (*clipping*), invoca primitivas como `#drawBackgroundOn:` y `#drawSubmorphsOn:`, y finalmente limpia el canvas.

---

## 10. Patrones Relacionados
- **Strategy:** Resuelve el mismo problema de variación algorítmica pero a diferente escala y mecanismo: Template Method usa **herencia** para variar partes internas de un algoritmo fijando su esqueleto; Strategy usa **composición y delegación** para variar e intercambiar dinámicamente el algoritmo completo en tiempo de ejecución.
- **Factory Method:** Es habitual que los pasos de instanciación dentro de un método plantilla sean delegados a métodos de fabricación (*Factory Methods*), como `crearDocumentoPara:` en el ejemplo de `Application`.
- **Builder:** El método director (`construct`) de un Builder funciona conceptualmente como un método plantilla que coordina una secuencia de pasos invariante, con la diferencia de que delega los pasos en un objeto constructor externo en lugar de en subclases.