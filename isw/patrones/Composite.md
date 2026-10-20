# Resumen del Paper / Libro: El Patrón Composite
**Referencia:** *The Design Patterns Smalltalk Companion* (Alpern, Benson, Lee, Rising, Smith; con contribuciones de Ralph Johnson y John Vlissides) / Adaptación del libro de GoF a Smalltalk.

---

## 1. Intención y Otros Nombres
- **Intención:** Componer objetos en estructuras de árbol para representar jerarquías de parte-todo (*part-whole*). Composite permite a los clientes tratar de manera uniforme tanto a objetos individuales (hojas) como a composiciones de objetos (compuestos).
- **Otros Nombres:** *Composición de Objetos*, *Árboles Jerárquicos*.

---

## 2. Motivación y Diagnóstico
En aplicaciones gráficas y de modelado jerárquico, las interfaces y estructuras de datos suelen construirse a partir de componentes simples (como texto, rectángulos o líneas) agrupados en componentes de nivel superior (paneles, formularios, figuras complejas).

### El Diagnóstico en Smalltalk:
1. **Tratamiento diferencial (Intento ingenuo):**
   * Si el cliente debe chequear constantemente si un elemento gráfico es una figura primitiva o un grupo de figuras antes de dibujarlo o moverlo, el código se llena de condicionales de tipo (`isKindOf:` o `respondsTo:`).
   * Agregar un nuevo tipo de contenedor o una nueva figura primitiva obliga a modificar todos los lugares donde el cliente interactúa con los componentes.
2. **Solución polimórfica (La jerarquía de componentes):**
   * Definir una raíz común (ej. `VisualComponent` en VisualWorks o `Morph` en Squeak/Cuis).
   * Las hojas implementan la operación directamente sobre sí mismas (ej. `#displayOn:` dibuja el trazo).
   * Los compuestos delegan recursivamente la operación sobre sus hijos mediante iteradores polimórficos (`submorphs do: [ :each | each displayOn: aContext ]`).
   * El cliente interactúa con cualquier nodo del árbol mediante el mismo protocolo sin necesidad de distinguir entre hojas y ramas.

---

## 3. Aplicabilidad
El patrón Composite se utiliza cuando:
- Se desea representar jerarquías de objetos del tipo parte-todo.
- Se busca que los clientes ignoren la diferencia entre composiciones de objetos y objetos individuales, tratando todos los elementos de la estructura de forma uniforme.
- Se quiere construir estructuras recursivas abiertas donde nuevos tipos de hojas o compuestos puedan incorporarse sin modificar a los clientes existentes.

---

## 4. Estructura y Participantes

```
               Componente (VisualComponent / Morph)
               - displayOn: aGraphicsContext
               - bounds
                      /               \
                     /                 \
       Hoja (RectangleMorph)      Compuesto (CompositePart / PasteUpMorph)
       - displayOn: aGC           - children (OrderedCollection)
                                  - add: aComponent
                                  - remove: aComponent
                                  - displayOn: aGC
```

- **Componente (`Component` / `VisualComponent`, `Morph`):** Declara la interfaz común para todos los objetos de la composición, implementa comportamiento por defecto y, opcionalmente, define la interfaz de acceso a los padres o hijos.
- **Hoja (`Leaf` / `StringMorph`, `RectangleMorph`):** Representa objetos primitivos sin hijos. Define el comportamiento de los elementos básicos.
- **Compuesto (`Composite` / `CompositePart`, `CompositeMorph`):** Almacena una colección de componentes hijos e implementa las operaciones delegándolas a sus descendientes.
- **Cliente (`Client`):** Manipula los objetos de la jerarquía exclusivamente a través de la interfaz de `Component`.

---

## 5. Colaboraciones
1. El cliente envía un mensaje de dominio (como `#displayOn:`, `#drawOn:`, `#translateBy:`) a un `Component`.
2. Si el receptor es una **Hoja**, ejecuta directamente su acción específica (dibuja su forma o altera sus coordenadas).
3. Si el receptor es un **Compuesto**, realiza las operaciones preliminares requeridas y luego reenvía el mensaje a cada uno de sus hijos en su colección (`children do: [ :child | child displayOn: aContext ]`).
4. Si los hijos a su vez son compuestos, la delegación continúa en cascada por todo el subárbol de forma transparente al cliente original.

---

## 6. Consecuencias

### Ventajas:
- **Simplificación del código cliente:** Los clientes eliminan comprobaciones condicionales y tratan a los grupos de objetos exactamente igual que a los objetos primitivos.
- **Facilidad de extensión:** Es trivial agregar nuevas subclases de hojas o nuevos tipos de contenedores compuestos sin alterar el código existente (principio Open/Closed).
- **Flexibilidad recursiva:** Permite crear estructuras arbitrariamente profundas y anidadas con reutilización directa de componentes.

### Desventajas / Consideraciones en Smalltalk:
- **Dilema de diseño: Transparencia vs. Seguridad:**
  * Si se declara la gestión de hijos (`#add:`, `#remove:`) en la raíz `Component` (enfoque transparente), las hojas deben rechazar o ignorar esos mensajes (`shouldNotImplement` o no-op), perdiendo seguridad en tiempo de ejecución.
  * Si se declara solo en `Composite` (enfoque seguro), el cliente pierde uniformidad y debe saber de antemano si el objeto es un compuesto antes de intentar añadir hijos.
- **Dificultad para restringir componentes:** Si un compuesto solo debe aceptar ciertos tipos específicos de hijos, no se puede delegar la validación al compilador de Smalltalk; deben implementarse validaciones dinámicas en `#add:`.

---

## 7. Detalles de Implementación en Smalltalk

1. **Gestión de Hijos (Transparencia en Smalltalk):**
   * En Smalltalk es habitual optar por la **transparencia**: definir `#add:` y `#remove:` en la raíz `Component` con una implementación por defecto que señale un error explícito (`self shouldNotImplement`) o que actúe como colección vacía para las hojas.
2. **Colección de Hijos:**
   * Los compuestos típicamente encapsulan una `OrderedCollection` interna para mantener el orden de apilamiento visual (*z-order*) de los componentes.
3. **Referencias al Padre (*Parent References*):**
   * Es común que cada hijo mantenga una referencia hacia su contenedor (`owner` o `container`). Esto simplifica la propagación de eventos hacia arriba en el árbol y las invalidaciones de pantalla (enviar `self owner changed`).
4. **Caching de Cálculos Jerárquicos:**
   * Operaciones como calcular los límites espaciales totales (`bounds` o `extent`) de un compuesto pueden ser costosas si el árbol es profundo. Es habitual que el compuesto mantenga un valor en caché y lo invalide cuando un hijo se modifica, se añade o se remueve.

---

## 8. Código de Ejemplo (Smalltalk - Jerarquía Visual Simplificada)

Componente abstracto:

```smalltalk
Object subclass: #Grafico
    instanceVariableNames: 'contenedor'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-Composite'

Grafico >> dibujarEn: unCanvas
    self subclassResponsibility

Grafico >> contenedor: unGraficoCompuesto
    contenedor := unGraficoCompuesto

Grafico >> contenedor
    ^contenedor
```

Hoja concreta:

```smalltalk
Grafico subclass: #PuntoGrafico
    instanceVariableNames: 'posicion'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-Composite'

PuntoGrafico >> posicion: unPoint
    posicion := unPoint

PuntoGrafico >> dibujarEn: unCanvas
    unCanvas dibujarPuntoEn: posicion
```

Compuesto concreto:

```smalltalk
Grafico subclass: #GraficoCompuesto
    instanceVariableNames: 'elementos'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-Composite'

GraficoCompuesto >> initialize
    super initialize.
    elementos := OrderedCollection new.

GraficoCompuesto >> agregar: unGrafico
    elementos add: unGrafico.
    unGrafico contenedor: self.

GraficoCompuesto >> remover: unGrafico
    elementos remove: unGrafico ifAbsent: [].
    unGrafico contenedor: nil.

GraficoCompuesto >> dibujarEn: unCanvas
    elementos do: [ :cadaGrafico | cadaGrafico dibujarEn: unCanvas ]
```

---

## 9. Usos Conocidos en el Entorno Smalltalk
- **VisualComponent / CompositePart (VisualWorks Smalltalk):** La arquitectura de presentación donde vistas complejas combinan múltiples controles individuales dentro de contenedores visuales.
- **Morphic Framework (Squeak / Pharo / Cuis):** La clase raíz `Morph` implementa el patrón Composite de forma uniforme. Todo `Morph` puede contener `submorphs` y tener un `owner`. Tanto una ventana (`SystemWindow`), un botón (`PluggableButtonMorph`), o el lienzo global (`PasteUpMorph` / *World*) comparten la misma interfaz de dibujo y manipulación espacial.
- **Expresiones del Compilador / AST (ParseNodes):** Los árboles de sintaxis abstracta representan expresiones del lenguaje mediante nodos compuestos (`BlockNode`, `MessageNode`, `CascadeNode`) que contienen nodos terminales u hojas (`VariableNode`, `LiteralNode`).

---

## 10. Patrones Relacionados
- **Chain of Responsibility:** La relación de ancestros (*parent pointers*) del Composite se usa comúnmente para propagar eventos de entrada del usuario desde una hoja hacia sus contenedores.
- **Decorator:** Ambos comparten diagramas estructurales similares basados en recursión compositiva, pero Decorator agrega responsabilidades sin ser una estructura de árbol parte-todo.
- **Iterator:** Se emplea habitualmente para recorrer los hijos y subárboles de la estructura compuesta.
- **Visitor:** Permite encapsular operaciones y recorridos sobre el árbol de Composite sin dispersar la lógica de negocio en cada subclase de hoja o compuesto.