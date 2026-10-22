# Resumen del Paper / Libro: El Patrón Adapter

**Referencia:** *The Design Patterns Smalltalk Companion* (Alpern, Benson, Lee, Rising, Smith; con contribuciones de Ralph Johnson y John Vlissides) / Adaptación del libro de GoF a Smalltalk.

---

## 1. Intención y Otros Nombres
- **Intención:** Convertir la interfaz de una clase existente en otra interfaz que los clientes esperan. Adapter permite que clases con interfaces incompatibles colaboren entre sí sin necesidad de modificar su código fuente.
- **Otros Nombres:** *Wrapper* (Envoltorio), *Adaptador*.

---

## 2. Motivación y Diagnóstico
Al integrar librerías de terceros, frameworks visuales o componentes legados, suele ocurrir que un objeto provee la funcionalidad requerida pero expone un protocolo de mensajes diferente al que el cliente invoca. Modificar la clase original no siempre es posible ni deseable, ya que puede romper otros clientes o tratarse de código cerrado de una librería.

### El Diagnóstico en Smalltalk:
1. **Incompatibilidad de protocolo (El problema dinámico):**
   * En Smalltalk no existen interfaces estáticas ni chequeos en tiempo de compilación; el polimorfismo se basa puramente en los selectores de mensajes a los que un objeto responde.
   * Si un componente espera que un objeto responda a `#dibujar` pero la clase reutilizable responde a `#mostrarEnVentana:`, la interacción falla con una excepción `MessageNotUnderstood`.
2. **Limitación de herencia múltiple:**
   * El libro original de GoF presenta dos variantes: *Class Adapter* (usando herencia múltiple) y *Object Adapter* (usando composición y delegación).
   * Dado que los entornos estándar de Smalltalk no poseen herencia múltiple, la variante clásica de clase se reemplaza casi universalmente por el **Object Adapter** o por adaptadores parametrizados (**Pluggable Adapters**).
3. **Solución por adaptación:**
   * El adaptador envuelve al objeto adaptado (*adaptee*) y expone el protocolo esperado por el cliente (*target*).
   * Al recibir un mensaje del cliente, el adaptador traduce los argumentos, invoca los selectores correctos en el adaptado y, si es necesario, transforma el valor de retorno.

---

## 3. Aplicabilidad
El patrón Adapter se utiliza cuando:
- Se desea reutilizar una clase existente cuyo protocolo de mensajes no concuerda con la interfaz requerida por el cliente o el framework.
- Se busca crear una clase reutilizable que pueda colaborar con clases imprevistas o no relacionadas que no comparten un protocolo común.
- Se necesita adaptar el comportamiento de múltiples objetos sin crear una subclase dedicada para cada uno (mediante adaptadores conectables basados en bloques o selectores).

---

## 4. Estructura y Participantes

```
               Cliente (Client)
                      |
                      v
          Objetivo (Target / Protocolo Esperado)
          - request / #dibujar
                      |
                      |  (implementa)
                      v
               Adaptador (Adapter) ------------> Adaptado (Adaptee)
          - adaptee                               - specificRequest / #mostrarEnVentana:
          - request / #dibujar
```

- **Objetivo (`Target`):** Define el protocolo de mensajes específico del dominio que el cliente utiliza e invoca.
- **Cliente (`Client`):** Colabora con objetos que conforman el protocolo `Target`.
- **Adaptado (`Adaptee`):** Clase u objeto existente que posee el comportamiento deseado pero expone una interfaz incompatible.
- **Adaptador (`Adapter`):** Encapsula una referencia al `Adaptee` y adapta su protocolo al contrato esperado por el `Target`.

---

## 5. Colaboraciones
1. El cliente envía un mensaje protocolar (por ejemplo, `#posicion`) a la instancia del `Adapter`.
2. El `Adapter` recibe el mensaje e invoca internamente la operación correspondiente sobre su objeto adaptado (`adaptee`), por ejemplo enviando `#coordenadaActual`.
3. Si los formatos de datos difieren (por ejemplo, si el cliente espera un `Point` y el adaptado devuelve dos enteros separados `x` e `y`), el adaptador realiza la conversión y empaqueta el resultado.
4. El adaptador retorna el resultado procesado al cliente, manteniéndolo completamente ajeno a las diferencias de protocolo.

---

## 6. Consecuencias

### Ventajas:
- **Reutilización directa:** Permite incorporar componentes y librerías preexistentes sin alterar su código interno ni el del cliente.
- **Separación de responsabilidades:** La lógica de traducción de protocolos queda concentrada en un único objeto intermedio.
- **Flexibilidad con Pluggable Adapters:** En Smalltalk, el uso de bloques (`BlockClosure`) y selectores dinámicos permite crear adaptadores genéricos configurables en una sola línea, reduciendo la necesidad de crear subclases específicas.

### Desventajas / Consideraciones en Smalltalk:
- **Capa extra de indirección:** Cada llamada implica un reenvío adicional de mensajes, con un impacto menor pero existente en escenarios de alta frecuencia de invocación.
- **Confusión de identidad:** Al igual que en Decorator, el `Adapter` y el `Adaptee` son objetos independientes; evaluar identidad estricta (`==`) entre el adaptador y el objeto original resulta en falso.

---

## 7. Detalles de Implementación en Smalltalk

1. **Object Adapter (Composición):**
   * Es la estrategia fundamental en Smalltalk. El adaptador almacena al objeto adaptado en una variable de instancia y traduce los selectores implementando métodos explícitos.
2. **Pluggable Adapters (Adaptadores Conectables):**
   * Es una técnica distintiva en Smalltalk. En lugar de crear una clase para cada adaptación, se diseña un adaptador genérico parametrizado con selectores o bloques:
     * **Uso de `#perform:`:** El adaptador guarda el símbolo del selector (`#unMensaje`) y lo despacha dinámicamente mediante `adaptee perform: selectorAdaptado`.
     * **Uso de Bloques:** Se inyectan bloques de código que encapsulan la traducción (`[ :a | a mensajeEspecifico ]`), otorgando máxima flexibilidad sin subclases.
3. **AspectAdapters y ValueModels:**
   * En frameworks de interfaz gráfica como VisualWorks o Morphic, el concepto de adaptador se lleva al extremo con clases como `AspectAdaptor`, que conectan un aspecto específico de un objeto de dominio con un control visual genérico.

---

## 8. Código de Ejemplo (Smalltalk)

### Ejemplo 1: Object Adapter Clásico

Clase adaptada preexistente (interfaz ajena):

```smalltalk
Object subclass: #SensorTemperaturaExterno
    instanceVariableNames: 'gradosFahrenheit'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-Adapter'

SensorTemperaturaExterno >> temperaturaFahrenheit: unNumero
    gradosFahrenheit := unNumero

SensorTemperaturaExterno >> obtenerLecturaFahrenheit
    ^gradosFahrenheit
```

Adaptador que provee el protocolo esperado (`#temperaturaCelsius`):

```smalltalk
Object subclass: #AdaptadorSensorCelsius
    instanceVariableNames: 'sensor'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-Adapter'

AdaptadorSensorCelsius >> sensor: unSensorExterno
    sensor := unSensorExterno

AdaptadorSensorCelsius >> temperaturaCelsius
    "Traduce la lectura y convierte de Fahrenheit a Celsius"
    | fahrenheit |
    fahrenheit := sensor obtenerLecturaFahrenheit.
    ^(fahrenheit - 32) * (5 / 9)
```

### Ejemplo 2: Pluggable Adapter (Basado en Bloques)

Adaptador genérico configurable:

```smalltalk
Object subclass: #AdaptadorConectable
    instanceVariableNames: 'objetoAdaptado bloqueTraductor'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-Adapter'

AdaptadorConectable >> para: unObjeto transformandoCon: unBloque
    objetoAdaptado := unObjeto.
    bloqueTraductor := unBloque

AdaptadorConectable >> valor
    ^bloqueTraductor value: objetoAdaptado
```

Uso por el cliente:

```smalltalk
| sensorLegacy adaptador |
sensorLegacy := SensorTemperaturaExterno new temperaturaFahrenheit: 100.

adaptador := AdaptadorConectable new
    para: sensorLegacy
    transformandoCon: [ :s | ((s obtenerLecturaFahrenheit - 32) * (5 / 9)) asFloat ].

adaptador valor. "Devuelve 37.77777777777778"
```

---

## 9. Usos Conocidos en el Entorno Smalltalk
- **AspectAdaptor (VisualWorks / UI Builder):** Conecta widgets genéricos (como campos de texto o deslizadores) a atributos específicos de objetos del modelo de dominio, traduciendo lecturas y escrituras de aspectos.
- **Pluggable Views y Morphs (Squeak / Pharo):** Clases como `PluggableButtonMorph` o `PluggableListMorph` no conocen de antemano el modelo; reciben selectores (`action:`, `getListSelector:`) para actuar como adaptadores directos entre el framework visual y cualquier clase de dominio.
- **MessageSend:** Objeto que encapsula receptor, selector y argumentos para funcionar como adaptador universal de invocaciones en sistemas de eventos y callbacks.

---

## 10. Patrones Relacionados
- **Decorator:** Mantiene intacto el protocolo del componente y añade responsabilidades; Adapter cambia o traduce el protocolo existente para lograr compatibilidad.
- **Proxy:** Proporciona un sustituto o representante para un objeto con la misma interfaz para controlar accesos o diferir operaciones; no busca solucionar incompatibilidades de protocolo.
- **Bridge:** Tiene una estructura física similar a Adapter, pero se diseña de antemano para desacoplar una abstracción de sus implementaciones independientes; Adapter se aplica habitualmente a posteriori sobre código preexistente.