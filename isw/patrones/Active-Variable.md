# Resumen del Paper: Active Variables in Smalltalk-80
**Autores:** Steven L. Messick y Kent L. Beck (Tektronix, Inc., 1985)

---

## 1. Intención y Otros Nombres
- **Intención:** Proveer un mecanismo transparente a nivel de lenguaje para asociar procedimientos auxiliares (llamados *daemons*) a variables, ejecutándose automáticamente ante cada acceso de lectura o escritura sin requerir que el programador instrumente explícitamente el código cliente con notificaciones.
- **Otros Nombres:** *Active Values* (término originario de LOOPS).

---

## 2. Motivación y Diagnóstico
En Smalltalk estándar no existía una forma nativa y transparente de monitorear dinámicamente la asignación o lectura de variables.

### El Problema de las Aproximaciones Previas:
1. **Instrumentación manual de código:** Técnicas anteriores (como las empleadas por London, Duisberg o Wagner) simulaban variables activas obligando al programador a modificar cada punto del código donde se leía o mutaba una variable para registrar los cambios explícitamente.
2. **Impacto en el programador:** Exigir llamadas manuales de notificación contamina el código del dominio, introduce acoplamiento y resulta propenso a omisiones.
3. **Solución propuesta:** Integrar las *Active Variables* modificando el compilador de Smalltalk-80 para que la interceptación sea automática, empaquetable y pueda cargarse directamente sobre una imagen existente.

---

## 3. Aplicabilidad
El mecanismo se utiliza cuando se requiere:
- Monitorear o reflejar cambios de estado en interfaces gráficas e instrumentación (*dials and gauges*, como pantallas LCD o medidores) de forma desacoplada.
- Tareas de depuración no invasivas (*debugging* y *tracing*), como inspeccionar la pila de ejecución (*context stack*) o volcar valores al `Transcript` en puntos específicos.
- Validación de invariantes de estado o coerción dinámica de tipos durante la asignación.
- Valores calculados al vuelo o dinámicos en variables (donde cada lectura compute un valor nuevo mediante una función arbitraria).

---

## 4. Estructura y Participantes

```
  Objeto Contenedor (self)
         |
  [variable de instancia / temporal]
         |
         v
  InactiveVariable (Kernal-Objects)
         ^
         |
  ActiveVariable (getDaemon, setDaemon, name)
         ^
         |
  SpecificActiveVariable (daemons como bloques)
```

- **`InactiveVariable`:** Superclase que encapsula el valor crudo en su variable de instancia `object`. Permite desactivar una variable activa para recuperar rendimiento sin recompilar clases.
- **`ActiveVariable`:** Envoltorio (*wrapper*) para variables activas. Almacena el nombre de la variable (`name`) y los selectores de los daemons de lectura (`getDaemon`) y escritura (`setDaemon`).
- **`SpecificActiveVariable`:** Subclase de `ActiveVariable` utilizada cuando los daemons se configuran como bloques de Smalltalk (`BlockClosure`) en lugar de selectores de método. Realiza una conversión automática de clase según el tipo de daemon recibido.
- **Compilador:** Intercepta la sintaxis ordinaria de asignación y lectura, transformándola en mensajes dirigidos a la variable activa junto con el receptor `self`.

---

## 5. Colaboraciones
1. **Acceso de lectura (`fetch`):** El compilador transforma la lectura de la variable en un mensaje hacia el wrapper `ActiveVariable`, pasando al objeto contenedor (`self`). Este wrapper invoca el `getDaemon` (como mensaje al contenedor o evaluando el bloque). El get daemon es el responsable de devolver el valor de la expresión.
2. **Acceso de escritura (`assignment`):** El compilador transforma la asignación en un mensaje al wrapper junto con el nuevo valor y `self`. El wrapper invoca el `setDaemon`, el cual es responsable de efectuar la mutación real sobre la variable.

---

## 6. Consecuencias

### Ventajas:
- **Transparencia total:** El código que lee o escribe sobre las variables se escribe de manera normal, sin agregados manuales ni setters explícitos.
- **Flexibilidad por instancia:** Es posible alterar o reemplazar los daemons en tiempo de ejecución para instancias puntuales enviando mensajes como `set:getDaemon:setDaemon:`.
- **Polimorfismo entre métodos y bloques:** Si se provee un selector se despacha como mensaje; si se asigna un bloque, la variable se promueve automáticamente a `SpecificActiveVariable`.

### Desventajas / Consideraciones:
- **Sobrecarga de rendimiento:** Cada lectura y escritura implica indirección de mensajes y evaluación de daemons. Por esta razón se provee `asInactiveVariable`.
- **Dependencia del compilador:** Requiere modificar el compilador base de Smalltalk-80 y los mensajes de creación de clases y métodos.
- **No generalizable a objetos arbitrarios:** Los autores aclaran que el alcance está restringido a variables (de instancia y temporales) y no resuelve el concepto de *Active Objects* generalizados.

---

## 7. Detalles de Implementación en Smalltalk-80

1. **Declaración en clases:** Se extiende el protocolo de creación de clases en `Class` (`subclass:...activeVariables:...`) para registrar variables de instancia activas en la metaclase:
   ```smalltalk
   Object subclass: #Test
       instanceVariableNames: 'randomValue'
       activeVariables: '(randomValue randomGetDaemon: random:setTo:)'
       classVariableNames: ''
       poolDictionaries: ''
       category: 'Interface-Gauges'
   ```
   *(Formato de tupla: `(nombreVar getDaemonSelector setDaemonSelector)`)*.
2. **Declaración en temporales:** El compilador reconoce tuplas dentro de la barra de temporales de cualquier método: `| x (av getFn setFn) |`.
3. **Inicialización (`basicNew`):** `basicNew` es extendido para instanciar automáticamente los wrappers `ActiveVariable` al crear objetos. En temporales, el compilador inyecta la inicialización al comienzo del método.
4. **Daemons por defecto en `Object`:**
   - `get:` y `set:to:` (comportamiento estándar base).
   - `transcriptShow:` y `transcriptShow:setTo:` (registro en el Transcript del sistema).
   - `shortStack:` y `shortStack:setTo:` (vuelca los 5 marcos superiores del contexto de ejecución en el Transcript).

---

## 8. Código de Ejemplo (Smalltalk-80)

Definición de daemons personalizados para coerción y cálculo dinámico:

```smalltalk
Test methodsFor: 'daemons'
randomGetDaemon: av
    "Calcula y devuelve el próximo número aleatorio en cada lectura"
    ^av value next.

random: av setTo: newValue
    "Garantiza invariante de tipo antes de asignar"
    (newValue isMemberOf: Random)
        ifFalse: [ ^av value: Random new ].
    ^av value: newValue.
```

Uso de temporales activas:

```smalltalk
Test methodsFor: 'examples'
test2
    | (x randomGetDaemon: nil) |
    x := Random new.
    ^Array with: x with: x with: x.  "Cada acceso a 'x' evalúa el daemon y produce un número distinto"
```

---

## 9. Usos Conocidos en el Entorno
- **`Interface-Gauges` / `LCD`:** Integración gráfica de la variable `'randomValue'` con un widget LCD que actualiza su display cada vez que el valor muta (`LCD onVar: 'randomValue' of: t`).
- **Depuración no intrusiva:** Conectar temporalmente `shortStack:` a una variable para capturar qué método o proceso está alterando su estado de manera inesperada.
- **`Advised Methods`:** Herramienta complementaria en los navegadores de Smalltalk (*browsers*) para inyectar bloques antes y después de métodos arbitrarios sin recompilar manualmente.

---

## 10. Patrones y Mecanismos Relacionados
- **Observer / Dependency Mechanism:** Alternativa directa al esquema `changed:` y `update:` de Smalltalk, trasladando la notificación a nivel de variable en lugar de nivel de objeto.
- **Proxy / Decorator:** `ActiveVariable` actúa como un wrapper o proxy interceptor sobre la referencia del objeto real almacenado.
- **Strategy:** Los bloques y selectores de daemons permiten parametrizar de forma intercambiable la estrategia de acceso y mutación.