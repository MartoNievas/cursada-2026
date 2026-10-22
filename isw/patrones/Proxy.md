# Resumen del Paper / Libro: El Patrón Proxy

**Referencia:** *The Design Patterns Smalltalk Companion* (Alpern, Benson, Lee, Rising, Smith; con contribuciones de Ralph Johnson y John Vlissides) / Adaptación del libro de GoF a Smalltalk.

---

## 1. Intención y Otros Nombres
- **Intención:** Proporcionar un sustituto o representante de otro objeto para controlar el acceso a este. El proxy actúa como intermediario manteniendo la misma interfaz pública que el sujeto real, de modo que resulta transparente para los clientes.
- **Otros Nombres:** *Surrogate* (Sustituto), *Representante*.

---

## 2. Motivación y Diagnóstico
En múltiples escenarios de diseño es necesario diferir la instanciación de un objeto costoso hasta que realmente se requiera (carga perezosa o *lazy initialization*), proteger el acceso a un recurso según permisos de seguridad, coordinar la comunicación con un objeto alojado en otro proceso o máquina remota, o contabilizar referencias.

### El Diagnóstico en Smalltalk:
1. **Acceso directo costoso o desprotegido:**
   * Si un cliente mantiene una referencia directa a un objeto pesado (por ejemplo, una imagen rasterizada de alta resolución o un documento complejo en disco), cargarlo en memoria al inicializar el sistema desperdicia recursos si el usuario jamás llega a visualizarlo o manipularlo.
   * Acoplar la lógica de red, persistencia o control de permisos directamente dentro de la clase de dominio rompe el principio de responsabilidad única (*Single Responsibility Principle*).
2. **Solución por sustitución polimórfica:**
   * Se crea un objeto sustituto (*Proxy*) que conforma exactamente el mismo protocolo de mensajes que el objeto real (*RealSubject*).
   * El proxy retiene la información mínima necesaria (por ejemplo, dimensiones visuales o ruta en disco) para simular la presencia del objeto real ante consultas superficiales.
   * Cuando se le solicita una operación que exige la presencia efectiva del objeto de dominio, el proxy instantiates/carga el `RealSubject` bajo demanda y le reenvía el mensaje original.
   * El cliente manipula el proxy creyendo que interactúa directamente con el objeto final.

---

## 3. Aplicabilidad
El patrón Proxy se utiliza cuando se necesita una referencia más versátil o controlada a un objeto que un puntero/referencia directa:
- **Proxy Virtual (*Virtual Proxy*):** Para crear objetos costosos bajo demanda (*lazy evaluation* / inicialización diferida), como imágenes grandes o grafos de objetos persistentes.
- **Proxy Remoto (*Remote Proxy*):** Para representar un objeto que reside en un espacio de direcciones diferente (otro proceso o máquina remota en red), encapsulando la serialización de mensajes y la comunicación por sockets.
- **Proxy de Protección (*Protection Proxy*):** Para verificar permisos de acceso antes de ejecutar operaciones críticas sobre el sujeto real.
- **Referencia Inteligente (*Smart Reference*):** Para ejecutar acciones accesorias cuando se accede al objeto (bloqueo por concurrencia, logging, conteo de accesos o carga de persistencia desde base de datos).

---

## 4. Estructura y Participantes

```
               Cliente (Client)
                      |
                      v
          Sujeto (Subject / Protocolo Común)
          - request
                      /               \
                     /                 \
     SujetoReal (RealSubject)      Proxy (Proxy / Encapsulador)
     - request                     - realSubject
                                   - request
```

- **Sujeto (`Subject`):** Define el protocolo común tanto para el `RealSubject` como para el `Proxy`, permitiendo que el proxy sea utilizado en cualquier lugar donde se espere al sujeto real.
- **SujetoReal (`RealSubject`):** El objeto real de negocio que ejecuta la lógica sustancial y al cual el proxy representa.
- **Proxy (`Proxy`):** Mantiene una referencia al `RealSubject` (la cual puede crearse de forma diferida), conforma la interfaz de `Subject` y controla la creación, acceso o invocación sobre el objeto real.
- **Cliente (`Client`):** Envía mensajes interactuando con la interfaz abstracta `Subject` sin distinguir si el receptor es el proxy o el sujeto real.

---

## 5. Colaboraciones
1. El cliente envía un mensaje protocolar (por ejemplo, `#displayOn:`) al `Proxy`.
2. Si se trata de un **Proxy Virtual** y el sujeto real aún no existe en memoria, el proxy lo instancia o lo recupera del medio de almacenamiento (`realSubject := self cargarObjetoReal`).
3. Si se trata de un **Proxy de Protección**, valida las credenciales o condiciones de acceso antes de continuar; si la verificación falla, interrumpe el flujo o señala una excepción.
4. Si se trata de un **Proxy Remoto**, serializa el selector y los argumentos del mensaje, los envía a través de la red hacia el nodo remoto y espera la respuesta.
5. El proxy reenvía el mensaje al `RealSubject` y retorna la respuesta al cliente.

---

## 6. Consecuencias

### Ventajas:
- **Optimización de recursos:** Permite aplazar la carga o creación de estructuras de datos masivas hasta el instante exacto en que son requeridas.
- **Transparencia hacia el cliente:** El código cliente permanece desacoplado de la ubicación física del objeto (local o remoto) y de los mecanismos de seguridad o persistencia.
- **Separación de infraestructura y dominio:** Las tareas de transporte de red, auditoría o caché no contaminan el modelo conceptual del `RealSubject`.

### Desventajas / Consideraciones en Smalltalk:
- **Problema de identidad de objetos (*Identity Crisis*):**
  * Al igual que en Decorator y Adapter, `proxy == realSubject` evalúa como `false`. Si el cliente o una colección interna (`IdentityDictionary`, `IdentitySet`) utiliza comparación por identidad, pueden presentarse comportamientos inesperados.
- **Complejidad de delegación completa:**
  * Si el proxy hereda de `Object`, hereda una gran cantidad de comportamiento por defecto (`printString`, `class`, `isNil`, `hash`, `==`). Si estos mensajes no se delegan explícitamente o no se capturan adecuadamente, el proxy responderá por sí mismo en lugar de consultar al sujeto real.

---

## 7. Detalles de Implementación en Smalltalk

1. **El Idioma de los "Ghost Objects" (Objetos Fantasma) y `ProtoObject`:**
   * En Smalltalk clásico, un proxy transparente no suele heredar de `Object` sino de una raíz mínima como `ProtoObject` (o una clase con el protocolo stripped).
   * Al carecer prácticamente de métodos propios, casi cualquier mensaje enviado al proxy dispara el mecanismo de `#doesNotUnderstand: aMessage`.
2. **Implementación mediante `#doesNotUnderstand:`:**
   * El proxy implementa `#doesNotUnderstand: aMessage`, materializa el objeto real si es necesario y reenvía dinámicamente el mensaje usando `realSubject perform: aMessage selector withArguments: aMessage arguments`.
3. **Mutación de Clase en Caliente (`become:` y `becomeForward:`):**
   * Smalltalk provee una técnica única y poderosa para proxies virtuales: la primitiva `#become:` o `#becomeForward:`.
   * Un proxy virtual ligero intercepta el primer mensaje real, carga el objeto pesado desde el disco o la base de datos y ejecuta `self becomeForward: objetoCargado`.
   * De este modo, todas las referencias en el heap de Smalltalk que apuntaban al proxy pasan a apuntar instantáneamente al objeto real, eliminando el sobrecosto de delegación para todas las invocaciones futuras y resolviendo el problema de identidad.
4. **Proxies Remotos en Distributed Smalltalk:**
   * En arquitecturas distribuidas de Smalltalk, los proxies remotos empaquetan mensajes en objetos de tipo `Message` y los despachan a través de canales de transporte RPC transparentes.

---

## 8. Código de Ejemplo (Smalltalk - Proxy Virtual de Imagen)

Componente abstracto / Protocolo común:

```smalltalk
Object subclass: #ImagenGrafica
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-Proxy'

ImagenGrafica >> dibujarEn: unCanvas
    self subclassResponsibility

ImagenGrafica >> extension
    self subclassResponsibility
```

Sujeto Real (costoso en memoria/tiempo):

```smalltalk
ImagenGrafica subclass: #ImagenReal
    instanceVariableNames: 'archivo extension mapaDeBits'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-Proxy'

ImagenReal >> cargarDesdeArchivo: unaRuta
    archivo := unaRuta.
    "Simula una carga costosa de disco y decodificación de bytes"
    extension := 1024@768.
    mapaDeBits := ByteArray new: 1024 * 768.

ImagenReal >> extension
    ^extension

ImagenReal >> dibujarEn: unCanvas
    unCanvas pintarMapaDeBits: mapaDeBits en: 0@0
```

Proxy Virtual (ligero, retrasa la carga hasta `#dibujarEn:`):

```smalltalk
ImagenGrafica subclass: #ImagenProxy
    instanceVariableNames: 'rutaArchivo dimensionAproximada imagenReal'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-Proxy'

ImagenProxy >> paraArchivo: unaRuta dimension: unPoint
    rutaArchivo := unaRuta.
    dimensionAproximada := unPoint.
    imagenReal := nil

ImagenProxy >> extension
    "Responde de inmediato sin cargar la imagen pesada"
    imagenReal ifNotNil: [ ^imagenReal extension ].
    ^dimensionAproximada

ImagenProxy >> imagenReal
    imagenReal ifNil: [
        imagenReal := ImagenReal new.
        imagenReal cargarDesdeArchivo: rutaArchivo ].
    ^imagenReal

ImagenProxy >> dibujarEn: unCanvas
    "Carga diferida (lazy evaluation) solo cuando se solicita dibujar"
    self imagenReal dibujarEn: unCanvas
```

Ejemplo alternativo con delegación genérica (`#doesNotUnderstand:`):

```smalltalk
ProtoObject subclass: #ProxyGenerico
    instanceVariableNames: 'objetivo'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-Proxy'

ProxyGenerico >> inicializarCon: unObjeto
    objetivo := unObjeto.
    ^self

ProxyGenerico >> doesNotUnderstand: unMensaje
    "Auditoría o control antes de delegar"
    Transcript show: 'Interceptado mensaje: ', unMensaje selector printString; cr.
    ^unMensaje sendTo: objetivo
```

---

## 9. Usos Conocidos en el Entorno Smalltalk
- **Sistemas de Persistencia OODBMS (GemStone / TOPaz / Glorp):** Emplean proxies virtuales (a menudo combinados con `becomeForward:`) para materializar grafos de objetos persistentes solo a medida que el código navega a través de sus variables de instancia.
- **Distributed Smalltalk (DST):** Los objetos remotos se representan en la imagen local mediante proxies que serializan selectores y argumentos a través de sockets de red hacia la imagen remota receptora.
- **Entornos Visuales y Fuentes (Font/Glyph proxies):** Proxies que almacenan únicamente el nombre y tamaño de una tipografía, instanciando la matriz completa de glifos en el servidor gráfico solo cuando una cadena de texto debe renderizarse en pantalla.

---

## 10. Patrones Relacionados
- **Adapter:** Provee una interfaz diferente a la del objeto adaptado para resolver incompatibilidades; Proxy replica estrictamente la misma interfaz para controlar el acceso.
- **Decorator:** Posee una estructura de implementación análoga basada en envoltura, pero su propósito es agregar responsabilidades funcionales adicionales al objeto; Proxy controla el acceso, ciclo de vida o instanciación diferida sin extender la lógica central.
- **Facade:** Provee una interfaz simplificada para un subsistema entero compuesto por múltiples clases; Proxy representa a un único sujeto individual conservando su misma interfaz.