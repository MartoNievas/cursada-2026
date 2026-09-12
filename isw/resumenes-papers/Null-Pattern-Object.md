# Resumen del Paper: El Patrón Objeto Nulo (Null Object)
*Autor: Bobby Woolf (1996)*

---

## Intención
Proveer un sustituto para otro objeto que comparte la misma interfaz pero que en realidad no hace nada. El Objeto Nulo encapsula las decisiones de implementación de cómo efectivamente "no hacer nada" y esconde esos detalles de sus colaboradores.

### Otros Nombres
* **Stub**
* **Active Nothing**

---

## Motivación

A veces una clase que requiere un colaborador necesita que el mismo no haga nada. Pero a la vez, la clase desea tratarlo de la misma manera que trata a uno que sí tenga comportamiento.

En el paper se menciona el ejemplo de Modelo-Vista-Controlador (MVC) en Smalltalk-80, el cual también es un ejemplo del patrón **Strategy** (donde el Controlador es la estrategia de la Vista para capturar e interpretar datos del usuario). Se introduce este ejemplo para mostrar que existen vistas de solo lectura que no requieren capturar entrada del usuario. Sin embargo, por cómo está estructurado el framework, la `Vista` requiere obligatoriamente tener un controlador asociado.

El paper analiza el problema a través de tres alternativas:

1. **Setear el controlador como `nil` (Primera alternativa tentativa):**
   * No funciona porque la `Vista` constantemente envía mensajes a su controlador que solo los controladores saben responder (como `#isControlWanted` o `#startUp`).
   * Como `UndefinedObject` (la clase a la que pertenece `nil`) no sabe responder estos mensajes, la `Vista` debería chequear si existe el controlador antes de usarlo (`if (controlador != nil) { ... }`) y decidir qué hacer en cada caso.
   * Este código condicional ensuciaría la implementación de la `Vista` y sería difícil de reutilizar en múltiples vistas de solo lectura.

2. **Usar un controlador de solo lectura con estado interno:**
   * Configurar un controlador estándar para que opere en "modo solo lectura".
   * Esto agrega una complejidad innecesaria (gestionar estados o modos internos) a un objeto que siempre será inactivo y que no debería necesitar evaluar su modo actual para procesar inputs.

3. **Solución con el Objeto Nulo (`NoController`):**
   * Crear una subclase concreta especial llamada `NoController` (NoControlador).
   * Implementa toda la interfaz de un `Controller`, pero sus métodos están escritos para "no hacer nada": ante `#isControlWanted` responde directamente `false`, y ante `#startUp` simplemente no ejecuta ninguna acción y se devuelve a sí mismo (`^self`).
   * Permite que la `Vista` le envíe mensajes de forma totalmente transparente sin alterar su código ni usar condicionales.

---

## Aplicabilidad

El patrón Objeto Nulo puede usarse cuando:
* Un objeto requiere de un colaborador (utilizando una relación de colaboración ya existente).
* Las instancias tienen colaboradores que no hacen nada.
* Se requiere que los clientes puedan ignorar la diferencia entre tratar con un colaborador real (con comportamiento) y uno nulo, evitando chequeos explícitos de `nil` o valores especiales.
* Se busca reutilizar la lógica de "no hacer nada" entre múltiples clientes de manera consistente.
* Todo el comportamiento de "no hacer nada" queda encapsulado dentro de la clase del colaborador.

---

## Estructura y Participantes

* **Cliente (`Client` / Vista):** Objeto que requiere y utiliza al colaborador.
* **Objeto Abstracto (`AbstractObject` / Controlador):** Declara la interfaz común del colaborador e implementa el comportamiento por defecto.
* **Objeto Real (`RealObject` / ControladorDeTexto):** Subclase concreta cuyos objetos tienen un comportamiento útil esperado por el cliente.
* **Objeto Nulo (`NullObject` / NoController):** Subclase concreta que provee una interfaz idéntica al `ObjetoAbstracto`, pero implementa sus métodos para "hacer nada" o devolver resultados nulos.

---

## Colaboraciones

Los clientes interactúan siempre a través de la interfaz del `ObjetoAbstracto`. Si el receptor es un `ObjetoReal`, se ejecuta comportamiento útil real. Si el receptor es un `ObjetoNulo`, este responde no haciendo nada o devolviendo una respuesta nula acorde a lo esperado.

---

## Consecuencias

### Ventajas
* **Simplifica el código del cliente:** Elimina los chequeos condicionales (`if != nil`), permitiendo tratar a todos los colaboradores de forma polimórfica e idéntica.
* **Encapsula el código de "no hacer nada":** Centraliza la lógica nula dentro de una clase dedicada, evitando desparramar constantes o variables nulas.
* **Facilita la reutilización:** Permite que múltiples clientes compartan la misma instancia o comportamiento nulo de forma consistente.

### Desventajas / Consideraciones
* **Proliferación de clases:** Puede requerir crear una clase de `ObjetoNulo` por cada clase de `ObjetoAbstracto`.
* **Dificultad ante falta de consenso:** Si diferentes clientes discrepan sobre cómo debe "no hacer nada" el objeto, se requiere mayor complejidad (varias clases nulas o configuraciones extrínsecas).
* **Inmutabilidad de rol:** Un `ObjetoNulo` nunca muta dinámicamente a un `ObjetoReal` por sí solo.

---

## Detalles de Implementación

1. **Objeto Nulo como Singleton:** Dado que carece de estado mutable, frecuentemente se implementa como un Singleton para compartir una única instancia en todo el sistema.
2. **Instancia nula especial de un Objeto Real:** Para evitar la creación de subclases, se puede usar una instancia del `ObjetoReal` con atributos/colecciones vacías (ej. un objeto compuesto con una lista vacía).
3. **Uso de Flyweight:** Si varios clientes necesitan parametrizar el comportamiento nulo en tiempo de ejecución, se pueden emplear instancias nulas gestionadas como Flyweight.
4. **Diferencia con Proxy:** Un `ObjetoNulo` reemplaza al objeto real y no muta a comportamiento activo. Un `Proxy` controla el acceso a un objeto real existente o diferido.
5. **Diferencia con Mixin:** El `ObjetoNulo` es una clase concreta colaboradora, no un comportamiento mezclado dinámicamente dentro de otra clase.

---

## Usos Conocidos

* **`NoController` (Smalltalk-80):** Controlador para vistas de solo lectura.
* **`NullDragMode`:** Modo de arrastre inactivo para elementos gráficos que no permiten cambio de tamaño.
* **`NullInputManager`:** Manejador para plataformas que no soportan internacionalización.
* **`NullScope`:** Representa el alcance (*scope*) más externo en el compilador de Smalltalk, deteniendo la búsqueda de variables en la jerarquía `NameScope`.
* **`NullLayoutManager`:** Alternativa a `nil` en contenedores AWT que no requieren un gestor de diseño.
* **`Null_Mutex` / `NullLock`:** Cerrojos nulos para entornos monohilo o accesos sin exclusión mutua.
* **`NullIterator`:** Iterador para nodos hoja o colecciones vacías que responde siempre `true` al mensaje `#isDone`.
* **`Z-Node`:** Nodos ficticios en estructuras de datos (listas/árboles) para evitar chequeos de bordes nulos.

---

## Patrones Relacionados

* **Strategy:** El `ObjetoNulo` suele ser una estrategia concreta que representa la opción de "no hacer nada".
* **State:** Puede actuar como un estado concreto donde las operaciones no producen efectos de cambio de estado.
* **Iterator:** Se manifiesta como un `NullIterator` para estructuras sin elementos.
* **Adapter:** Se utiliza como un `NullAdapter` que simula adaptar una interfaz sin realizar transformaciones reales.
* **Singleton / Flyweight:** Patrones comúnmente aplicados para la creación y compartición de instancias de Objetos Nulos.
