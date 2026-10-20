# Resumen del Patrón: Observer (Dependents)
**Referencia:** *The Design Patterns Smalltalk Companion* (Alpern, Benson, Lee, Rising, Smith; con contribuciones de Ralph Johnson y John Vlissides) / Adaptación del libro de GoF a Smalltalk.

---

## 1. Intención y Otros Nombres
- **Intención:** Definir una dependencia uno-a-muchos entre objetos, de manera que cuando un objeto cambia su estado, todos sus dependientes sean notificados y actualizados de manera automática.
- **Otros Nombres:** *Dependents*, *Publish-Subscribe*, *Model-View-Controller (MVC)*.

---

## 2. Motivación y Diagnóstico
Un sistema orientado a objetos necesita a menudo mantener la consistencia entre clases relacionadas sin acoplarlas estrechamente. En particular, se busca aislar la lógica del modelo de dominio de sus representaciones gráficas o vistas.

### El Diagnóstico en Smalltalk:
En Smalltalk, el soporte para Observer no es simplemente un diseño conceptual que deba implementarse desde cero en cada jerarquía; está integrado directamente en el núcleo del sistema a través de la clase raíz `Object`.

1. **Acoplamiento fuerte (Intento ingenuo):**
   * Si un objeto de modelo (por ejemplo, una cuenta bancaria) conoce directamente las ventanas, listas o vistas que lo representan, queda rígidamente ligado a la interfaz gráfica.
   * Reutilizar el modelo sin la interfaz o agregar nuevas vistas requeriría modificar el código del modelo.
2. **Solución integrada con el Protocolo de Dependencias (`Object`):**
   * Todo objeto en Smalltalk hereda la capacidad de tener dependientes y de ser un dependiente.
   * El sujeto notifica a sus observadores mediante mensajes como `#changed` o `#changed:`.
   * El framework despacha automáticamente el mensaje `#update:` o `#update:with:` a cada objeto registrado como dependiente.

---

## 3. Aplicabilidad
El patrón Observer se utiliza cuando:
- Una abstracción tiene dos aspectos y uno depende del otro (por ejemplo, separar el modelo de dominio de la vista/interfaz de usuario).
- Un cambio en un objeto requiere cambiar otros objetos sin que el primero sepa cuántos ni cuáles son.
- Un objeto necesita notificar a otros sin asumir quiénes son ni conocer sus clases concretas (bajo acoplamiento).

---

## 4. Estructura y Participantes

```
      Sujeto (Subject / Object) <------------------------ Registra / Remueve
          - dependents (Model o Collection)                  (addDependent:, removeDependent:)
                  |
                  | notifica vía #changed / #changed:
                  v
       Observador (Observer / Object)
          - update: anAspect
          - update: anAspect with: aParameter
```

- **Sujeto (`Subject` / en Smalltalk cualquier `Object` o subclase de `Model`):**
  * Conoce a sus dependientes.
  * Provee una interfaz para añadir (`addDependent:`) y remover (`removeDependent:`) observadores.
  * Dispara las notificaciones enviándose mensajes a sí mismo (`self changed:`).
- **Observador (`Observer` / cualquier `Object` que actúe como vista, controlador o listener):**
  * Define la interfaz de actualización (`update:`, `update:with:`).
  * Consulta el estado del sujeto cuando recibe la notificación para sincronizarse.

---

## 5. Colaboraciones
1. El Observador se registra ante el Sujeto enviando `unSujeto addDependent: unObservador`.
2. Ocurre una mutación en el Sujeto (por ejemplo, se modifica una variable de instancia).
3. El Sujeto se envía a sí mismo `self changed: #unAspecto` (o `self changed`).
4. La infraestructura de dependencias itera sobre todos los dependientes registrados y les envía `update: #unAspecto` (o `update:` con el parámetro correspondiente).
5. Cada Observador evalúa si el aspecto recibido le concierne. De ser así, consulta al Sujeto su nuevo estado y actualiza su propia representación o comportamiento.

---

## 6. Consecuencias

### Ventajas:
- **Bajo acoplamiento abstracto:** El sujeto solo sabe que tiene una lista de objetos que entienden `#update:`. No necesita conocer clases concretas de vistas ni cuántas existen.
- **Soporte de difusión (*Broadcast communication*):** La notificación se envía indiscriminadamente a todos los observadores registrados, permitiendo incorporar vistas o escuchas adicionales en cualquier momento.
- **Soporte nativo en Smalltalk:** Al estar definido en `Object`, cualquier objeto puede actuar como sujeto o como observador sin necesidad de implementar interfaces intermedias.

### Desventajas / Consideraciones:
- **Actualizaciones inesperadas o en cascada:** Como los observadores no saben de la existencia de otros observadores, una cadena de actualizaciones puede disparar ciclos infinitos o recálculos redundantes si no se diseñan con cuidado los aspectos.
- **Fugas de memoria (*Lapsing listeners / Memory leaks*):** En Smalltalk clásico, las dependencias de los objetos que no heredan de `Model` se mantienen en un diccionario global (`DependentsFields`). Si un observador no se desuscribe explícitamente (`removeDependent:`), el diccionario retiene una referencia fuerte impidiendo que el recolector de basura lo libere.
- **Granularidad del cambio:** Dependiendo de si se usa el modelo *Push* (enviar el dato completo en la notificación) o *Pull* (enviar solo el aspecto y requerir que la vista consulte), puede generarse sobrecarga de mensajes o complejidad al filtrar eventos.

---

## 7. Detalles de Implementación en Smalltalk

1. **Protocolo en `Object`:**
   * **Gestión de dependientes:** `addDependent:`, `removeDependent:`, `dependents`, `release`.
   * **Disparo de notificaciones:** `changed`, `changed: anAspect`, `changed: anAspect with: aValue`.
   * **Recepción de actualizaciones:** `update: anAspect`, `update: anAspect with: aParameter`.
2. **`Model` como optimización de almacenamiento:**
   * En `Object`, los dependientes se guardan en un `IdentityDictionary` global de clase (`DependentsFields`), lo cual ahorra espacio para objetos que nunca tienen dependientes pero introduce contención e indirección.
   * Las clases que heredan de `Model` definen una variable de instancia propia llamada `dependents`, haciendo que el acceso y la notificación sean directos y locales a cada instancia.
3. **Modelos Push vs. Pull:**
   * **Pull (habitual en Smalltalk):** Se envía el símbolo del aspecto que mutó (`self changed: #saldo`). El observador recibe `#saldo` y le consulta al sujeto `unSujeto saldo`.
   * **Push:** Se incluye el dato modificado en el mensaje (`self changed: #saldo with: nuevoSaldo`), evitando consultas secundarias.
4. **Desconexión (`release`):**
   * Es una práctica fundamental en Smalltalk enviar `self release` o `self breakDependents` al destruir vistas o modelos para limpiar la tabla global de dependencias.

---

## 8. Código de Ejemplo (Smalltalk-80 / Cuis)

Definición de un modelo simple:

```smalltalk
Model subclass: #CuentaBancaria
    instanceVariableNames: 'saldo'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-Observer'

CuentaBancaria >> initialize
    super initialize.
    saldo := 0.

CuentaBancaria >> depositar: unMonto
    saldo := saldo + unMonto.
    self changed: #saldo.

CuentaBancaria >> saldo
    ^saldo
```

Definición del observador (por ejemplo, una vista o monitor):

```smalltalk
Object subclass: #ConsolaMonitor
    instanceVariableNames: 'cuenta'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Ejemplo-Observer'

ConsolaMonitor >> monitorear: unaCuenta
    cuenta := unaCuenta.
    cuenta addDependent: self.

ConsolaMonitor >> update: anAspect
    anAspect = #saldo ifTrue: [
        Transcript show: 'El saldo se actualizó a: ', cuenta saldo printString; cr.
    ].

ConsolaMonitor >> detenerMonitoreo
    cuenta removeDependent: self.
    cuenta := nil.
```

---

## 9. Usos Conocidos en el Entorno Smalltalk
- **MVC (Model-View-Controller):** El `Model` notifica mediante `changed:` y la `View` responde en `update:` redibujándose.
- **Morphic Framework:** En entornos derivados como Squeak o Cuis, muchos `Morphs` o inspectores actúan como dependientes del modelo que representan.
- **Inspectores y Browsers:** Cuando una clase es modificada o recompilada, el `SystemDictionary` (Smalltalk) emite eventos de cambio de sistema que los `SystemBrowser` escuchan para refrescar sus listas de categorías, clases y métodos.
- **`ValueModel` y adaptadores pluggables:** Mecanismos que encapsulan un aspecto específico de un objeto para observarlo individualmente.

---

## 10. Patrones Relacionados
- **Mediator:** Se utiliza frecuentemente junto con Observer para coordinar varios widgets complejos sin que estos se observen directamente entre sí.
- **Singleton:** El diccionario global de dependencias (`DependentsFields`) actúa como un recurso centralizado para todos los objetos del sistema.
- **Strategy:** En MVC clásico, el controlador actúa como la estrategia de entrada para la vista, mientras que la relación entre vista y modelo sigue el patrón Observer.