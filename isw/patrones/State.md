# Resumen del Patrón: State Pattern
**Referencia:** *Design Patterns: Elements of Reusable Object-Oriented Software* (Gamma, Helm, Johnson, Vlissides - GoF) / Adaptación y consideraciones idiomáticas en *The Design Patterns Smalltalk Companion*.

---

## 1. Intención y Otros Nombres
- **Intención:** Permite que un objeto altere su comportamiento cuando su estado interno cambia. Pareciera que el objeto cambia de clase en tiempo de ejecución.
- **Otros Nombres:** *Objects for States* (Objetos para Estados).

---

## 2. Motivación y Diagnóstico
En el libro se analiza la clase `TCPConnection`, la cual modela una conexión de red que transiciona a través de múltiples estados operacionales bien diferenciados (`TCPEstablished`, `TCPListen`, `TCPClosed`). Cuando la conexión recibe solicitudes de la red o de clientes locales (como `open`, `close`, `read`, `write`), debe reaccionar de manera completamente distinta según su estado actual.

### El Diagnóstico del Problema:
1. **Proliferación de condicionales de estado (Intento procedimental):**
   * Modelar el estado mediante variables de instancia escalares (como enumerados o enteros) obliga a que cada método de la interfaz pública contenga una estructura condicional (`switch`, cadenas de `if-else` o comparaciones de tipo).
   * Agregar un nuevo estado operacional exige localizar y modificar manualmente todos los métodos de `TCPConnection` que evalúan dicha variable, violando el principio *Open/Closed*.
2. **Solución polimórfica (Objects for States):**
   * Se introduce una clase raíz abstracta `TCPState` que declara una interfaz uniforme para todas las operaciones dependientes de estado.
   * Cada estado operacional concreto se encapsula en una subclase independiente (`TCPEstablished`, `TCPListen`, `TCPClosed`), la cual implementa exclusivamente las respuestas y transiciones válidas para dicho estado.
   * `TCPConnection` (el `Context`) mantiene una referencia polimórfica a una instancia de `TCPState` que representa su estado actual. Cada vez que cambia de fase operacional, la variable simplemente se reasigna a otra subclase de `TCPState`.
   * Todas las solicitudes dependientes del estado se delegan polimórficamente al objeto estado actual (`state open: self`, `state close: self`), erradicando las ramas condicionales del contexto.

---

## 3. Aplicabilidad
El patrón State se utiliza cuando:
- El comportamiento de un objeto depende de su estado interno, y debe alterarlo dinámicamente en tiempo de ejecución a medida que transiciona.
- Las operaciones implementan estructuras condicionales masivas de tipo *switch-case* o *if-else* que dependen de variables de estado, constantes enumeradas o flags booleanos acumulados.
- Se desea proteger al objeto de caer en estados inconsistentes, garantizando transiciones atómicas y bien modeladas.
- Múltiples objetos o contextos comparten el mismo ciclo de vida de transiciones y pueden reutilizar instancias de estado desprovistas de variables mutables (estados *stateless*).

---

## 4. Estructura y Participantes

```
             Cliente (Client)
                   │
                   ▼
           Context (TCPConnection) ──────────┐
         - state (TCPState)                  │ compone / delega
         - request()                         │
         - changeState(TCPState)             │
                                             ▼
                                     State (TCPState)
                                   - handle()
                                   - open(Context)
                                   - close(Context)
                                          /   \
                                         /     \
                                        /       \
        ConcreteStateA (TCPEstablished)           ConcreteStateB (TCPClosed)
        - handle()                                - handle()
        - close(Context)                          - open(Context)
          (ctx.changeState(TCPClosed))              (ctx.changeState(TCPEstablished))
```

- **Context (`Context` / `TCPConnection`):**
  - Define y mantiene la interfaz pública de interés para los clientes.
  - Almacena una instancia de una subclase concreta de `State` que modela el estado activo.
  - Expone un canal de delegación hacia el objeto de estado y provee un protocolo de actualización (`changeState:`) para efectuar las transiciones.
- **State (`State` / `TCPState`):**
  - Declara la interfaz común polimórfica para encapsular el comportamiento vinculado a cada estado del `Context`.
  - Provee implementaciones por defecto o manejo de errores para eventos no permitidos en ciertos estados (por ejemplo, rechazar un `open` cuando la conexión ya está establecida).
- **Subclases de ConcreteState (`TCPEstablished`, `TCPListen`, `TCPClosed`):**
  - Cada subclase concreta implementa el comportamiento específico y las respuestas a las solicitudes del contexto para ese estado en particular.
  - Puede evaluar condiciones locales para disparar transiciones hacia otros estados sucesores.
- **Cliente (`Client`):**
  - Interactúa exclusivamente con la interfaz provista por `Context`. Generalmente no accede ni interactúa directamente con los objetos de estado.

---

## 5. Colaboraciones
1. El `Client` envía un mensaje del dominio de la aplicación al `Context` (ej. `connection open`).
2. El `Context` delega inmediatamente la resolución de la operación en su objeto de estado actual, pasándose habitualmente a sí mismo como colaborador: `state open: self`.
3. Si la operación requiere datos del contexto, el `ConcreteState` utiliza la interfaz de lectura expuesta por este.
4. Si la solicitud desencadena un cambio de estado:
   * **Enfoque descentralizado:** El `ConcreteState` le envía un mensaje al contexto con la nueva instancia: `aContext changeState: TCPClosed new`.
   * **Enfoque centralizado:** El `Context` inspecciona el resultado de la delegación y reasigna su propia variable de instancia internamente.
5. Los clientes permanecen completamente ajenos a las reasignaciones internas de la variable de estado.

---

## 6. Consecuencias

### Ventajas:
- **Partición y localización del comportamiento dependiente:** Aísla el código correspondiente a cada estado en una clase cohesionada. Agregar un nuevo estado operacional implica sumar una nueva subclase sin riesgo de romper los estados preexistentes.
- **Transiciones de estado explícitas y atómicas:** Evita inconsistencias en las variables del contexto al concentrar el pasaje de un estado a otro en una reasignación puntual de puntero (`state := nuevoEstado`), eliminando variables bandera desincronizadas.
- **Reutilización y optimización de memoria:** Si los objetos `ConcreteState` carecen de variables de instancia intrínsecas (solo encapsulan lógica algorítmica), pueden compartirse entre múltiples contextos como *Flyweights* o *Singletons*.
- **Eliminación sistemática de condicionales:** Transforma la toma de decisiones estática de control de flujo en despacho dinámico polimórfico en tiempo de ejecución.

### Desventajas / Consideraciones:
- **Proliferación de clases:** Puede incrementar sustancialmente el volumen de clases en el sistema si el contexto cuenta con muchos estados pequeños o transiciones simples.
- **Acoplamiento entre subclases de estado (en transiciones descentralizadas):** Si los `ConcreteState` deciden los sucesores, deben conocer e instanciar directamente a sus clases hermanas, lo cual genera una red de dependencias entre las subclases del patrón.
- **Exposición del Context:** Si el estado requiere interactuar intensamente con el contexto, este último debe exponer métodos de modificación de estado interno, debilitando potencialmente su encapsulamiento frente a terceros.

---

## 7. Detalles de Implementación

### A. ¿Quién define las transiciones de estado?
1. **Transiciones descentralizadas (en las subclases de `State`):**
   * *Mecanismo:* Cada `ConcreteState` conoce bajo qué estímulos debe cambiar de fase y le ordena al contexto transicionar (`aContext changeState: TCPEstablished new`).
   * *Ventaja:* Es la solución más modular y natural de diseño orientado a objetos puros; no deja rastro de condicionales en el `Context`.
   * *Desventaja:* Introduce acoplamiento directo entre estados hermanos.
2. **Transiciones centralizadas (en el `Context`):**
   * *Mecanismo:* El `Context` evalúa internamente el resultado de la delegación y decide si muta su propia variable `state`.
   * *Ventaja:* Los estados quedan 100% aislados entre sí; ninguno sabe de la existencia de sus pares.
   * *Desventaja:* Si las condiciones de transición son complejas o dependen del tipo de respuesta, el `Context` vuelve a ensuciarse con sentencias condicionales.

### B. Gestión del ciclo de vida de los estados
- **Creación bajo demanda (*On-Demand Instantiation*):** El estado se crea justo antes de transicionar y se descarta al salir. Minimiza la huella de memoria si ciertos estados se alcanzan con poca frecuencia o si requieren capturar parámetros específicos del momento de transición.
- **Instanciación previa / Flyweight:** Los estados se instancian una sola vez (por ejemplo, a nivel de clase o en una variable de clase) y se reutilizan indefinidamente. Es ideal cuando las transiciones son de muy alta frecuencia y los estados son puramente comportamentales (sin variables de instancia).

### C. Implementación en Smalltalk: State vs. `#become:`
En Smalltalk existe la primitiva idiomática `self become: anObject`, la cual intercambia los punteros de memoria de dos objetos en la máquina virtual, haciendo que literalmente una instancia *"cambie de clase"*. 
No obstante, *The Design Patterns Smalltalk Companion* advierte fuertemente contra el uso indiscriminado de `#become:` para implementar State por las siguientes razones:
- **Costo de rendimiento:** En muchas VMs históricas, `#become:` requería recorrer la memoria entera (*object table scan*).
- **Inseguridad de identidad:** Rompe la identidad conceptual del `Context` y de sus referencias externas si no se utiliza la variante one-way (`#becomeForward:`).
- **Diseño clásico superior:** La delegación estándar mediante una variable de instancia `state` encapsulada en el `Context` es limpia, predecible en el debugger, no corrompe punteros y respeta el ciclo de vida del entorno.

---

## 8. Código de Ejemplo (Smalltalk - Transición Descentralizada)

Contexto:

```smalltalk
Object subclass: #ConexionTCP
    instanceVariableNames: 'estado'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-State'

ConexionTCP >> initialize
    super initialize.
    estado := EstadoTCPCerrado new.

ConexionTCP >> cambiarEstadoA: unEstadoTCP
    estado := unEstadoTCP

ConexionTCP >> abrir
    estado abrirEn: self

ConexionTCP >> cerrar
    estado cerrarEn: self

ConexionTCP >> enviar: unDato
    estado enviar: unDato en: self
```

Estado abstracto (define comportamiento por defecto o errores de protocolo):

```smalltalk
Object subclass: #EstadoTCP
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-State'

EstadoTCP >> abrirEn: unaConexion
    self error: 'Operacion no permitida en este estado'

EstadoTCP >> cerrarEn: unaConexion
    self error: 'Operacion no permitida en este estado'

EstadoTCP >> enviar: unDato en: unaConexion
    self error: 'No se puede enviar datos sin conexion activa'
```

Subclases concretas de Estado:

```smalltalk
EstadoTCP subclass: #EstadoTCPCerrado
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-State'

EstadoTCPCerrado >> abrirEn: unaConexion
    "Lógica de conexión y transición atómica"
    unaConexion cambiarEstadoA: EstadoTCPEstablecido new
```

```smalltalk
EstadoTCP subclass: #EstadoTCPEstablecido
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-State'

EstadoTCPEstablecido >> enviar: unDato en: unaConexion
    "Transmisión de datos sobre la red física..."
    Transcript show: 'Enviando dato: ', unDato asString; cr.

EstadoTCPEstablecido >> cerrarEn: unaConexion
    "Lógica de desconexión y transición"
    unaConexion cambiarEstadoA: EstadoTCPCerrado new
```

Uso por el cliente:

```smalltalk
| conexion |
conexion := ConexionTCP new.

"La conexión inicia en Cerrado; enviar dato fallará"
[ conexion enviar: 'hola' ] on: Error do: [ :err | Transcript show: err messageText; cr ].

"Transiciona a Establecido"
conexion abrir.

"Ahora enviar dato ejecuta el comportamiento activo"
conexion enviar: 'Paquete de datos 01'.

"Transiciona de regreso a Cerrado"
conexion cerrar.
```

---

## 9. Usos Conocidos en el Entorno Smalltalk
- **Herramientas de Selección y Dibujo en Morphic / HotDraw (`DrawingController` / `Tool`):** Las herramientas de edición gráfica (selección, trazo a mano alzada, creación de figuras) cambian el estado del canvas. El canvas delega los eventos del mouse (`mouseDown:`, `mouseMove:`, `mouseUp:`) en la herramienta/estado activo, la cual interpreta los gestos del usuario de forma completamente diferente según el modo seleccionado.
- **Controladores de Conexión de Sockets:** La jerarquía de sockets (`Socket`, `SocketStream`) implementa máquinas de estado internas para regular operaciones de handshake, lectura con timeout y cierre ordenado de streams.
- **Procesamiento de Transacciones en Bases de Datos (ODBC / GLORP):** Las conexiones a bases de datos gestionan estados de transacción activa, solo lectura o desconexión, bloqueando o habilitando comandos como `commit` o `rollback`.

---

## 10. Patrones Relacionados
- **Strategy:** Ambos comparten un diagrama estructural casi idéntico basado en delegación. La diferencia radica en la **intención**: Strategy parametriza un algoritmo estático o intercambiable desde afuera por el cliente, mientras que State modela un ciclo de vida dinámico donde las transiciones ocurren en tiempo de ejecución de forma reactiva a los eventos.
- **Flyweight:** Es una práctica estándar implementar los objetos `ConcreteState` como instancias compartidas Flyweight cuando carecen de estado intrínseco (variables mutables).
- **Singleton:** Cuando un `ConcreteState` no requiere parámetros de inicialización ni variables de instancia, a menudo se gestiona como una instancia única (*Singleton*).
- **Bridge:** Aunque tienen estructuras similares de delegación, Bridge desacopla una abstracción de su implementación para permitir que ambas varíen independientemente, sin relación con el concepto de ciclo de vida operacional.