# Resumen del Paper / Libro: El Patrón Decorator
**Referencia:** *The Design Patterns Smalltalk Companion* (Alpern, Benson, Lee, Rising, Smith; con contribuciones de Ralph Johnson y John Vlissides) / Adaptación del libro de GoF a Smalltalk.

---

## 1. Intención y Otros Nombres
- **Intención:** Adjuntar responsabilidades adicionales a un objeto de forma dinámica y transparente. Proporciona una alternativa flexible a la herencia estática para extender la funcionalidad de una clase.
- **Otros Nombres:** *Wrapper*, *Envoltorio*.

---

## 2. Motivación y Diagnóstico
En aplicaciones gráficas y de procesamiento de flujos de datos (streams o vistas de interfaz), a menudo surge la necesidad de dotar de capacidades adicionales a un objeto específico en tiempo de ejecución (como agregar bordes, barras de desplazamiento, compresión o sombreados) sin alterar a los demás objetos de la misma clase ni acoplarlos rígidamente a una jerarquía estática.

### El Diagnóstico en Smalltalk:
1. **Proliferación de subclases (Intento estático):**
   * Resolver cada combinación posible de responsabilidades mediante subclases deriva en una explosión combinatoria de clases (ej. `TextViewWithBorder`, `TextViewWithScrollbar`, `TextViewWithBorderAndScrollbar`).
   * La herencia es estática en tiempo de instanciación; no permite quitar ni añadir responsabilidades de forma modular mientras el programa corre.
2. **Solución por composición transparente (El Wrapper):**
   * Se crea una subclase de la misma raíz polimórfica que el componente base, la cual almacena una referencia al componente envuelto (`component`).
   * El envoltorio conforma exactamente el mismo protocolo de mensajes que el componente al que decora.
   * El decorador intercepta los mensajes clave, ejecuta su comportamiento adicional (antes o después) y delega la operación nuclear en el objeto contenido (`component displayOn: aContext`).
   * Para el cliente que envía mensajes, el decorador y el componente base son intercambiables.

---

## 3. Aplicabilidad
El patrón Decorator se utiliza cuando:
- Se desea añadir o remover responsabilidades a objetos individuales de forma dinámica y transparente, sin afectar a otros objetos de la misma clase.
- La extensión por herencia resulta impracticable debido a una proliferación explosiva de subclases para cada combinación de características independientes.
- Se necesita componer múltiples funcionalidades ortogonales e independientes mediante decoradores anidados unos dentro de otros.

---

## 4. Estructura y Participantes

```plaintext
               Componente (VisualComponent / Stream)
- displayOn: aGraphicsContext
- bounds
                      /               \
                     /                 \
       ComponenteConcreto            Decorador (Decorator / Wrapper)
        (TextView / FileStream)       - component (VisualComponent)
- displayOn: aGC                     - displayOn: aGC
- bounds                             - bounds
                                              /             \
                                             /               \
                             BordeDecorador             ScrollDecorador
                              - drawBorderOn: aGC        - scrollTo: aPoint
                              - displayOn: aGC           - displayOn: aGC
```

Otro esquema, esto indica que se pueden tener decorators anidados hasta llegar por asi decirlo a un caso base el cual es un componente concreto, como por ejemplo **TextView**:

```plaintext
Componente (VisualComponent) ◄─────────────────────────────┐
                     /              \                      │
                    /                \                     │
    ComponenteConcreto              Decorador              │ (referencia / puntero)
       (TextView)                 - component ─────────────┘
                                     /     \
                                    /       \
                          BordeDecorador   ScrollDecorador
```


- **Componente (`Component` / `VisualComponent`, `Stream`):** Declara la interfaz común polimórfica para los objetos que pueden recibir responsabilidades añadidas dinámicamente.
- **ComponenteConcreto (`ConcreteComponent` / `TextView`, `StandardFileStream`):** El objeto núcleo sobre el cual se añaden comportamientos extra.
- **Decorador (`Decorator` / `Wrapper`):** Mantiene una referencia a un objeto `Component` y replica su misma interfaz, delegando en él de forma transparente.
- **DecoradorConcreto (`ConcreteDecorator` / `BorderDecorator`, `ScrollDecorator`):** Agrega responsabilidades específicas antes, durante o después de delegar en el componente envuelto.
- **Cliente (`Client`):** Envía mensajes al componente decorado interactuando exclusivamente a través de la interfaz común (en caso de no querer comportamiento extra osea usar un decorador el cliente se deberia comunicar con el `ComponenteConcreto` de su preferencia).

---

## 5. Colaboraciones
1. El cliente envía un mensaje protocolar (como `#displayOn:` o `#nextPut:`) al `Decorator`.
2. El `Decorator` realiza su pre-procesamiento si corresponde (por ejemplo, preparar un lienzo o ajustar márgenes).
3. Reenvía el mensaje al componente interno (`component displayOn: aCanvas`).
4. Si el componente envuelto es a su vez otro `Decorator`, la delegación continúa en cascada hasta alcanzar el `ConcreteComponent`.
5. El `Decorator` ejecuta su post-procesamiento (por ejemplo, pintar el recuadro del borde por encima del contenido ya dibujado).

---

## 6. Consecuencias

### Ventajas:
- **Mayor flexibilidad que la herencia:** Permite mezclar y emparejar comportamientos en tiempo de ejecución sin incurrir en una explosión combinatoria de clases.
- **Clases base más simples:** Evita sobrecargar las clases raíz de la jerarquía con variables de instancia o flags de configuración para soportar características opcionales.
- **Alta cohesión:** Cada decorador encapsula una única responsabilidad bien definida (ej. solo el borde, solo el scroll).

### Desventajas / Consideraciones en Smalltalk:
- **Pérdida de identidad del objeto (*Object Identity Problem*):**
  * Un decorador y el componente envuelto son dos instancias distintas en el heap. Cualquier comprobación por identidad (`==`) o almacenamiento en estructuras como `IdentitySet` o `IdentityDictionary` fallará si el código espera la identidad del objeto original.
- **Sobrecarga de delegación y *DoesNotUnderstand:*:**
  * Si el protocolo del componente es extenso, el decorador base debe implementar manualmente todos los métodos de delegación o capturar dinámicamente `#doesNotUnderstand: aMessage`. Esta última técnica introduce penalizaciones de rendimiento y dificulta la navegación en el debugger.
- **Dificultad de introspección:** Una cadena profunda de decoradores complica la inspección interactiva en el *Inspector* de Smalltalk, al requerir navegar manualmente a través de los múltiples enlaces de `component`.

---

## 7. Detalles de Implementación en Smalltalk

1. **Protocolo de Envoltura y Delegación:**
   * Habitualmente se define una clase abstracta `Wrapper` o `Decorator` que hereda de la raíz de la jerarquía (ej. `VisualComponent`) e implementa por defecto la delegación trivial para todo el protocolo público hacia la variable de instancia `component`.
2. **Uso de `#doesNotUnderstand:` y `ProtoObject`:**
   * En casos donde el protocolo es muy amplio o variable, se puede heredar de `ProtoObject` y capturar `#doesNotUnderstand: aMessage` para reenviar `component perform: aMessage selector withArguments: aMessage arguments`. Sin embargo, esto acarrea pérdida de optimizaciones del compilador y es desaconsejado para código crítico.
3. **Preservación del Modelo-Vista-Controlador (MVC):**
   * En decoradores de vistas visuales, es fundamental que el decorador reenvíe adecuadamente las notificaciones de actualización (`#update:`, `#changed`) para no quebrar el ciclo de notificación del patrón Observer/MVC.
4. **Decoradores de Streams:**
   * Es una de las aplicaciones más elegantes y eficientes en Smalltalk: una clase base provee el acceso crudo a datos y los decoradores intermedios añaden compresión (`GZipWriteStream`), encriptación o conversión de codificación sin alterar la colección de destino.

---

## 8. Código de Ejemplo (Smalltalk - Decorador Visual Simplificado)

Componente abstracto:

```smalltalk
Object subclass: #ComponenteVisual
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-Decorator'

ComponenteVisual >> dibujarEn: unCanvas
    self subclassResponsibility
```

Componente concreto:

```smalltalk
ComponenteVisual subclass: #VistaTexto
    instanceVariableNames: 'texto'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-Decorator'

VistaTexto >> texto: unString
    texto := unString

VistaTexto >> dibujarEn: unCanvas
    unCanvas dibujarTexto: texto
```

Decorador abstracto (Wrapper base):

```smalltalk
ComponenteVisual subclass: #DecoradorVisual
    instanceVariableNames: 'componente'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-Decorator'

DecoradorVisual >> componente: unComponenteVisual
    componente := unComponenteVisual

DecoradorVisual >> dibujarEn: unCanvas
    componente dibujarEn: unCanvas
```

Decoradores concretos:

```smalltalk
DecoradorVisual subclass: #BordeDecorador
    instanceVariableNames: 'grosor'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-Decorator'

BordeDecorador >> grosor: unEntero
    grosor := unEntero

BordeDecorador >> dibujarEn: unCanvas
    super dibujarEn: unCanvas.
    self dibujarBordeEn: unCanvas

BordeDecorador >> dibujarBordeEn: unCanvas
    unCanvas dibujarRecuadroConGrosor: grosor
```

```smalltalk
DecoradorVisual subclass: #SombraDecorador
    instanceVariableNames: 'desplazamiento'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-Decorator'

SombraDecorador >> desplazamiento: unPoint
    desplazamiento := unPoint

SombraDecorador >> dibujarEn: unCanvas
    self dibujarSombraEn: unCanvas.
    super dibujarEn: unCanvas

SombraDecorador >> dibujarSombraEn: unCanvas
    unCanvas dibujarSombraConDesplazamiento: desplazamiento
```

Ejemplo de uso dinámico por el cliente:

```smalltalk
| vista vistaConBorde vistaConBordeYSombra |
vista := VistaTexto new texto: 'Smalltalk-80'.

vistaConBorde := BordeDecorador new
    componente: vista;
    grosor: 2.

vistaConBordeYSombra := SombraDecorador new
    componente: vistaConBorde;
    desplazamiento: 3@3.

vistaConBordeYSombra dibujarEn: canvasActual.
```

---

## 9. Usos Conocidos en el Entorno Smalltalk
- **VisualWorks (VisualComponent wrappers):** La clase `Wrapper` y sus variantes directas (`BorderDecorator`, `TranslatingWrapper`, `Scroller`) que envuelven componentes visuales para alterar su marco, posición o desplazamiento dentro del canvas.
- **Jerarquía de Streams:** Envoltorios de streams como `PeekableStream`, `ZnCharacterReadStream` o `GZipWriteStream`, que envuelven flujos binarios o de caracteres agregando capacidades de lectura adelantada o compresión al vuelo.
- **Proxies de Depuración y Profiling:** Clases wrapper que interceptan mensajes para cronometrar ejecuciones o auditar logs antes de delegar en el objeto real de dominio.

---

## 10. Patrones Relacionados
- **Adapter:** Mientras que Decorator añade o modifica responsabilidades manteniendo idéntica la interfaz del componente, Adapter traduce la interfaz existente para adaptarla a otro contrato esperado.
- **Composite:** Ambos comparten una estructura recursiva basada en un tipo abstracto común. Sin embargo, Composite modela jerarquías parte-todo con colecciones de hijos, mientras que Decorator se enfoca en envolver a un único componente.
- **Strategy:** Decorator modifica la "piel" exterior de un objeto de forma transparente; Strategy cambia las "entrañas" delegando una parte puntual del algoritmo en un objeto de estrategia intercambiable.
- **Proxy:** Ambos delegan sobre un objeto interno con una interfaz semejante, pero el Proxy se enfoca en controlar el acceso, la ubicación o la instanciación diferida (*lazy evaluation*), mientras que Decorator se enfoca en extender comportamiento.