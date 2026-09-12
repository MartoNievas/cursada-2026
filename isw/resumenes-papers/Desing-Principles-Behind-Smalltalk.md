# Design Principles Behind Smalltalk

## Introducción

El paper trata sobre el proyecto Smalltalk, el cual describe al mismo como una forma de brindar herramientas computacionales que apoyen el potencial creativo de las personas, combinando el mejor hardware disponible con una visión centrada en el individuo creativo.

El proyecto se enfoca en dos aspectos clave:

- **Lenguaje de descripción:** Un lenguaje de programación que conecta los modelos mentales humanos con el hardware.
- **Lenguaje de interacción:** Una interfaz de usuario que facilita la comunicación natural entre humanos y computadoras.

El desarrollo del sistema sigue un ciclo de iteración parecido al método científico:

- Construir un programa de aplicación dentro del sistema actual (hacer una observación).
- Basado en esta experiencia, rediseñar el lenguaje (construir una teoría).
- Construir un nuevo sistema basado en el nuevo diseño (predicción verificable).

Smalltalk-80 es la cuarta iteración de este proceso.

**Dominio Personal:** Si un sistema es para servir al espíritu creativo, debe ser completamente entendible para un individuo solitario.

**Buen diseño:** Esto nos sugiere que un sistema debe ser construido con un mínimo de partes no modificables y que sean lo más generales posibles, además de estar mantenidas en un esquema uniforme.

---

## Lenguaje

Al crear un lenguaje es útil inspirarse en cómo piensan y se comunican los humanos, ya que los mecanismos de pensamiento y comunicación se han pulido durante millones de años. Pensarlos así nos podría ahorrar tiempo, ya que serían compatibles con la mente humana.

En el paper se mencionan dos conceptos clave:

- **Comunicación implícita:** Incluye las suposiciones relevantes comunes a los dos seres.
- **Comunicación explícita:** Incluye la información que es transmitida en determinado mensaje.

Esto también aplica a la interacción entre una persona y una computadora. Para diseñar un lenguaje computacional eficaz, es esencial considerar:

- Los modelos mentales internos del usuario.
- Los medios de interacción externos al sistema.

### Propósito del Lenguaje

El propósito de un lenguaje es proveer un esquema para la comunicación.

En la comunicación humana, gran parte del significado surge del contexto compartido. El lenguaje natural depende en gran medida de estas referencias implícitas.

Lo mismo se puede aplicar a las computadoras: estas pueden ser vistas como participantes de una conversación.

- Su "cuerpo" es la interfaz (pantalla, teclado, mouse, etc.), la cual permite mostrar y recibir información.
- Su "mente" está compuesta por la memoria y el procesador interno; podría decirse que en general es el hardware.

---

## Objetos que se Comunican

La mente observa un universo de experiencia; si uno quiere tomar parte de ese universo tenemos que hacer lo siguiente:

- Identificar un objeto específico del universo.
- Reconocerlo como un objeto único, es decir, separar a ese objeto de todo lo que no es ese objeto.

Para facilitar la comunicación y el pensamiento, asignamos un nombre o identificador único al objeto, lo que nos permite referirnos a él fácilmente en el futuro, sin repetir todo el proceso de identificación.

Como consecuencia, un sistema de computación debe:

- Proveer modelos de objetos que reflejen este proceso mental.
- Permitir que los objetos tengan identidad, nombre y una forma de comunicación.

### Objetos

El administrador de almacenamiento de Smalltalk provee un modelo orientado a objetos de la memoria de todo el sistema.

- Cada objeto recibe un identificador único (un entero), lo que permite una referenciación uniforme.
- Esta uniformidad facilita que las variables puedan apuntar a cualquier tipo de valor, manteniendo una estructura simple a nivel de memoria.
- Los objetos se crean al evaluar expresiones y pueden circular libremente gracias a la identificación uniforme.
- No es necesario almacenar objetos dentro de los procedimientos, basta con la referencia.
- Tiene una especie de garbage collector: cuando todas las referencias del sistema desaparecen, el objeto se esfuma de la memoria.

### Administración del Almacenamiento

Para que un lenguaje sea auténticamente orientado a objetos, debe contar con manejo automático de la memoria.

Una forma de ver que un lenguaje está funcionando bien es observar si los programas parecen estar haciendo lo que hacen. Si están repletos de instrucciones de administración de memoria, entonces su modelo interno no está bien adaptado a los humanos.

En la mente humana:

- Cada objeto mental tiene su propio almacenamiento y procesamiento.
- Vive su "propia vida" sin depender de que otro le administre el espacio constantemente.

### Mensajes

La computación debería ser vista como la capacidad intrínseca de los objetos de poder ser invocados uniformemente enviándoles mensajes.

El control del sistema se ensucia si debe ser tratado intrínsecamente. Pongamos de ejemplo el lenguaje C y el proceso de sumarle 5 a un número: el compilador tiene que averiguar el tipo de número que es y genera el código para sumarle 5. En un lenguaje orientado a objetos esto no está bien, ya que los tipos de los objetos no pueden ser determinados en tiempo de compilación.

Una solución posible es llamar a una rutina general de suma que examine el tipo de los argumentos para determinar la acción apropiada, pero eso:

- Complica el sistema.
- Obliga a los usuarios novatos a modificar una parte crítica del lenguaje.
- Rompe la encapsulación, ya que los detalles internos de los objetos se dispersan por todo el sistema.

En cambio, Smalltalk tiene otro enfoque:

- Primero envía el nombre con la operación deseada junto con cualquier parámetro necesario.
- El objeto sabe por sí mismo cómo responder el mensaje.
- La única interacción externa válida es el envío de mensajes, porque los objetos deben controlar su propio comportamiento.

### Metáfora Uniforme

Un lenguaje debería ser diseñado en torno a una metáfora poderosa que pueda ser aplicada uniformemente en todas las áreas.

Existen lenguajes exitosos basados en modelos conceptuales claros:

- **LISP:** basado en listas enlazadas.
- **APL:** basado en arreglos.
- **Smalltalk:** basado en objetos que se comunican mediante mensajes.

En todos estos casos, las aplicaciones complejas se construyen siguiendo el mismo modelo que las unidades más simples del sistema.

Especialmente en Smalltalk, la interacción entre objetos simples (como números) es idéntica a la interacción de alto nivel entre el usuario y el sistema, ya que cada objeto en Smalltalk:

- Tiene un protocolo de mensajes.
- Tiene un contexto implícito, que incluye almacenamiento local y acceso a información compartida.

---

## Organización

Una metáfora uniforme provee un marco en el cual se pueden construir sistemas complejos.

Al incrementarse la cantidad de componentes de un sistema, la probabilidad de interacción no deseada crece rápidamente. Por eso, un lenguaje de computación debería ser diseñado para minimizar las posibilidades de esa interdependencia.

### Modularidad

Ningún componente en un sistema complejo debería depender de los detalles internos de ningún otro componente.

Si tenemos N componentes en un sistema, entonces hay aproximadamente $N^2$ dependencias potenciales entre ellos. Esto aumentaría rápidamente la complejidad y el riesgo de errores en sistemas grandes. Por eso, es esencial reducir la interdependencia entre componentes.

Smalltalk lo hace así:

- Usa la metáfora de envío de mensajes, lo que:
  - Desacopla la intención (el mensaje enviado) del método que lo ejecuta.
  - Protege el estado interno de los objetos: solo puede accederse a través de mensajes.

Para manejar mejor la complejidad también se agrupan componentes similares:

- En lenguajes tradicionales se usa tipado de datos.
- En Smalltalk se usan clases.

Las clases en Smalltalk:

- Describen el estado interno de sus objetos.
- Definen el protocolo de mensajes que pueden recibir.
- Contienen los métodos que responden a esos mensajes.
- Los objetos definidos por una clase se llaman instancias.

Incluso las clases mismas son objetos en Smalltalk: son instancias de la clase `Class`, lo que unifica toda la estructura del lenguaje en la misma lógica de objetos y mensajes.

### Clasificación

Un lenguaje debe proveer un medio para clasificar objetos similares y para agregar nuevas clases de objetos en pie de igualdad con las clases centrales del sistema.

Las clases son el principal mecanismo de extensión en Smalltalk, lo que permite que en cada etapa del diseño un humano elija en forma natural la representación más efectiva si el sistema la provee.

### Polimorfismo

Un programa sólo debería especificar el comportamiento esperado de los objetos, no su representación.

Lo que quiere decir es que un programa no debería depender del tipo exacto de un objeto (como `SmallInteger` o `LargeInteger`), sino solo de que responda al protocolo adecuado.

### Factorización

Cada componente independiente de un sistema sólo debería aparecer en un único lugar.

La factorización significa que cada parte del sistema debería estar definida una sola vez, para:

- Ahorrar tiempo y esfuerzo.
- Facilitar la búsqueda y el uso de componentes.
- Evitar errores por inconsistencias o duplicación.

Para este principio, Smalltalk promueve diseños bien factorizados a través de la herencia. Todas las clases heredan comportamiento de su superclase, que son cada vez más generales.

### Reaprovechamiento

Cuando un sistema está bien factorizado, un gran reaprovechamiento está disponible tanto para los usuarios como para los implementadores.

En Smalltalk, si se define un método como `sort` en la clase `OrderedCollection`, todas las secuencias del sistema heredan automáticamente esa capacidad gracias al mecanismo de herencia. Este método puede ser usado tanto para ordenar texto como números, ya que ambos tipos responden al mismo protocolo de comparación.

Ventajas para los implementadores:

- Se reduce la cantidad de primitivas que deben implementarse.
- Por ejemplo, todo el sistema gráfico de Smalltalk se basa en una única operación primitiva.
- Esto permite concentrar los esfuerzos de optimización en pocos puntos clave del sistema.

### Máquina Virtual

La máquina virtual de Smalltalk establece un modelo orientado a objetos para el almacenamiento, un modelo orientado a mensajes para el procesamiento, y un modelo de bitmap para el despliegue visual de información, a través del uso de microcódigo y eventualmente hardware.

---

## Interfaz al Usuario

Una interfaz al usuario es un lenguaje en el que la mayor parte de la comunicación es visual, ya que la presentación visual se asimila mucho a la cultura establecida por el humano.

### Principio Reactivo

Cada componente accesible al usuario debería ser capaz de presentarse de una manera entendible para ser observado y manipulado.

Notar que este criterio está bien soportado por el modelo de objetos que se comunican, ya que cada objeto tiene su propio protocolo de mensajes, como un microlenguaje.

En la interfaz de usuario, este lenguaje se muestra visualmente y se interactúa mediante teclado y mouse. Sin embargo, los sistemas operativos suelen romper esta coherencia, forzando al programador a trabajar en entornos distintos y más limitados, aunque esto no debería ser necesario.

### Sistema Operativo

Se define un sistema operativo como una colección de cosas que no encajan dentro de un lenguaje. No debería existir.

El concepto tradicional de sistema operativo desaparece porque sus funciones están integradas directamente en el lenguaje, por ejemplo:

- **Administración de memoria:** es automática, sin necesidad de intervención del programador.
- **Sistema de archivos:** representado por objetos como `File` y `Directory` con protocolos de mensajes.
- **Pantalla:** es un objeto (`Form`) que se manipula con mensajes gráficos.
- **Entrada del usuario:** el teclado y otros dispositivos son objetos con mensajes para consultar su estado.
- **Acceso a subsistema:** todo subsistema es un objeto más dentro del entorno de Smalltalk.
- **Debugger:** se realiza con objetos como `Process`, permitiendo inspeccionar y modificar el estado de ejecución.

---

## Trabajo Futuro

A futuro, se busca mejorar Smalltalk aplicando sus propios principios de diseño. Las principales áreas de desarrollo incluyen:

- **Herencia múltiple:** superar la limitación actual de herencia jerárquica para permitir una herencia más flexible.
- **Formalización de protocolos:** definir protocolos de mensajes como objetos compartibles, lo que permitiría tipado formal sin perder polimorfismo.
- **Nuevas metáforas cognitivas:** identificar aspectos del pensamiento humano aún no reflejados en el lenguaje para enriquecer su modelo.
