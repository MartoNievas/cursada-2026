# Resumen del Paper: El Patrón Objeto Nulo (Null Object)
**Autor:** Bobby Woolf (1996)

---

### 1. Intención y Otros Nombres
* **Intención:** Proveer un sustituto para otro objeto que comparte la misma interfaz pero que en realidad no hace nada. El Objeto Nulo encapsula las decisiones de implementación de cómo efectivamente "no hacer nada" y esconde esos detalles de sus colaboradores.
* **Otros Nombres:** *Stub*, *Active Nothing*.

---

### 2. Motivación y Diagnóstico
A veces una clase que requiere un colaborador necesita que el mismo no haga nada, pero a la vez desea tratarlo de la misma manera que a uno que sí posee comportamiento.

#### El Ejemplo en MVC (Smalltalk-80):
En el marco Modelo-Vista-Controlador (MVC), la Vista utiliza a su Controlador como estrategia (patrón *Strategy*) para capturar e interpretar la entrada del usuario. Sin embargo, existen **vistas de solo lectura** que no requieren capturar entrada. Como el framework exige que toda Vista posea un controlador asociado, se analizan tres alternativas:

1. **Setear el controlador en `nil` (Intento fallido):**
   * La Vista le envía constantemente mensajes al controlador (como `#isControlWanted` o `#startUp`).
   * Como `UndefinedObject` (la clase de `nil`) no entiende esos mensajes, la Vista tendría que llenar su código de chequeos condicionales (`if (controlador != nil)`), lo cual ensucia la implementación y destruye la reutilización.
2. **Usar un controlador real en "modo solo lectura" (Solución ineficiente):**
   * Configurar un controlador estándar con modificadores de estado para que opere en modo lectura.
   * Agrega complejidad innecesaria al evaluar un modo interno en un objeto que siempre será inactivo.
3. **Solución con el Objeto Nulo (`NoController`):**
   * Crear una subclase concreta llamada `NoController` que implementa toda la interfaz de un `Controller`, pero "no hace nada": ante `#isControlWanted` responde `false`, y ante `#startUp` simplemente no ejecuta ninguna acción y devuelve `^self`.
   * Permite a la Vista interactuar de forma transparente y polimórfica sin condicionales.

---

### 3. Aplicabilidad
El patrón Objeto Nulo se utiliza cuando:
* Un objeto requiere un colaborador existente.
* Algunas instancias del objeto poseen colaboradores que no deben hacer nada.
* Se busca que los clientes ignoren si tratan con un colaborador real o uno nulo (evitando chequeos explícitos de `nil`).
* Se desea centralizar y reutilizar la lógica de "no hacer nada" entre múltiples clientes de manera consistente.

---

### 4. Estructura y Participantes

```
  Cliente (Vista) -------> ObjetoAbstracto (Controlador)
                                 /            \
                                /              \
              ObjetoReal (TextController)    ObjetoNulo (NoController)
                    [request útil]              ["do nothing"]
```

* **Cliente (`Client` / Vista):** Requiere e invoca al colaborador.
* **Objeto Abstracto (`AbstractObject` / Controlador):** Declara la interfaz común del colaborador e implementa el comportamiento por defecto.
* **Objeto Real (`RealObject` / ControladorDeTexto):** Subclase concreta con comportamiento útil real.
* **Objeto Nulo (`NullObject` / `NoController`):** Subclase concreta que implementa la interfaz completa para "no hacer nada" o devolver respuestas nulas.

---

### 5. Colaboraciones
Los clientes interactúan exclusivamente mediante la interfaz de `ObjetoAbstracto`. Si el receptor es un `ObjetoReal`, se ejecuta la lógica de negocio; si es un `ObjetoNulo`, responde no ejecutando acciones o devolviendo un valor nulo estándar.

---

### 6. Consecuencias

#### Ventajas:
* **Simplifica el código del cliente:** Elimina los chequeos condicionales (`if != nil`), permitiendo un tratamiento polimórfico unificado.
* **Encapsula el comportamiento nulo:** Centraliza la lógica de "no hacer nada" en una clase dedicada, evitando duplicar constantes o valores por defecto.
* **Facilita la reutilización:** Múltiples clientes comparten la misma clase o instancia nula.

#### Desventajas / Consideraciones:
* **Proliferación de clases:** Puede requerir crear un `ObjetoNulo` dedicado por cada `ObjetoAbstracto`.
* **Dificultad ante falta de consenso:** Si distintos clientes discrepan sobre cómo debe comportarse la nada, se requieren varias clases nulas o configuraciones complejas.
* **Inmutabilidad de rol:** Un `ObjetoNulo` es estático y no muta a un `ObjetoReal` por sí solo.

---

### 7. Detalles de Implementación

1. **Objeto Nulo como Singleton:** Al carecer de estado mutable, se implementa frecuentemente como un *Singleton* para compartir una única instancia en todo el sistema.
2. **Instancia nula especial de un Objeto Real:** Para evitar la proliferación de subclases, se puede usar una instancia del `ObjetoReal` configurada con colecciones vacías o atributos nulos (ej. un objeto compuesto sin hijos).
3. **Uso de Flyweight:** Si varios clientes necesitan parametrizar el comportamiento nulo en tiempo de ejecución, se emplean instancias nulas administradas como *Flyweight*.
4. **Diferencia con Proxy:** Un `ObjetoNulo` sustituye al objeto real para desactivar acciones; un *Proxy* controla el acceso a un objeto real existente o diferido.
5. **No es un Mixin:** El `ObjetoNulo` es un colaborador concreto por delegación, no un comportamiento mezclado dinámicamente.

---

### 8. Código de Ejemplo (Smalltalk - `NullScope`)
En la jerarquía de `NameScope` de VisualWorks Smalltalk, la clase `NullScope` representa el alcance (*scope*) más externo del compilador:
* Hereda `outerScope` pero no lo utiliza.
* Implementa `variableAt:from:` devolviendo `nil` y `namesAndValuesDo:` haciendo "nada".
* Implementa el caso especial `undeclared:from:` para registrar variables no declaradas cuando la búsqueda en los scopes anteriores falla.

---

### 9. Usos Conocidos
* **`NoController`:** Controlador inactivo en Smalltalk-80 para vistas de solo lectura.
* **`NullDragMode`:** Modo de arrastre inactivo para elementos gráficos de tamaño fijo.
* **`NullInputManager`:** Manejador de entrada para sistemas sin soporte de internacionalización.
* **`NullScope`:** Ámbito raíz o de bloques limpios que detiene la búsqueda de variables.
* **`NullLayoutManager`:** Alternativa a `nil` en contenedores Java AWT que no requieren un gestor de diseño.
* **`Null_Mutex` / `NullLock`:** Mecanismos de exclusión mutua inactivos para entornos monohilo.
* **`NullIterator`:** Iterador para nodos hoja o colecciones vacías que responde siempre `true` al mensaje `#isDone`.
* **`Z-Node`:** Nodos ficticios en estructuras de datos (listas/árboles) para evitar chequeos de bordes nulos.

---

### 10. Patrones Relacionados
* **Strategy:** El `ObjetoNulo` suele actuar como la estrategia concreta que representa la opción de "no hacer nada".
* **State:** Representa el estado donde las operaciones no producen efectos laterales.
* **Iterator:** Se manifiesta como un `NullIterator` en estructuras vacías.
* **Adapter:** Funciona como un `NullAdapter` que simula adaptar una interfaz sin transformar datos.
* **Singleton / Flyweight:** Patrones empleados para la gestión y reutilización de la instancia nula.
